package main

import (
	"context"
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"log/slog"
	"net/http"
	"os"
	"os/signal"
	"strings"
	"syscall"
	"time"

	_ "github.com/go-sql-driver/mysql"
)

type config struct {
	ServiceName string
	HTTPAddr    string
	DBHost      string
	DBPort      string
	DBName      string
	DBUser      string
	DBPassword  string
}

type healthResponse struct {
	Status  string `json:"status"`
	Service string `json:"service"`
}

type readyResponse struct {
	Status  string `json:"status"`
	Service string `json:"service"`
	MySQL   string `json:"mysql"`
}

type catalogVersionResponse struct {
	Version     string    `json:"version"`
	PublishedAt time.Time `json:"publishedAt"`
}

type catalogSnapshotResponse struct {
	Version     string         `json:"version"`
	PublishedAt time.Time      `json:"publishedAt"`
	Songs       []songResponse `json:"songs"`
}

type songListItem struct {
	ID       string `json:"id"`
	Number   int    `json:"number"`
	Title    string `json:"title"`
	Category string `json:"category"`
}

type songSection struct {
	Rows   []string   `json:"rows"`
	Chords [][]string `json:"chords"`
}

type songResponse struct {
	ID       string        `json:"id"`
	Number   int           `json:"number"`
	Title    string        `json:"title"`
	Category string        `json:"category"`
	Verses   []songSection `json:"verses"`
	Chorus   *songSection  `json:"chorus,omitempty"`
	Bridge   *songSection  `json:"bridge,omitempty"`
}

type catalogVersion struct {
	ID          int64
	Version     string
	PublishedAt time.Time
}

func main() {
	cfg := loadConfig()
	logger := slog.New(slog.NewJSONHandler(os.Stdout, nil))

	db, err := openDB(cfg)
	if err != nil {
		logger.Error("database configuration failed", "error", err)
		os.Exit(1)
	}
	defer db.Close()

	mux := http.NewServeMux()
	mux.HandleFunc("GET /healthz", func(w http.ResponseWriter, r *http.Request) {
		writeJSON(w, http.StatusOK, healthResponse{
			Status:  "ok",
			Service: cfg.ServiceName,
		})
	})
	mux.HandleFunc("GET /readyz", func(w http.ResponseWriter, r *http.Request) {
		if err := checkMySQL(r.Context(), db); err != nil {
			writeJSON(w, http.StatusServiceUnavailable, readyResponse{
				Status:  "not_ready",
				Service: cfg.ServiceName,
				MySQL:   "unreachable",
			})
			return
		}

		writeJSON(w, http.StatusOK, readyResponse{
			Status:  "ready",
			Service: cfg.ServiceName,
			MySQL:   "reachable",
		})
	})
	mux.HandleFunc("GET /api/catalog/version", func(w http.ResponseWriter, r *http.Request) {
		version, err := getCurrentCatalogVersion(r.Context(), db)
		if err != nil {
			writeError(w, http.StatusServiceUnavailable, "catalog version is not available")
			return
		}

		writeJSON(w, http.StatusOK, catalogVersionResponse{
			Version:     version.Version,
			PublishedAt: version.PublishedAt,
		})
	})
	mux.HandleFunc("GET /api/catalog/snapshot", func(w http.ResponseWriter, r *http.Request) {
		snapshot, err := getCatalogSnapshot(r.Context(), db)
		if err != nil {
			logger.Error("get catalog snapshot failed", "error", err)
			writeError(w, http.StatusInternalServerError, "failed to get catalog snapshot")
			return
		}

		writeJSON(w, http.StatusOK, snapshot)
	})
	mux.HandleFunc("GET /api/songs", func(w http.ResponseWriter, r *http.Request) {
		query := strings.TrimSpace(r.URL.Query().Get("query"))
		songs, err := listSongs(r.Context(), db, query)
		if err != nil {
			logger.Error("list songs failed", "error", err)
			writeError(w, http.StatusInternalServerError, "failed to list songs")
			return
		}

		writeJSON(w, http.StatusOK, songs)
	})
	mux.HandleFunc("GET /api/songs/{id}", func(w http.ResponseWriter, r *http.Request) {
		songID := strings.TrimSpace(r.PathValue("id"))
		if songID == "" {
			writeError(w, http.StatusBadRequest, "song id is required")
			return
		}

		song, err := getSong(r.Context(), db, songID)
		if errors.Is(err, sql.ErrNoRows) {
			writeError(w, http.StatusNotFound, "song not found")
			return
		}
		if err != nil {
			logger.Error("get song failed", "error", err, "song_id", songID)
			writeError(w, http.StatusInternalServerError, "failed to get song")
			return
		}

		writeJSON(w, http.StatusOK, song)
	})

	server := &http.Server{
		Addr:              cfg.HTTPAddr,
		Handler:           requestLogger(logger, mux),
		ReadHeaderTimeout: 5 * time.Second,
	}

	ctx, stop := signal.NotifyContext(context.Background(), os.Interrupt, syscall.SIGTERM)
	defer stop()

	go func() {
		logger.Info("starting api", "addr", cfg.HTTPAddr, "db_host", cfg.DBHost, "db_port", cfg.DBPort, "db_name", cfg.DBName)
		if err := server.ListenAndServe(); err != nil && !errors.Is(err, http.ErrServerClosed) {
			logger.Error("api server failed", "error", err)
			os.Exit(1)
		}
	}()

	<-ctx.Done()
	shutdownCtx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	if err := server.Shutdown(shutdownCtx); err != nil {
		logger.Error("api server shutdown failed", "error", err)
		os.Exit(1)
	}
	logger.Info("api server stopped")
}

func loadConfig() config {
	return config{
		ServiceName: getenv("SERVICE_NAME", "christian-songbook-api"),
		HTTPAddr:    getenv("HTTP_ADDR", ":8082"),
		DBHost:      getenv("DB_HOST", "127.0.0.1"),
		DBPort:      getenv("DB_PORT", "3306"),
		DBName:      getenv("DB_NAME", "christian_songbook"),
		DBUser:      getenv("DB_USER", "songbook"),
		DBPassword:  getenv("DB_PASSWORD", "songbook"),
	}
}

func getenv(key string, fallback string) string {
	value := os.Getenv(key)
	if value == "" {
		return fallback
	}
	return value
}

func openDB(cfg config) (*sql.DB, error) {
	if cfg.DBHost == "" || cfg.DBPort == "" || cfg.DBName == "" || cfg.DBUser == "" {
		return nil, errors.New("mysql connection settings are incomplete")
	}

	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?parseTime=true&charset=utf8mb4,utf8&timeout=3s&readTimeout=5s&writeTimeout=5s",
		cfg.DBUser,
		cfg.DBPassword,
		cfg.DBHost,
		cfg.DBPort,
		cfg.DBName,
	)
	db, err := sql.Open("mysql", dsn)
	if err != nil {
		return nil, err
	}
	db.SetMaxOpenConns(10)
	db.SetMaxIdleConns(5)
	db.SetConnMaxLifetime(5 * time.Minute)
	return db, nil
}

func writeJSON(w http.ResponseWriter, status int, payload any) {
	w.Header().Set("Content-Type", "application/json; charset=utf-8")
	w.WriteHeader(status)
	if err := json.NewEncoder(w).Encode(payload); err != nil {
		slog.Error("failed to write json response", "error", err)
	}
}

func writeError(w http.ResponseWriter, status int, message string) {
	writeJSON(w, status, map[string]string{"error": message})
}

func checkMySQL(ctx context.Context, db *sql.DB) error {
	checkCtx, cancel := context.WithTimeout(ctx, 2*time.Second)
	defer cancel()
	return db.PingContext(checkCtx)
}

func getCurrentCatalogVersion(ctx context.Context, db *sql.DB) (catalogVersion, error) {
	const query = `
SELECT id, version, published_at
FROM catalog_versions
WHERE is_current = 1
ORDER BY published_at DESC, id DESC
LIMIT 1`

	var version catalogVersion
	err := db.QueryRowContext(ctx, query).Scan(&version.ID, &version.Version, &version.PublishedAt)
	return version, err
}

func listSongs(ctx context.Context, db *sql.DB, searchQuery string) ([]songListItem, error) {
	version, err := getCurrentCatalogVersion(ctx, db)
	if err != nil {
		return nil, err
	}

	const query = `
SELECT s.id, s.number, s.title, s.category
FROM songs s
WHERE s.catalog_version_id = ?
  AND s.status = 'published'
  AND (
    ? = ''
    OR s.title LIKE CONCAT('%', ?, '%')
    OR s.category LIKE CONCAT('%', ?, '%')
    OR CAST(s.number AS CHAR) = ?
    OR EXISTS (
      SELECT 1
      FROM song_sections ss
      JOIN song_lines sl ON sl.section_id = ss.id
      WHERE ss.song_id = s.id
        AND sl.text LIKE CONCAT('%', ?, '%')
      LIMIT 1
    )
  )
ORDER BY s.number ASC, s.title ASC
LIMIT 200`

	rows, err := db.QueryContext(ctx, query, version.ID, searchQuery, searchQuery, searchQuery, searchQuery, searchQuery)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	songs := make([]songListItem, 0)
	for rows.Next() {
		var item songListItem
		if err := rows.Scan(&item.ID, &item.Number, &item.Title, &item.Category); err != nil {
			return nil, err
		}
		songs = append(songs, item)
	}
	return songs, rows.Err()
}

func getCatalogSnapshot(ctx context.Context, db *sql.DB) (catalogSnapshotResponse, error) {
	version, err := getCurrentCatalogVersion(ctx, db)
	if err != nil {
		return catalogSnapshotResponse{}, err
	}

	const query = `
SELECT id
FROM songs
WHERE catalog_version_id = ? AND status = 'published'
ORDER BY number ASC, title ASC
LIMIT 200`

	rows, err := db.QueryContext(ctx, query, version.ID)
	if err != nil {
		return catalogSnapshotResponse{}, err
	}
	defer rows.Close()

	songs := make([]songResponse, 0)
	for rows.Next() {
		var songID string
		if err := rows.Scan(&songID); err != nil {
			return catalogSnapshotResponse{}, err
		}
		song, err := getSongByVersion(ctx, db, version.ID, songID)
		if err != nil {
			return catalogSnapshotResponse{}, err
		}
		songs = append(songs, song)
	}
	if err := rows.Err(); err != nil {
		return catalogSnapshotResponse{}, err
	}

	return catalogSnapshotResponse{
		Version:     version.Version,
		PublishedAt: version.PublishedAt,
		Songs:       songs,
	}, nil
}

func getSong(ctx context.Context, db *sql.DB, songID string) (songResponse, error) {
	version, err := getCurrentCatalogVersion(ctx, db)
	if err != nil {
		return songResponse{}, err
	}
	return getSongByVersion(ctx, db, version.ID, songID)
}

func getSongByVersion(ctx context.Context, db *sql.DB, catalogVersionID int64, songID string) (songResponse, error) {
	const songQuery = `
SELECT id, number, title, category
FROM songs
WHERE catalog_version_id = ? AND id = ? AND status = 'published'
LIMIT 1`

	var song songResponse
	if err := db.QueryRowContext(ctx, songQuery, catalogVersionID, songID).Scan(&song.ID, &song.Number, &song.Title, &song.Category); err != nil {
		return songResponse{}, err
	}

	sections, err := loadSongSections(ctx, db, songID)
	if err != nil {
		return songResponse{}, err
	}

	for _, section := range sections {
		switch section.SectionType {
		case "verse":
			song.Verses = append(song.Verses, section.Section)
		case "chorus":
			sectionCopy := section.Section
			song.Chorus = &sectionCopy
		case "bridge":
			sectionCopy := section.Section
			song.Bridge = &sectionCopy
		}
	}

	return song, nil
}

type loadedSection struct {
	ID          int64
	SectionType string
	Section     songSection
}

func loadSongSections(ctx context.Context, db *sql.DB, songID string) ([]loadedSection, error) {
	const sectionQuery = `
SELECT id, section_type
FROM song_sections
WHERE song_id = ?
ORDER BY position ASC, id ASC`

	sectionRows, err := db.QueryContext(ctx, sectionQuery, songID)
	if err != nil {
		return nil, err
	}
	defer sectionRows.Close()

	sections := make([]loadedSection, 0)
	sectionByID := make(map[int64]int)
	for sectionRows.Next() {
		var section loadedSection
		if err := sectionRows.Scan(&section.ID, &section.SectionType); err != nil {
			return nil, err
		}
		section.Section.Rows = []string{}
		section.Section.Chords = [][]string{}
		sectionByID[section.ID] = len(sections)
		sections = append(sections, section)
	}
	if err := sectionRows.Err(); err != nil {
		return nil, err
	}
	if len(sections) == 0 {
		return sections, nil
	}

	lineIndexByID := make(map[int64]struct {
		SectionIndex int
		LineIndex    int
	})
	const lineQuery = `
SELECT ss.id, sl.id, sl.text
FROM song_sections ss
JOIN song_lines sl ON sl.section_id = ss.id
WHERE ss.song_id = ?
ORDER BY ss.position ASC, sl.position ASC, sl.id ASC`
	lineRows, err := db.QueryContext(ctx, lineQuery, songID)
	if err != nil {
		return nil, err
	}
	defer lineRows.Close()

	for lineRows.Next() {
		var sectionID int64
		var lineID int64
		var text string
		if err := lineRows.Scan(&sectionID, &lineID, &text); err != nil {
			return nil, err
		}
		sectionIndex, ok := sectionByID[sectionID]
		if !ok {
			continue
		}
		lineIndex := len(sections[sectionIndex].Section.Rows)
		sections[sectionIndex].Section.Rows = append(sections[sectionIndex].Section.Rows, text)
		sections[sectionIndex].Section.Chords = append(sections[sectionIndex].Section.Chords, []string{})
		lineIndexByID[lineID] = struct {
			SectionIndex int
			LineIndex    int
		}{SectionIndex: sectionIndex, LineIndex: lineIndex}
	}
	if err := lineRows.Err(); err != nil {
		return nil, err
	}

	const chordQuery = `
SELECT sl.id, slc.chord
FROM song_sections ss
JOIN song_lines sl ON sl.section_id = ss.id
JOIN song_line_chords slc ON slc.line_id = sl.id
WHERE ss.song_id = ?
ORDER BY ss.position ASC, sl.position ASC, slc.position ASC, slc.id ASC`
	chordRows, err := db.QueryContext(ctx, chordQuery, songID)
	if err != nil {
		return nil, err
	}
	defer chordRows.Close()

	for chordRows.Next() {
		var lineID int64
		var chord string
		if err := chordRows.Scan(&lineID, &chord); err != nil {
			return nil, err
		}
		lineIndex, ok := lineIndexByID[lineID]
		if !ok {
			continue
		}
		sections[lineIndex.SectionIndex].Section.Chords[lineIndex.LineIndex] = append(
			sections[lineIndex.SectionIndex].Section.Chords[lineIndex.LineIndex],
			chord,
		)
	}
	return sections, chordRows.Err()
}

func requestLogger(logger *slog.Logger, next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		start := time.Now()
		next.ServeHTTP(w, r)
		logger.Info("request", "method", r.Method, "path", r.URL.Path, "duration_ms", time.Since(start).Milliseconds())
	})
}

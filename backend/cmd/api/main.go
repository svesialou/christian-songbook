package main

import (
	"context"
	"crypto/subtle"
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"log/slog"
	"net/http"
	"os"
	"os/signal"
	"strconv"
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
	AdminAPIKey string
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

type songSubmissionRequest struct {
	Title          string `json:"title"`
	Category       string `json:"category"`
	DefaultKey      string `json:"defaultKey"`
	Lyrics         string `json:"lyrics"`
	Chords         string `json:"chords"`
	SubmitterName  string `json:"submitterName"`
	SubmitterEmail string `json:"submitterEmail"`
	Note           string `json:"note"`
}

type songSubmissionCreatedResponse struct {
	ID     int64  `json:"id"`
	Status string `json:"status"`
}

type songSubmissionListItem struct {
	ID             int64     `json:"id"`
	Title          string    `json:"title"`
	Category       string    `json:"category"`
	DefaultKey      string    `json:"defaultKey"`
	Lyrics         string    `json:"lyrics"`
	Chords         string    `json:"chords"`
	SubmitterName  string    `json:"submitterName"`
	SubmitterEmail string    `json:"submitterEmail"`
	Note           string    `json:"note"`
	Status         string    `json:"status"`
	CreatedAt      time.Time `json:"createdAt"`
}

type approveSubmissionResponse struct {
	SongID         string `json:"songId"`
	CatalogVersion string `json:"catalogVersion"`
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
	mux.HandleFunc("POST /api/song-submissions", func(w http.ResponseWriter, r *http.Request) {
		var payload songSubmissionRequest
		if err := readJSON(w, r, &payload); err != nil {
			writeError(w, http.StatusBadRequest, "invalid submission payload")
			return
		}

		id, err := createSongSubmission(r.Context(), db, payload)
		if errors.Is(err, errValidation) {
			writeError(w, http.StatusBadRequest, err.Error())
			return
		}
		if err != nil {
			logger.Error("create song submission failed", "error", err)
			writeError(w, http.StatusInternalServerError, "failed to create song submission")
			return
		}

		writeJSON(w, http.StatusCreated, songSubmissionCreatedResponse{ID: id, Status: "pending"})
	})
	mux.HandleFunc("GET /api/admin/song-submissions", func(w http.ResponseWriter, r *http.Request) {
		if !requireAdmin(w, r, cfg) {
			return
		}

		submissions, err := listSongSubmissions(r.Context(), db)
		if err != nil {
			logger.Error("list song submissions failed", "error", err)
			writeError(w, http.StatusInternalServerError, "failed to list song submissions")
			return
		}

		writeJSON(w, http.StatusOK, submissions)
	})
	mux.HandleFunc("POST /api/admin/song-submissions/{id}/approve", func(w http.ResponseWriter, r *http.Request) {
		if !requireAdmin(w, r, cfg) {
			return
		}

		submissionID, err := strconv.ParseInt(strings.TrimSpace(r.PathValue("id")), 10, 64)
		if err != nil || submissionID <= 0 {
			writeError(w, http.StatusBadRequest, "valid submission id is required")
			return
		}

		result, err := approveSongSubmission(r.Context(), db, submissionID)
		if errors.Is(err, sql.ErrNoRows) {
			writeError(w, http.StatusNotFound, "pending submission not found")
			return
		}
		if errors.Is(err, errValidation) {
			writeError(w, http.StatusBadRequest, err.Error())
			return
		}
		if err != nil {
			logger.Error("approve song submission failed", "error", err, "submission_id", submissionID)
			writeError(w, http.StatusInternalServerError, "failed to approve song submission")
			return
		}

		writeJSON(w, http.StatusOK, result)
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
		AdminAPIKey: getenv("ADMIN_API_KEY", ""),
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

func readJSON(w http.ResponseWriter, r *http.Request, target any) error {
	r.Body = http.MaxBytesReader(w, r.Body, 64*1024)
	decoder := json.NewDecoder(r.Body)
	decoder.DisallowUnknownFields()
	return decoder.Decode(target)
}

func writeError(w http.ResponseWriter, status int, message string) {
	writeJSON(w, status, map[string]string{"error": message})
}

var errValidation = errors.New("validation failed")

func validationError(message string) error {
	return fmt.Errorf("%w: %s", errValidation, message)
}

func requireAdmin(w http.ResponseWriter, r *http.Request, cfg config) bool {
	if cfg.AdminAPIKey == "" {
		writeError(w, http.StatusServiceUnavailable, "admin api is not configured")
		return false
	}

	if subtle.ConstantTimeCompare([]byte(r.Header.Get("X-Admin-Key")), []byte(cfg.AdminAPIKey)) != 1 {
		writeError(w, http.StatusUnauthorized, "admin access denied")
		return false
	}

	return true
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

func createSongSubmission(ctx context.Context, db *sql.DB, payload songSubmissionRequest) (int64, error) {
	normalized, err := normalizeSongSubmission(payload)
	if err != nil {
		return 0, err
	}

	const query = `
INSERT INTO song_submissions (
  title, category, default_key, lyrics, chords, submitter_name, submitter_email, note
) VALUES (?, ?, NULLIF(?, ''), ?, NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''))`

	result, err := db.ExecContext(
		ctx,
		query,
		normalized.Title,
		normalized.Category,
		normalized.DefaultKey,
		normalized.Lyrics,
		normalized.Chords,
		normalized.SubmitterName,
		normalized.SubmitterEmail,
		normalized.Note,
	)
	if err != nil {
		return 0, err
	}

	return result.LastInsertId()
}

func listSongSubmissions(ctx context.Context, db *sql.DB) ([]songSubmissionListItem, error) {
	const query = `
SELECT
  id,
  title,
  category,
  COALESCE(default_key, ''),
  lyrics,
  COALESCE(chords, ''),
  COALESCE(submitter_name, ''),
  COALESCE(submitter_email, ''),
  COALESCE(note, ''),
  status,
  created_at
FROM song_submissions
WHERE status = 'pending'
ORDER BY created_at ASC, id ASC
LIMIT 100`

	rows, err := db.QueryContext(ctx, query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	submissions := make([]songSubmissionListItem, 0)
	for rows.Next() {
		var item songSubmissionListItem
		if err := rows.Scan(
			&item.ID,
			&item.Title,
			&item.Category,
			&item.DefaultKey,
			&item.Lyrics,
			&item.Chords,
			&item.SubmitterName,
			&item.SubmitterEmail,
			&item.Note,
			&item.Status,
			&item.CreatedAt,
		); err != nil {
			return nil, err
		}
		submissions = append(submissions, item)
	}

	return submissions, rows.Err()
}

func approveSongSubmission(ctx context.Context, db *sql.DB, submissionID int64) (approveSubmissionResponse, error) {
	tx, err := db.BeginTx(ctx, nil)
	if err != nil {
		return approveSubmissionResponse{}, err
	}
	defer tx.Rollback()

	var submission songSubmissionRequest
	const submissionQuery = `
SELECT title, category, COALESCE(default_key, ''), lyrics, COALESCE(chords, '')
FROM song_submissions
WHERE id = ? AND status = 'pending'
FOR UPDATE`
	if err := tx.QueryRowContext(ctx, submissionQuery, submissionID).Scan(
		&submission.Title,
		&submission.Category,
		&submission.DefaultKey,
		&submission.Lyrics,
		&submission.Chords,
	); err != nil {
		return approveSubmissionResponse{}, err
	}

	normalized, err := normalizeSongSubmission(submission)
	if err != nil {
		return approveSubmissionResponse{}, err
	}
	lyrics := splitNonEmptyLines(normalized.Lyrics)
	chords := splitChordLines(normalized.Chords)

	var version catalogVersion
	const versionQuery = `
SELECT id, version, published_at
FROM catalog_versions
WHERE is_current = 1
ORDER BY published_at DESC, id DESC
LIMIT 1
FOR UPDATE`
	if err := tx.QueryRowContext(ctx, versionQuery).Scan(&version.ID, &version.Version, &version.PublishedAt); err != nil {
		return approveSubmissionResponse{}, err
	}

	var nextNumber int
	if err := tx.QueryRowContext(ctx, `SELECT COALESCE(MAX(number), 0) + 1 FROM songs WHERE catalog_version_id = ?`, version.ID).Scan(&nextNumber); err != nil {
		return approveSubmissionResponse{}, err
	}

	songID := fmt.Sprintf("submission-%d", submissionID)
	if _, err := tx.ExecContext(
		ctx,
		`INSERT INTO songs (id, catalog_version_id, number, title, category, default_key, status) VALUES (?, ?, ?, ?, ?, NULLIF(?, ''), 'published')`,
		songID,
		version.ID,
		nextNumber,
		normalized.Title,
		normalized.Category,
		normalized.DefaultKey,
	); err != nil {
		return approveSubmissionResponse{}, err
	}

	sectionResult, err := tx.ExecContext(
		ctx,
		`INSERT INTO song_sections (song_id, section_type, position, title) VALUES (?, 'verse', 1, 'Куплет 1')`,
		songID,
	)
	if err != nil {
		return approveSubmissionResponse{}, err
	}
	sectionID, err := sectionResult.LastInsertId()
	if err != nil {
		return approveSubmissionResponse{}, err
	}

	for index, line := range lyrics {
		lineResult, err := tx.ExecContext(
			ctx,
			`INSERT INTO song_lines (section_id, position, text) VALUES (?, ?, ?)`,
			sectionID,
			index+1,
			line,
		)
		if err != nil {
			return approveSubmissionResponse{}, err
		}
		lineID, err := lineResult.LastInsertId()
		if err != nil {
			return approveSubmissionResponse{}, err
		}

		if index >= len(chords) {
			continue
		}
		for chordIndex, chord := range chords[index] {
			if _, err := tx.ExecContext(
				ctx,
				`INSERT INTO song_line_chords (line_id, position, chord) VALUES (?, ?, ?)`,
				lineID,
				chordIndex+1,
				chord,
			); err != nil {
				return approveSubmissionResponse{}, err
			}
		}
	}

	nextVersion := fmt.Sprintf("submission-%d-%s", submissionID, time.Now().UTC().Format("20060102150405"))
	if _, err := tx.ExecContext(
		ctx,
		`UPDATE catalog_versions SET version = ?, published_at = UTC_TIMESTAMP(), notes = ? WHERE id = ?`,
		nextVersion,
		fmt.Sprintf("Approved song submission #%d", submissionID),
		version.ID,
	); err != nil {
		return approveSubmissionResponse{}, err
	}

	if _, err := tx.ExecContext(
		ctx,
		`UPDATE song_submissions SET status = 'approved', submitted_song_id = ?, reviewed_at = UTC_TIMESTAMP() WHERE id = ?`,
		songID,
		submissionID,
	); err != nil {
		return approveSubmissionResponse{}, err
	}

	if err := tx.Commit(); err != nil {
		return approveSubmissionResponse{}, err
	}

	return approveSubmissionResponse{SongID: songID, CatalogVersion: nextVersion}, nil
}

func normalizeSongSubmission(payload songSubmissionRequest) (songSubmissionRequest, error) {
	normalized := songSubmissionRequest{
		Title:          strings.TrimSpace(payload.Title),
		Category:       strings.TrimSpace(payload.Category),
		DefaultKey:      strings.TrimSpace(payload.DefaultKey),
		Lyrics:         strings.TrimSpace(payload.Lyrics),
		Chords:         strings.TrimSpace(payload.Chords),
		SubmitterName:  strings.TrimSpace(payload.SubmitterName),
		SubmitterEmail: strings.TrimSpace(payload.SubmitterEmail),
		Note:           strings.TrimSpace(payload.Note),
	}
	if normalized.Category == "" {
		normalized.Category = "Общее"
	}

	switch {
	case normalized.Title == "":
		return songSubmissionRequest{}, validationError("title is required")
	case tooLong(normalized.Title, 255):
		return songSubmissionRequest{}, validationError("title is too long")
	case tooLong(normalized.Category, 128):
		return songSubmissionRequest{}, validationError("category is too long")
	case tooLong(normalized.DefaultKey, 16):
		return songSubmissionRequest{}, validationError("default key is too long")
	case normalized.Lyrics == "":
		return songSubmissionRequest{}, validationError("lyrics are required")
	case len(splitNonEmptyLines(normalized.Lyrics)) == 0:
		return songSubmissionRequest{}, validationError("lyrics must contain text lines")
	case tooLong(normalized.Lyrics, 12000):
		return songSubmissionRequest{}, validationError("lyrics are too long")
	case tooLong(normalized.Chords, 12000):
		return songSubmissionRequest{}, validationError("chords are too long")
	case tooLong(normalized.SubmitterName, 128):
		return songSubmissionRequest{}, validationError("submitter name is too long")
	case tooLong(normalized.SubmitterEmail, 255):
		return songSubmissionRequest{}, validationError("submitter email is too long")
	case tooLong(normalized.Note, 1000):
		return songSubmissionRequest{}, validationError("note is too long")
	}

	return normalized, nil
}

func splitNonEmptyLines(value string) []string {
	rawLines := strings.Split(value, "\n")
	lines := make([]string, 0, len(rawLines))
	for _, rawLine := range rawLines {
		line := strings.TrimSpace(rawLine)
		if line == "" {
			continue
		}
		lines = append(lines, line)
	}
	return lines
}

func splitChordLines(value string) [][]string {
	rawLines := strings.Split(value, "\n")
	lines := make([][]string, 0, len(rawLines))
	for _, rawLine := range rawLines {
		lines = append(lines, strings.Fields(rawLine))
	}
	return lines
}

func tooLong(value string, limit int) bool {
	return len([]rune(value)) > limit
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

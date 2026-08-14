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

type songPlayback struct {
	BPM          int  `json:"bpm"`
	BeatsPerLine int  `json:"beatsPerLine"`
	IntroBeats   *int `json:"introBeats,omitempty"`
}

type songResponse struct {
	ID         string        `json:"id"`
	Number     int           `json:"number"`
	Title      string        `json:"title"`
	Category   string        `json:"category"`
	DefaultKey string        `json:"defaultKey,omitempty"`
	Playback   *songPlayback `json:"playback,omitempty"`
	Verses     []songSection `json:"verses"`
	Chorus     *songSection  `json:"chorus,omitempty"`
	Bridge     *songSection  `json:"bridge,omitempty"`
}

type catalogVersion struct {
	ID          int64
	Version     string
	PublishedAt time.Time
}

type songSubmissionRequest struct {
	Title          string `json:"title"`
	Category       string `json:"category"`
	DefaultKey     string `json:"defaultKey"`
	Lyrics         string `json:"lyrics"`
	Chords         string `json:"chords"`
	BPM            *int   `json:"bpm,omitempty"`
	BeatsPerLine   *int   `json:"beatsPerLine,omitempty"`
	IntroBeats     *int   `json:"introBeats,omitempty"`
	SubmitterName  string `json:"submitterName"`
	SubmitterEmail string `json:"submitterEmail"`
	Note           string `json:"note"`
}

type songAdminUpdateRequest struct {
	Title        string                          `json:"title"`
	Category     string                          `json:"category"`
	DefaultKey   string                          `json:"defaultKey"`
	BPM          *int                            `json:"bpm,omitempty"`
	BeatsPerLine *int                            `json:"beatsPerLine,omitempty"`
	IntroBeats   *int                            `json:"introBeats,omitempty"`
	Sections     []songAdminSectionUpdateRequest `json:"sections,omitempty"`
}

type songAdminSectionUpdateRequest struct {
	SectionType string `json:"sectionType"`
	Title       string `json:"title"`
	Lyrics      string `json:"lyrics"`
	Chords      string `json:"chords"`
}

type parsedSongSection struct {
	SectionType string
	Title       string
	Lines       []string
	Chords      [][]string
}

type rejectSongSubmissionRequest struct {
	Reason string `json:"reason"`
}

type songSubmissionCreatedResponse struct {
	ID     int64  `json:"id"`
	Status string `json:"status"`
}

type songSubmissionListItem struct {
	ID             int64     `json:"id"`
	Title          string    `json:"title"`
	Category       string    `json:"category"`
	DefaultKey     string    `json:"defaultKey"`
	Lyrics         string    `json:"lyrics"`
	Chords         string    `json:"chords"`
	BPM            *int      `json:"bpm,omitempty"`
	BeatsPerLine   *int      `json:"beatsPerLine,omitempty"`
	IntroBeats     *int      `json:"introBeats,omitempty"`
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
	mux.HandleFunc("PUT /api/admin/song-submissions/{id}", func(w http.ResponseWriter, r *http.Request) {
		if !requireAdmin(w, r, cfg) {
			return
		}

		submissionID, err := strconv.ParseInt(strings.TrimSpace(r.PathValue("id")), 10, 64)
		if err != nil || submissionID <= 0 {
			writeError(w, http.StatusBadRequest, "valid submission id is required")
			return
		}

		var payload songSubmissionRequest
		if err := readJSON(w, r, &payload); err != nil {
			writeError(w, http.StatusBadRequest, "invalid submission payload")
			return
		}

		result, err := updateSongSubmission(r.Context(), db, submissionID, payload)
		if errors.Is(err, sql.ErrNoRows) {
			writeError(w, http.StatusNotFound, "pending submission not found")
			return
		}
		if errors.Is(err, errValidation) {
			writeError(w, http.StatusBadRequest, err.Error())
			return
		}
		if err != nil {
			logger.Error("update song submission failed", "error", err, "submission_id", submissionID)
			writeError(w, http.StatusInternalServerError, "failed to update song submission")
			return
		}

		writeJSON(w, http.StatusOK, result)
	})
	mux.HandleFunc("POST /api/admin/songs", func(w http.ResponseWriter, r *http.Request) {
		if !requireAdmin(w, r, cfg) {
			return
		}

		var payload songSubmissionRequest
		if err := readJSON(w, r, &payload); err != nil {
			writeError(w, http.StatusBadRequest, "invalid song payload")
			return
		}

		result, err := createPublishedSong(r.Context(), db, payload)
		if errors.Is(err, errValidation) {
			writeError(w, http.StatusBadRequest, err.Error())
			return
		}
		if err != nil {
			logger.Error("create admin song failed", "error", err)
			writeError(w, http.StatusInternalServerError, "failed to create song")
			return
		}

		writeJSON(w, http.StatusCreated, result)
	})
	mux.HandleFunc("PUT /api/admin/songs/{id}", func(w http.ResponseWriter, r *http.Request) {
		if !requireAdmin(w, r, cfg) {
			return
		}

		songID := strings.TrimSpace(r.PathValue("id"))
		if songID == "" {
			writeError(w, http.StatusBadRequest, "song id is required")
			return
		}

		var payload songAdminUpdateRequest
		if err := readJSON(w, r, &payload); err != nil {
			writeError(w, http.StatusBadRequest, "invalid song payload")
			return
		}

		result, err := updatePublishedSongMetadata(r.Context(), db, songID, payload)
		if errors.Is(err, sql.ErrNoRows) {
			writeError(w, http.StatusNotFound, "published song not found")
			return
		}
		if errors.Is(err, errValidation) {
			writeError(w, http.StatusBadRequest, err.Error())
			return
		}
		if err != nil {
			logger.Error("update admin song failed", "error", err, "song_id", songID)
			writeError(w, http.StatusInternalServerError, "failed to update song")
			return
		}

		writeJSON(w, http.StatusOK, result)
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
	mux.HandleFunc("POST /api/admin/song-submissions/{id}/reject", func(w http.ResponseWriter, r *http.Request) {
		if !requireAdmin(w, r, cfg) {
			return
		}

		submissionID, err := strconv.ParseInt(strings.TrimSpace(r.PathValue("id")), 10, 64)
		if err != nil || submissionID <= 0 {
			writeError(w, http.StatusBadRequest, "valid submission id is required")
			return
		}

		var payload rejectSongSubmissionRequest
		if err := readJSON(w, r, &payload); err != nil {
			writeError(w, http.StatusBadRequest, "invalid rejection payload")
			return
		}

		result, err := rejectSongSubmission(r.Context(), db, submissionID, payload.Reason)
		if errors.Is(err, sql.ErrNoRows) {
			writeError(w, http.StatusNotFound, "pending submission not found")
			return
		}
		if errors.Is(err, errValidation) {
			writeError(w, http.StatusBadRequest, err.Error())
			return
		}
		if err != nil {
			logger.Error("reject song submission failed", "error", err, "submission_id", submissionID)
			writeError(w, http.StatusInternalServerError, "failed to reject song submission")
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
		AdminAPIKey: getenv("ADMIN_API_KEY", "123456"),
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

const (
	minBPM          = 40
	maxBPM          = 220
	minBeatsPerLine = 1
	maxBeatsPerLine = 16
	maxIntroBeats   = 64
)

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
  title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note
) VALUES (?, ?, NULLIF(?, ''), ?, NULLIF(?, ''), ?, ?, ?, NULLIF(?, ''), NULLIF(?, ''), NULLIF(?, ''))`

	result, err := db.ExecContext(
		ctx,
		query,
		normalized.Title,
		normalized.Category,
		normalized.DefaultKey,
		normalized.Lyrics,
		normalized.Chords,
		optionalIntParam(normalized.BPM),
		optionalIntParam(normalized.BeatsPerLine),
		optionalIntParam(normalized.IntroBeats),
		normalized.SubmitterName,
		normalized.SubmitterEmail,
		normalized.Note,
	)
	if err != nil {
		return 0, err
	}

	return result.LastInsertId()
}

func updateSongSubmission(ctx context.Context, db *sql.DB, submissionID int64, payload songSubmissionRequest) (songSubmissionCreatedResponse, error) {
	normalized, err := normalizeSongSubmission(payload)
	if err != nil {
		return songSubmissionCreatedResponse{}, err
	}

	result, err := db.ExecContext(
		ctx,
		`UPDATE song_submissions
SET
  title = ?,
  category = ?,
  default_key = NULLIF(?, ''),
  lyrics = ?,
  chords = NULLIF(?, ''),
  bpm = ?,
  beats_per_line = ?,
  intro_beats = ?,
  submitter_name = NULLIF(?, ''),
  submitter_email = NULLIF(?, ''),
  note = NULLIF(?, '')
WHERE id = ? AND status = 'pending'`,
		normalized.Title,
		normalized.Category,
		normalized.DefaultKey,
		normalized.Lyrics,
		normalized.Chords,
		optionalIntParam(normalized.BPM),
		optionalIntParam(normalized.BeatsPerLine),
		optionalIntParam(normalized.IntroBeats),
		normalized.SubmitterName,
		normalized.SubmitterEmail,
		normalized.Note,
		submissionID,
	)
	if err != nil {
		return songSubmissionCreatedResponse{}, err
	}
	affected, err := result.RowsAffected()
	if err != nil {
		return songSubmissionCreatedResponse{}, err
	}
	if affected == 0 {
		return songSubmissionCreatedResponse{}, sql.ErrNoRows
	}

	return songSubmissionCreatedResponse{ID: submissionID, Status: "pending"}, nil
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
  bpm,
  beats_per_line,
  intro_beats,
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
		var bpm sql.NullInt64
		var beatsPerLine sql.NullInt64
		var introBeats sql.NullInt64
		if err := rows.Scan(
			&item.ID,
			&item.Title,
			&item.Category,
			&item.DefaultKey,
			&item.Lyrics,
			&item.Chords,
			&bpm,
			&beatsPerLine,
			&introBeats,
			&item.SubmitterName,
			&item.SubmitterEmail,
			&item.Note,
			&item.Status,
			&item.CreatedAt,
		); err != nil {
			return nil, err
		}
		item.BPM = intPtrFromNull(bpm)
		item.BeatsPerLine = intPtrFromNull(beatsPerLine)
		item.IntroBeats = intPtrFromNull(introBeats)
		submissions = append(submissions, item)
	}

	return submissions, rows.Err()
}

func createPublishedSong(ctx context.Context, db *sql.DB, payload songSubmissionRequest) (approveSubmissionResponse, error) {
	normalized, err := normalizeSongSubmission(payload)
	if err != nil {
		return approveSubmissionResponse{}, err
	}

	tx, err := db.BeginTx(ctx, nil)
	if err != nil {
		return approveSubmissionResponse{}, err
	}
	defer tx.Rollback()

	version, nextNumber, err := lockCurrentCatalogVersionAndNextNumber(ctx, tx)
	if err != nil {
		return approveSubmissionResponse{}, err
	}

	songID := fmt.Sprintf("admin-%d-%d", nextNumber, time.Now().UTC().UnixNano())
	if err := insertPublishedSongTx(ctx, tx, version.ID, songID, nextNumber, normalized); err != nil {
		return approveSubmissionResponse{}, err
	}

	nextVersion := fmt.Sprintf("admin-%d-%s", nextNumber, time.Now().UTC().Format("20060102150405"))
	if _, err := tx.ExecContext(
		ctx,
		`UPDATE catalog_versions SET version = ?, published_at = UTC_TIMESTAMP(), notes = ? WHERE id = ?`,
		nextVersion,
		fmt.Sprintf("Admin created song %s", songID),
		version.ID,
	); err != nil {
		return approveSubmissionResponse{}, err
	}

	if err := tx.Commit(); err != nil {
		return approveSubmissionResponse{}, err
	}

	return approveSubmissionResponse{SongID: songID, CatalogVersion: nextVersion}, nil
}

func updatePublishedSongMetadata(ctx context.Context, db *sql.DB, songID string, payload songAdminUpdateRequest) (approveSubmissionResponse, error) {
	normalized, err := normalizeSongMetadata(payload)
	if err != nil {
		return approveSubmissionResponse{}, err
	}

	tx, err := db.BeginTx(ctx, nil)
	if err != nil {
		return approveSubmissionResponse{}, err
	}
	defer tx.Rollback()

	version, err := lockCurrentCatalogVersion(ctx, tx)
	if err != nil {
		return approveSubmissionResponse{}, err
	}

	result, err := tx.ExecContext(
		ctx,
		`UPDATE songs
SET title = ?, category = ?, default_key = NULLIF(?, ''), bpm = ?, beats_per_line = ?, intro_beats = ?
WHERE id = ? AND catalog_version_id = ? AND status = 'published'`,
		normalized.Title,
		normalized.Category,
		normalized.DefaultKey,
		optionalIntParam(normalized.BPM),
		optionalIntParam(normalized.BeatsPerLine),
		optionalIntParam(normalized.IntroBeats),
		songID,
		version.ID,
	)
	if err != nil {
		return approveSubmissionResponse{}, err
	}
	affected, err := result.RowsAffected()
	if err != nil {
		return approveSubmissionResponse{}, err
	}
	if affected == 0 {
		return approveSubmissionResponse{}, sql.ErrNoRows
	}
	if normalized.Sections != nil {
		if err := replacePublishedSongSectionsTx(ctx, tx, songID, normalized.Sections); err != nil {
			return approveSubmissionResponse{}, err
		}
	}

	nextVersion := fmt.Sprintf("admin-edit-%s", time.Now().UTC().Format("20060102150405"))
	if _, err := tx.ExecContext(
		ctx,
		`UPDATE catalog_versions SET version = ?, published_at = UTC_TIMESTAMP(), notes = ? WHERE id = ?`,
		nextVersion,
		fmt.Sprintf("Admin updated song %s", songID),
		version.ID,
	); err != nil {
		return approveSubmissionResponse{}, err
	}

	if err := tx.Commit(); err != nil {
		return approveSubmissionResponse{}, err
	}

	return approveSubmissionResponse{SongID: songID, CatalogVersion: nextVersion}, nil
}

func rejectSongSubmission(ctx context.Context, db *sql.DB, submissionID int64, reason string) (songSubmissionCreatedResponse, error) {
	normalizedReason := strings.TrimSpace(reason)
	if tooLong(normalizedReason, 500) {
		return songSubmissionCreatedResponse{}, validationError("rejection reason is too long")
	}

	result, err := db.ExecContext(
		ctx,
		`UPDATE song_submissions
SET status = 'rejected', rejection_reason = NULLIF(?, ''), reviewed_at = UTC_TIMESTAMP()
WHERE id = ? AND status = 'pending'`,
		normalizedReason,
		submissionID,
	)
	if err != nil {
		return songSubmissionCreatedResponse{}, err
	}
	affected, err := result.RowsAffected()
	if err != nil {
		return songSubmissionCreatedResponse{}, err
	}
	if affected == 0 {
		return songSubmissionCreatedResponse{}, sql.ErrNoRows
	}

	return songSubmissionCreatedResponse{ID: submissionID, Status: "rejected"}, nil
}

func approveSongSubmission(ctx context.Context, db *sql.DB, submissionID int64) (approveSubmissionResponse, error) {
	tx, err := db.BeginTx(ctx, nil)
	if err != nil {
		return approveSubmissionResponse{}, err
	}
	defer tx.Rollback()

	var submission songSubmissionRequest
	const submissionQuery = `
SELECT title, category, COALESCE(default_key, ''), lyrics, COALESCE(chords, ''), bpm, beats_per_line, intro_beats
FROM song_submissions
WHERE id = ? AND status = 'pending'
FOR UPDATE`
	var bpm sql.NullInt64
	var beatsPerLine sql.NullInt64
	var introBeats sql.NullInt64
	if err := tx.QueryRowContext(ctx, submissionQuery, submissionID).Scan(
		&submission.Title,
		&submission.Category,
		&submission.DefaultKey,
		&submission.Lyrics,
		&submission.Chords,
		&bpm,
		&beatsPerLine,
		&introBeats,
	); err != nil {
		return approveSubmissionResponse{}, err
	}
	submission.BPM = intPtrFromNull(bpm)
	submission.BeatsPerLine = intPtrFromNull(beatsPerLine)
	submission.IntroBeats = intPtrFromNull(introBeats)

	normalized, err := normalizeSongSubmission(submission)
	if err != nil {
		return approveSubmissionResponse{}, err
	}

	version, nextNumber, err := lockCurrentCatalogVersionAndNextNumber(ctx, tx)
	if err != nil {
		return approveSubmissionResponse{}, err
	}

	songID := fmt.Sprintf("submission-%d", submissionID)
	if err := insertPublishedSongTx(ctx, tx, version.ID, songID, nextNumber, normalized); err != nil {
		return approveSubmissionResponse{}, err
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

func lockCurrentCatalogVersionAndNextNumber(ctx context.Context, tx *sql.Tx) (catalogVersion, int, error) {
	version, err := lockCurrentCatalogVersion(ctx, tx)
	if err != nil {
		return catalogVersion{}, 0, err
	}

	var nextNumber int
	if err := tx.QueryRowContext(ctx, `SELECT COALESCE(MAX(number), 0) + 1 FROM songs WHERE catalog_version_id = ?`, version.ID).Scan(&nextNumber); err != nil {
		return catalogVersion{}, 0, err
	}

	return version, nextNumber, nil
}

func lockCurrentCatalogVersion(ctx context.Context, tx *sql.Tx) (catalogVersion, error) {
	var version catalogVersion
	const versionQuery = `
SELECT id, version, published_at
FROM catalog_versions
WHERE is_current = 1
ORDER BY published_at DESC, id DESC
LIMIT 1
FOR UPDATE`
	if err := tx.QueryRowContext(ctx, versionQuery).Scan(&version.ID, &version.Version, &version.PublishedAt); err != nil {
		return catalogVersion{}, err
	}

	return version, nil
}

func insertPublishedSongTx(
	ctx context.Context,
	tx *sql.Tx,
	catalogVersionID int64,
	songID string,
	number int,
	normalized songSubmissionRequest,
) error {
	if _, err := tx.ExecContext(
		ctx,
		`INSERT INTO songs (id, catalog_version_id, number, title, category, default_key, bpm, beats_per_line, intro_beats, status) VALUES (?, ?, ?, ?, ?, NULLIF(?, ''), ?, ?, ?, 'published')`,
		songID,
		catalogVersionID,
		number,
		normalized.Title,
		normalized.Category,
		normalized.DefaultKey,
		optionalIntParam(normalized.BPM),
		optionalIntParam(normalized.BeatsPerLine),
		optionalIntParam(normalized.IntroBeats),
	); err != nil {
		return err
	}

	sections, err := parsePublishedSongSections(normalized.Lyrics, normalized.Chords)
	if err != nil {
		return err
	}
	for index, section := range sections {
		if err := insertParsedSongSectionTx(ctx, tx, songID, index+1, section); err != nil {
			return err
		}
	}

	return nil
}

func replacePublishedSongSectionsTx(ctx context.Context, tx *sql.Tx, songID string, sections []songAdminSectionUpdateRequest) error {
	if _, err := tx.ExecContext(
		ctx,
		`DELETE slc
FROM song_line_chords slc
JOIN song_lines sl ON sl.id = slc.line_id
JOIN song_sections ss ON ss.id = sl.section_id
WHERE ss.song_id = ?`,
		songID,
	); err != nil {
		return err
	}
	if _, err := tx.ExecContext(
		ctx,
		`DELETE sl
FROM song_lines sl
JOIN song_sections ss ON ss.id = sl.section_id
WHERE ss.song_id = ?`,
		songID,
	); err != nil {
		return err
	}
	if _, err := tx.ExecContext(ctx, `DELETE FROM song_sections WHERE song_id = ?`, songID); err != nil {
		return err
	}

	for index, section := range sections {
		if err := insertSongSectionTx(ctx, tx, songID, index+1, section.SectionType, section.Title, section.Lyrics, section.Chords); err != nil {
			return err
		}
	}

	return nil
}

func insertSongSectionTx(
	ctx context.Context,
	tx *sql.Tx,
	songID string,
	position int,
	sectionType string,
	title string,
	lyricsText string,
	chordsText string,
) error {
	return insertParsedSongSectionTx(ctx, tx, songID, position, parsedSongSection{
		SectionType: sectionType,
		Title:       title,
		Lines:       splitNonEmptyLines(lyricsText),
		Chords:      splitChordLines(chordsText),
	})
}

func insertParsedSongSectionTx(
	ctx context.Context,
	tx *sql.Tx,
	songID string,
	position int,
	section parsedSongSection,
) error {
	sectionResult, err := tx.ExecContext(
		ctx,
		`INSERT INTO song_sections (song_id, section_type, position, title) VALUES (?, ?, ?, NULLIF(?, ''))`,
		songID,
		section.SectionType,
		position,
		section.Title,
	)
	if err != nil {
		return err
	}
	sectionID, err := sectionResult.LastInsertId()
	if err != nil {
		return err
	}

	for index, line := range section.Lines {
		lineResult, err := tx.ExecContext(
			ctx,
			`INSERT INTO song_lines (section_id, position, text) VALUES (?, ?, ?)`,
			sectionID,
			index+1,
			line,
		)
		if err != nil {
			return err
		}
		lineID, err := lineResult.LastInsertId()
		if err != nil {
			return err
		}

		if index >= len(section.Chords) {
			continue
		}
		for chordIndex, chord := range section.Chords[index] {
			if _, err := tx.ExecContext(
				ctx,
				`INSERT INTO song_line_chords (line_id, position, chord) VALUES (?, ?, ?)`,
				lineID,
				chordIndex+1,
				chord,
			); err != nil {
				return err
			}
		}
	}

	return nil
}

func parsePublishedSongSections(lyricsText string, chordsText string) ([]parsedSongSection, error) {
	sections := splitLyricsSections(lyricsText)
	if len(sections) == 0 {
		return nil, validationError("lyrics must contain text lines")
	}

	chordSections, hasChordHeadings := splitChordSections(chordsText)
	if hasChordHeadings {
		for index := range sections {
			if index < len(chordSections) {
				sections[index].Chords = chordSections[index].Chords
			}
		}
		return sections, nil
	}

	chordLines := splitChordLines(chordsText)
	chordIndex := 0
	for sectionIndex := range sections {
		sections[sectionIndex].Chords = make([][]string, 0, len(sections[sectionIndex].Lines))
		for range sections[sectionIndex].Lines {
			if chordIndex >= len(chordLines) {
				sections[sectionIndex].Chords = append(sections[sectionIndex].Chords, []string{})
				continue
			}
			sections[sectionIndex].Chords = append(sections[sectionIndex].Chords, chordLines[chordIndex])
			chordIndex++
		}
	}

	return sections, nil
}

func splitLyricsSections(value string) []parsedSongSection {
	sections := make([]parsedSongSection, 0)
	currentIndex := -1
	verseCount := 0

	for _, rawLine := range strings.Split(value, "\n") {
		line := strings.TrimSpace(rawLine)
		if line == "" {
			continue
		}
		if sectionType, title, ok := parseSectionHeading(line); ok {
			if sectionType == "verse" {
				verseCount++
			}
			sections = append(sections, parsedSongSection{SectionType: sectionType, Title: title})
			currentIndex = len(sections) - 1
			continue
		}
		if currentIndex < 0 {
			verseCount++
			sections = append(sections, parsedSongSection{SectionType: "verse", Title: fmt.Sprintf("Куплет %d", verseCount)})
			currentIndex = 0
		}
		sections[currentIndex].Lines = append(sections[currentIndex].Lines, line)
	}

	return filterEmptyParsedSections(sections)
}

func splitChordSections(value string) ([]parsedSongSection, bool) {
	sections := make([]parsedSongSection, 0)
	currentIndex := -1
	hasHeadings := false

	for _, rawLine := range strings.Split(value, "\n") {
		line := strings.TrimSpace(rawLine)
		if sectionType, title, ok := parseSectionHeading(line); ok {
			hasHeadings = true
			sections = append(sections, parsedSongSection{SectionType: sectionType, Title: title})
			currentIndex = len(sections) - 1
			continue
		}
		if line == "" && currentIndex < 0 {
			continue
		}
		if currentIndex < 0 {
			sections = append(sections, parsedSongSection{SectionType: "verse", Title: "Куплет 1"})
			currentIndex = 0
		}
		sections[currentIndex].Chords = append(sections[currentIndex].Chords, strings.Fields(rawLine))
	}

	return sections, hasHeadings
}

func filterEmptyParsedSections(sections []parsedSongSection) []parsedSongSection {
	filtered := make([]parsedSongSection, 0, len(sections))
	for _, section := range sections {
		if len(section.Lines) == 0 {
			continue
		}
		filtered = append(filtered, section)
	}
	return filtered
}

func parseSectionHeading(value string) (string, string, bool) {
	title := strings.Trim(strings.TrimSpace(value), "[]: \t")
	if title == "" {
		return "", "", false
	}

	lower := strings.ToLower(title)
	switch {
	case isSectionHeading(lower, "куплет") || isSectionHeading(lower, "verse"):
		return "verse", title, true
	case isSectionHeading(lower, "припев") || isSectionHeading(lower, "chorus") || isSectionHeading(lower, "refrain"):
		return "chorus", title, true
	case isSectionHeading(lower, "бридж") || isSectionHeading(lower, "мост") || isSectionHeading(lower, "bridge"):
		return "bridge", title, true
	default:
		return "", "", false
	}
}

func isSectionHeading(value string, prefix string) bool {
	if value == prefix {
		return true
	}
	for _, separator := range []string{" ", "-"} {
		suffix, ok := strings.CutPrefix(value, prefix+separator)
		if !ok {
			continue
		}
		suffix = strings.TrimSpace(suffix)
		if suffix == "" {
			return true
		}
		first := []rune(suffix)[0]
		return first >= '0' && first <= '9'
	}
	return false
}

func normalizeSongSubmission(payload songSubmissionRequest) (songSubmissionRequest, error) {
	normalized := songSubmissionRequest{
		Title:          strings.TrimSpace(payload.Title),
		Category:       strings.TrimSpace(payload.Category),
		DefaultKey:     strings.TrimSpace(payload.DefaultKey),
		Lyrics:         strings.TrimSpace(payload.Lyrics),
		Chords:         strings.TrimSpace(payload.Chords),
		BPM:            payload.BPM,
		BeatsPerLine:   payload.BeatsPerLine,
		IntroBeats:     payload.IntroBeats,
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
	case normalized.BPM != nil && (*normalized.BPM < minBPM || *normalized.BPM > maxBPM):
		return songSubmissionRequest{}, validationError("bpm must be between 40 and 220")
	case normalized.BeatsPerLine != nil && (*normalized.BeatsPerLine < minBeatsPerLine || *normalized.BeatsPerLine > maxBeatsPerLine):
		return songSubmissionRequest{}, validationError("beats per line must be between 1 and 16")
	case normalized.IntroBeats != nil && (*normalized.IntroBeats < 0 || *normalized.IntroBeats > maxIntroBeats):
		return songSubmissionRequest{}, validationError("intro beats must be between 0 and 64")
	case tooLong(normalized.SubmitterName, 128):
		return songSubmissionRequest{}, validationError("submitter name is too long")
	case tooLong(normalized.SubmitterEmail, 255):
		return songSubmissionRequest{}, validationError("submitter email is too long")
	case tooLong(normalized.Note, 1000):
		return songSubmissionRequest{}, validationError("note is too long")
	}

	return normalized, nil
}

func normalizeSongMetadata(payload songAdminUpdateRequest) (songAdminUpdateRequest, error) {
	normalized := songAdminUpdateRequest{
		Title:        strings.TrimSpace(payload.Title),
		Category:     strings.TrimSpace(payload.Category),
		DefaultKey:   strings.TrimSpace(payload.DefaultKey),
		BPM:          payload.BPM,
		BeatsPerLine: payload.BeatsPerLine,
		IntroBeats:   payload.IntroBeats,
		Sections:     payload.Sections,
	}
	if normalized.Category == "" {
		normalized.Category = "Общее"
	}

	switch {
	case normalized.Title == "":
		return songAdminUpdateRequest{}, validationError("title is required")
	case tooLong(normalized.Title, 255):
		return songAdminUpdateRequest{}, validationError("title is too long")
	case tooLong(normalized.Category, 128):
		return songAdminUpdateRequest{}, validationError("category is too long")
	case tooLong(normalized.DefaultKey, 16):
		return songAdminUpdateRequest{}, validationError("default key is too long")
	case normalized.BPM != nil && (*normalized.BPM < minBPM || *normalized.BPM > maxBPM):
		return songAdminUpdateRequest{}, validationError("bpm must be between 40 and 220")
	case normalized.BeatsPerLine != nil && (*normalized.BeatsPerLine < minBeatsPerLine || *normalized.BeatsPerLine > maxBeatsPerLine):
		return songAdminUpdateRequest{}, validationError("beats per line must be between 1 and 16")
	case normalized.IntroBeats != nil && (*normalized.IntroBeats < 0 || *normalized.IntroBeats > maxIntroBeats):
		return songAdminUpdateRequest{}, validationError("intro beats must be between 0 and 64")
	}
	if normalized.Sections != nil {
		if len(normalized.Sections) == 0 {
			return songAdminUpdateRequest{}, validationError("song sections are required")
		}
		if len(normalized.Sections) > 30 {
			return songAdminUpdateRequest{}, validationError("too many song sections")
		}
		for index, section := range normalized.Sections {
			normalizedSection := songAdminSectionUpdateRequest{
				SectionType: strings.TrimSpace(section.SectionType),
				Title:       strings.TrimSpace(section.Title),
				Lyrics:      strings.TrimSpace(section.Lyrics),
				Chords:      strings.TrimSpace(section.Chords),
			}
			switch normalizedSection.SectionType {
			case "verse", "chorus", "bridge":
			default:
				return songAdminUpdateRequest{}, validationError("section type is invalid")
			}
			switch {
			case tooLong(normalizedSection.Title, 128):
				return songAdminUpdateRequest{}, validationError("section title is too long")
			case normalizedSection.Lyrics == "":
				return songAdminUpdateRequest{}, validationError("section lyrics are required")
			case len(splitNonEmptyLines(normalizedSection.Lyrics)) == 0:
				return songAdminUpdateRequest{}, validationError("section lyrics must contain text lines")
			case tooLong(normalizedSection.Lyrics, 12000):
				return songAdminUpdateRequest{}, validationError("section lyrics are too long")
			case tooLong(normalizedSection.Chords, 12000):
				return songAdminUpdateRequest{}, validationError("section chords are too long")
			}
			normalized.Sections[index] = normalizedSection
		}
	}

	return normalized, nil
}

func optionalIntParam(value *int) any {
	if value == nil {
		return nil
	}
	return *value
}

func intPtrFromNull(value sql.NullInt64) *int {
	if !value.Valid {
		return nil
	}
	converted := int(value.Int64)
	return &converted
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
LIMIT 1000`

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
LIMIT 1000`

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
SELECT id, number, title, category, COALESCE(default_key, ''), bpm, beats_per_line, intro_beats
FROM songs
WHERE catalog_version_id = ? AND id = ? AND status = 'published'
LIMIT 1`

	var song songResponse
	var bpm sql.NullInt64
	var beatsPerLine sql.NullInt64
	var introBeats sql.NullInt64
	if err := db.QueryRowContext(ctx, songQuery, catalogVersionID, songID).Scan(&song.ID, &song.Number, &song.Title, &song.Category, &song.DefaultKey, &bpm, &beatsPerLine, &introBeats); err != nil {
		return songResponse{}, err
	}
	if bpm.Valid && beatsPerLine.Valid {
		song.Playback = &songPlayback{
			BPM:          int(bpm.Int64),
			BeatsPerLine: int(beatsPerLine.Int64),
			IntroBeats:   intPtrFromNull(introBeats),
		}
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

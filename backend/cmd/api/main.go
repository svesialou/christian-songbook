package main

import (
	"context"
	"crypto/rand"
	"crypto/sha256"
	"crypto/subtle"
	"database/sql"
	"encoding/hex"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"log/slog"
	"net/http"
	"net/url"
	"os"
	"os/signal"
	"strconv"
	"strings"
	"syscall"
	"time"

	_ "github.com/go-sql-driver/mysql"
)

type config struct {
	ServiceName             string
	HTTPAddr                string
	DBHost                  string
	DBPort                  string
	DBName                  string
	DBUser                  string
	DBPassword              string
	AdminAPIKey             string
	AuthCookieName          string
	AuthSessionTTLHours     int
	OAuthRedirectBaseURL    string
	GoogleOAuthClientID     string
	GoogleOAuthClientSecret string
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

type meResponse struct {
	Authenticated bool                     `json:"authenticated"`
	User          *currentUserResponse     `json:"user,omitempty"`
	Preferences   *userPreferencesResponse `json:"preferences,omitempty"`
}

type currentUserResponse struct {
	ID          int64  `json:"id"`
	DisplayName string `json:"displayName"`
	Email       string `json:"email,omitempty"`
	AvatarURL   string `json:"avatarUrl,omitempty"`
}

type userPreferencesResponse struct {
	Instrument            string   `json:"instrument"`
	PreferredKeys         []string `json:"preferredKeys"`
	CapoEnabled           bool     `json:"capoEnabled"`
	MaxCapo               int      `json:"maxCapo"`
	PianoTransposeEnabled bool     `json:"pianoTransposeEnabled"`
	ShowOriginalKey       bool     `json:"showOriginalKey"`
}

type updateUserPreferencesRequest struct {
	Instrument            string   `json:"instrument"`
	PreferredKeys         []string `json:"preferredKeys"`
	CapoEnabled           bool     `json:"capoEnabled"`
	MaxCapo               int      `json:"maxCapo"`
	PianoTransposeEnabled bool     `json:"pianoTransposeEnabled"`
	ShowOriginalKey       bool     `json:"showOriginalKey"`
}

type userSongPreferenceResponse struct {
	SongID         string `json:"songId"`
	TargetKey      string `json:"targetKey,omitempty"`
	TransposeSteps *int   `json:"transposeSteps,omitempty"`
	Capo           *int   `json:"capo,omitempty"`
	Note           string `json:"note,omitempty"`
}

type updateUserSongPreferenceRequest struct {
	TargetKey      string `json:"targetKey"`
	TransposeSteps *int   `json:"transposeSteps,omitempty"`
	Capo           *int   `json:"capo,omitempty"`
	Note           string `json:"note"`
}

type googleTokenResponse struct {
	AccessToken string `json:"access_token"`
	TokenType   string `json:"token_type"`
	ExpiresIn   int    `json:"expires_in"`
}

type googleUserInfoResponse struct {
	Subject       string `json:"sub"`
	Email         string `json:"email"`
	EmailVerified bool   `json:"email_verified"`
	Name          string `json:"name"`
	Picture       string `json:"picture"`
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
	mux.HandleFunc("GET /api/auth/google/start", func(w http.ResponseWriter, r *http.Request) {
		redirectURL, err := startGoogleOAuth(r.Context(), db, cfg, r)
		if errors.Is(err, errOAuthNotConfigured) {
			writeError(w, http.StatusServiceUnavailable, "google auth is not configured")
			return
		}
		if errors.Is(err, errValidation) {
			writeError(w, http.StatusBadRequest, err.Error())
			return
		}
		if err != nil {
			logger.Error("start google auth failed", "error", err)
			writeError(w, http.StatusInternalServerError, "failed to start google auth")
			return
		}

		http.Redirect(w, r, redirectURL, http.StatusFound)
	})
	mux.HandleFunc("GET /api/auth/google/callback", func(w http.ResponseWriter, r *http.Request) {
		redirectPath, err := finishGoogleOAuth(r.Context(), db, cfg, w, r)
		if errors.Is(err, errOAuthNotConfigured) {
			writeError(w, http.StatusServiceUnavailable, "google auth is not configured")
			return
		}
		if errors.Is(err, errValidation) {
			writeError(w, http.StatusBadRequest, err.Error())
			return
		}
		if err != nil {
			logger.Error("finish google auth failed", "error", err)
			writeError(w, http.StatusInternalServerError, "failed to finish google auth")
			return
		}

		http.Redirect(w, r, redirectPath, http.StatusFound)
	})
	mux.HandleFunc("POST /api/auth/logout", func(w http.ResponseWriter, r *http.Request) {
		if err := logoutCurrentUser(r.Context(), db, cfg, w, r); err != nil {
			logger.Error("logout failed", "error", err)
			writeError(w, http.StatusInternalServerError, "failed to logout")
			return
		}

		writeJSON(w, http.StatusOK, map[string]bool{"authenticated": false})
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
	mux.HandleFunc("GET /api/me", func(w http.ResponseWriter, r *http.Request) {
		me, err := getMe(r.Context(), db, cfg, r)
		if err != nil {
			logger.Error("get current user failed", "error", err)
			writeError(w, http.StatusInternalServerError, "failed to get current user")
			return
		}

		writeJSON(w, http.StatusOK, me)
	})
	mux.HandleFunc("PUT /api/me/preferences", func(w http.ResponseWriter, r *http.Request) {
		userID, authenticated, err := currentUserIDFromRequest(r.Context(), db, cfg, r)
		if err != nil {
			logger.Error("resolve current user failed", "error", err)
			writeError(w, http.StatusInternalServerError, "failed to resolve current user")
			return
		}
		if !authenticated {
			writeError(w, http.StatusUnauthorized, "login is required to save preferences")
			return
		}

		var payload updateUserPreferencesRequest
		if err := readJSON(w, r, &payload); err != nil {
			writeError(w, http.StatusBadRequest, "invalid preferences payload")
			return
		}

		preferences, err := updateUserPreferences(r.Context(), db, userID, payload)
		if errors.Is(err, errValidation) {
			writeError(w, http.StatusBadRequest, err.Error())
			return
		}
		if err != nil {
			logger.Error("update user preferences failed", "error", err, "user_id", userID)
			writeError(w, http.StatusInternalServerError, "failed to update preferences")
			return
		}

		writeJSON(w, http.StatusOK, preferences)
	})
	mux.HandleFunc("GET /api/me/song-preferences/{id}", func(w http.ResponseWriter, r *http.Request) {
		userID, authenticated, err := currentUserIDFromRequest(r.Context(), db, cfg, r)
		if err != nil {
			logger.Error("resolve current user failed", "error", err)
			writeError(w, http.StatusInternalServerError, "failed to resolve current user")
			return
		}
		if !authenticated {
			writeError(w, http.StatusUnauthorized, "login is required to read song preferences")
			return
		}

		songID := strings.TrimSpace(r.PathValue("id"))
		preference, err := getUserSongPreference(r.Context(), db, userID, songID)
		if errors.Is(err, errValidation) {
			writeError(w, http.StatusBadRequest, err.Error())
			return
		}
		if err != nil {
			logger.Error("get user song preference failed", "error", err, "user_id", userID, "song_id", songID)
			writeError(w, http.StatusInternalServerError, "failed to get song preference")
			return
		}

		writeJSON(w, http.StatusOK, preference)
	})
	mux.HandleFunc("PUT /api/me/song-preferences/{id}", func(w http.ResponseWriter, r *http.Request) {
		userID, authenticated, err := currentUserIDFromRequest(r.Context(), db, cfg, r)
		if err != nil {
			logger.Error("resolve current user failed", "error", err)
			writeError(w, http.StatusInternalServerError, "failed to resolve current user")
			return
		}
		if !authenticated {
			writeError(w, http.StatusUnauthorized, "login is required to save song preferences")
			return
		}

		var payload updateUserSongPreferenceRequest
		if err := readJSON(w, r, &payload); err != nil {
			writeError(w, http.StatusBadRequest, "invalid song preference payload")
			return
		}

		songID := strings.TrimSpace(r.PathValue("id"))
		preference, err := updateUserSongPreference(r.Context(), db, userID, songID, payload)
		if errors.Is(err, errValidation) {
			writeError(w, http.StatusBadRequest, err.Error())
			return
		}
		if err != nil {
			logger.Error("update user song preference failed", "error", err, "user_id", userID, "song_id", songID)
			writeError(w, http.StatusInternalServerError, "failed to update song preference")
			return
		}

		writeJSON(w, http.StatusOK, preference)
	})
	mux.HandleFunc("DELETE /api/me/song-preferences/{id}", func(w http.ResponseWriter, r *http.Request) {
		userID, authenticated, err := currentUserIDFromRequest(r.Context(), db, cfg, r)
		if err != nil {
			logger.Error("resolve current user failed", "error", err)
			writeError(w, http.StatusInternalServerError, "failed to resolve current user")
			return
		}
		if !authenticated {
			writeError(w, http.StatusUnauthorized, "login is required to reset song preferences")
			return
		}

		songID := strings.TrimSpace(r.PathValue("id"))
		preference, err := deleteUserSongPreference(r.Context(), db, userID, songID)
		if errors.Is(err, errValidation) {
			writeError(w, http.StatusBadRequest, err.Error())
			return
		}
		if err != nil {
			logger.Error("delete user song preference failed", "error", err, "user_id", userID, "song_id", songID)
			writeError(w, http.StatusInternalServerError, "failed to reset song preference")
			return
		}

		writeJSON(w, http.StatusOK, preference)
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
		ServiceName:             getenv("SERVICE_NAME", "christian-songbook-api"),
		HTTPAddr:                getenv("HTTP_ADDR", ":8082"),
		DBHost:                  getenv("DB_HOST", "127.0.0.1"),
		DBPort:                  getenv("DB_PORT", "3306"),
		DBName:                  getenv("DB_NAME", "christian_songbook"),
		DBUser:                  getenv("DB_USER", "songbook"),
		DBPassword:              getenv("DB_PASSWORD", "songbook"),
		AdminAPIKey:             getenv("ADMIN_API_KEY", "123456"),
		AuthCookieName:          getenv("AUTH_COOKIE_NAME", "christian_songbook_session"),
		AuthSessionTTLHours:     getenvInt("AUTH_SESSION_TTL_HOURS", 720),
		OAuthRedirectBaseURL:    strings.TrimRight(getenv("OAUTH_REDIRECT_BASE_URL", "http://localhost:8083"), "/"),
		GoogleOAuthClientID:     getenv("GOOGLE_OAUTH_CLIENT_ID", ""),
		GoogleOAuthClientSecret: getenv("GOOGLE_OAUTH_CLIENT_SECRET", ""),
	}
}

func getenv(key string, fallback string) string {
	value := os.Getenv(key)
	if value == "" {
		return fallback
	}
	return value
}

func getenvInt(key string, fallback int) int {
	value := os.Getenv(key)
	if value == "" {
		return fallback
	}
	parsed, err := strconv.Atoi(value)
	if err != nil {
		return fallback
	}
	return parsed
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
var errOAuthNotConfigured = errors.New("oauth provider is not configured")

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

func startGoogleOAuth(ctx context.Context, db *sql.DB, cfg config, r *http.Request) (string, error) {
	if cfg.GoogleOAuthClientID == "" || cfg.GoogleOAuthClientSecret == "" || cfg.OAuthRedirectBaseURL == "" {
		return "", errOAuthNotConfigured
	}

	state, err := randomURLToken(32)
	if err != nil {
		return "", err
	}
	redirectPath := safeRedirectPath(r.URL.Query().Get("redirect"))

	const query = `
INSERT INTO oauth_login_states (
  provider,
  state_hash,
  redirect_path,
  expires_at
) VALUES ('google', ?, ?, DATE_ADD(UTC_TIMESTAMP(), INTERVAL 10 MINUTE))`
	if _, err := db.ExecContext(ctx, query, sha256Hex(state), redirectPath); err != nil {
		return "", err
	}

	values := url.Values{}
	values.Set("client_id", cfg.GoogleOAuthClientID)
	values.Set("redirect_uri", googleOAuthRedirectURI(cfg))
	values.Set("response_type", "code")
	values.Set("scope", "openid email profile")
	values.Set("state", state)
	values.Set("access_type", "online")
	values.Set("prompt", "select_account")

	return "https://accounts.google.com/o/oauth2/v2/auth?" + values.Encode(), nil
}

func finishGoogleOAuth(ctx context.Context, db *sql.DB, cfg config, w http.ResponseWriter, r *http.Request) (string, error) {
	if cfg.GoogleOAuthClientID == "" || cfg.GoogleOAuthClientSecret == "" || cfg.OAuthRedirectBaseURL == "" {
		return "", errOAuthNotConfigured
	}

	if oauthErr := strings.TrimSpace(r.URL.Query().Get("error")); oauthErr != "" {
		return "", validationError("google auth failed")
	}
	code := strings.TrimSpace(r.URL.Query().Get("code"))
	state := strings.TrimSpace(r.URL.Query().Get("state"))
	if code == "" || state == "" {
		return "", validationError("oauth code and state are required")
	}

	redirectPath, err := consumeOAuthState(ctx, db, "google", state)
	if err != nil {
		return "", err
	}

	token, err := exchangeGoogleOAuthCode(ctx, cfg, code)
	if err != nil {
		return "", err
	}
	userInfo, err := fetchGoogleUserInfo(ctx, token.AccessToken)
	if err != nil {
		return "", err
	}

	userID, err := upsertOAuthUser(ctx, db, "google", userInfo)
	if err != nil {
		return "", err
	}
	if err := createUserSession(ctx, db, cfg, w, userID); err != nil {
		return "", err
	}

	return redirectPath, nil
}

func consumeOAuthState(ctx context.Context, db *sql.DB, provider string, state string) (string, error) {
	stateHash := sha256Hex(state)

	tx, err := db.BeginTx(ctx, nil)
	if err != nil {
		return "", err
	}
	defer tx.Rollback()

	var redirectPath string
	err = tx.QueryRowContext(
		ctx,
		`SELECT COALESCE(redirect_path, '/')
FROM oauth_login_states
WHERE provider = ?
  AND state_hash = ?
  AND consumed_at IS NULL
  AND expires_at > UTC_TIMESTAMP()
LIMIT 1 FOR UPDATE`,
		provider,
		stateHash,
	).Scan(&redirectPath)
	if errors.Is(err, sql.ErrNoRows) {
		return "", validationError("oauth state is invalid or expired")
	}
	if err != nil {
		return "", err
	}

	result, err := tx.ExecContext(
		ctx,
		`UPDATE oauth_login_states SET consumed_at = UTC_TIMESTAMP() WHERE provider = ? AND state_hash = ? AND consumed_at IS NULL`,
		provider,
		stateHash,
	)
	if err != nil {
		return "", err
	}
	affected, err := result.RowsAffected()
	if err != nil {
		return "", err
	}
	if affected == 0 {
		return "", validationError("oauth state is already consumed")
	}

	if err := tx.Commit(); err != nil {
		return "", err
	}

	return safeRedirectPath(redirectPath), nil
}

func exchangeGoogleOAuthCode(ctx context.Context, cfg config, code string) (googleTokenResponse, error) {
	values := url.Values{}
	values.Set("client_id", cfg.GoogleOAuthClientID)
	values.Set("client_secret", cfg.GoogleOAuthClientSecret)
	values.Set("code", code)
	values.Set("grant_type", "authorization_code")
	values.Set("redirect_uri", googleOAuthRedirectURI(cfg))

	request, err := http.NewRequestWithContext(
		ctx,
		http.MethodPost,
		"https://oauth2.googleapis.com/token",
		strings.NewReader(values.Encode()),
	)
	if err != nil {
		return googleTokenResponse{}, err
	}
	request.Header.Set("Content-Type", "application/x-www-form-urlencoded")

	response, err := http.DefaultClient.Do(request)
	if err != nil {
		return googleTokenResponse{}, err
	}
	defer response.Body.Close()

	body, err := io.ReadAll(io.LimitReader(response.Body, 1<<20))
	if err != nil {
		return googleTokenResponse{}, err
	}
	if response.StatusCode < 200 || response.StatusCode >= 300 {
		return googleTokenResponse{}, validationError("google token exchange failed")
	}

	var token googleTokenResponse
	if err := json.Unmarshal(body, &token); err != nil {
		return googleTokenResponse{}, err
	}
	if token.AccessToken == "" {
		return googleTokenResponse{}, validationError("google access token is empty")
	}
	return token, nil
}

func fetchGoogleUserInfo(ctx context.Context, accessToken string) (googleUserInfoResponse, error) {
	request, err := http.NewRequestWithContext(ctx, http.MethodGet, "https://www.googleapis.com/oauth2/v3/userinfo", nil)
	if err != nil {
		return googleUserInfoResponse{}, err
	}
	request.Header.Set("Authorization", "Bearer "+accessToken)

	response, err := http.DefaultClient.Do(request)
	if err != nil {
		return googleUserInfoResponse{}, err
	}
	defer response.Body.Close()

	body, err := io.ReadAll(io.LimitReader(response.Body, 1<<20))
	if err != nil {
		return googleUserInfoResponse{}, err
	}
	if response.StatusCode < 200 || response.StatusCode >= 300 {
		return googleUserInfoResponse{}, validationError("google userinfo request failed")
	}

	var userInfo googleUserInfoResponse
	if err := json.Unmarshal(body, &userInfo); err != nil {
		return googleUserInfoResponse{}, err
	}
	if strings.TrimSpace(userInfo.Subject) == "" {
		return googleUserInfoResponse{}, validationError("google user subject is empty")
	}
	return userInfo, nil
}

func upsertOAuthUser(ctx context.Context, db *sql.DB, provider string, userInfo googleUserInfoResponse) (int64, error) {
	tx, err := db.BeginTx(ctx, nil)
	if err != nil {
		return 0, err
	}
	defer tx.Rollback()

	var userID int64
	err = tx.QueryRowContext(
		ctx,
		`SELECT user_id FROM user_identities WHERE provider = ? AND provider_subject = ? LIMIT 1 FOR UPDATE`,
		provider,
		userInfo.Subject,
	).Scan(&userID)
	if err != nil && !errors.Is(err, sql.ErrNoRows) {
		return 0, err
	}

	displayName := strings.TrimSpace(userInfo.Name)
	if displayName == "" {
		displayName = strings.TrimSpace(userInfo.Email)
	}
	if displayName == "" {
		displayName = "User"
	}

	if errors.Is(err, sql.ErrNoRows) {
		result, err := tx.ExecContext(
			ctx,
			`INSERT INTO users (display_name, email, avatar_url, status) VALUES (?, NULLIF(?, ''), NULLIF(?, ''), 'active')`,
			displayName,
			strings.TrimSpace(userInfo.Email),
			strings.TrimSpace(userInfo.Picture),
		)
		if err != nil {
			return 0, err
		}
		userID, err = result.LastInsertId()
		if err != nil {
			return 0, err
		}
		if _, err := tx.ExecContext(
			ctx,
			`INSERT INTO user_identities (user_id, provider, provider_subject, email, email_verified) VALUES (?, ?, ?, NULLIF(?, ''), ?)`,
			userID,
			provider,
			userInfo.Subject,
			strings.TrimSpace(userInfo.Email),
			boolParam(userInfo.EmailVerified),
		); err != nil {
			return 0, err
		}
	} else {
		if _, err := tx.ExecContext(
			ctx,
			`UPDATE users SET display_name = ?, email = NULLIF(?, ''), avatar_url = NULLIF(?, '') WHERE id = ?`,
			displayName,
			strings.TrimSpace(userInfo.Email),
			strings.TrimSpace(userInfo.Picture),
			userID,
		); err != nil {
			return 0, err
		}
		if _, err := tx.ExecContext(
			ctx,
			`UPDATE user_identities SET email = NULLIF(?, ''), email_verified = ? WHERE user_id = ? AND provider = ? AND provider_subject = ?`,
			strings.TrimSpace(userInfo.Email),
			boolParam(userInfo.EmailVerified),
			userID,
			provider,
			userInfo.Subject,
		); err != nil {
			return 0, err
		}
	}

	if _, err := tx.ExecContext(
		ctx,
		`INSERT INTO user_preferences (user_id) VALUES (?) ON DUPLICATE KEY UPDATE user_id = VALUES(user_id)`,
		userID,
	); err != nil {
		return 0, err
	}

	if err := tx.Commit(); err != nil {
		return 0, err
	}

	return userID, nil
}

func createUserSession(ctx context.Context, db *sql.DB, cfg config, w http.ResponseWriter, userID int64) error {
	sessionToken, err := randomURLToken(32)
	if err != nil {
		return err
	}

	ttlHours := cfg.AuthSessionTTLHours
	if ttlHours <= 0 {
		ttlHours = 720
	}
	expiresAt := time.Now().UTC().Add(time.Duration(ttlHours) * time.Hour)

	const query = `
INSERT INTO user_sessions (
  user_id,
  session_token_hash,
  expires_at
) VALUES (?, ?, ?)`
	if _, err := db.ExecContext(ctx, query, userID, sha256Hex(sessionToken), expiresAt); err != nil {
		return err
	}

	http.SetCookie(w, &http.Cookie{
		Name:     cfg.AuthCookieName,
		Value:    sessionToken,
		Path:     "/",
		Expires:  expiresAt,
		MaxAge:   int(time.Until(expiresAt).Seconds()),
		HttpOnly: true,
		SameSite: http.SameSiteLaxMode,
		Secure:   strings.HasPrefix(cfg.OAuthRedirectBaseURL, "https://"),
	})
	return nil
}

func logoutCurrentUser(ctx context.Context, db *sql.DB, cfg config, w http.ResponseWriter, r *http.Request) error {
	cookie, err := r.Cookie(cfg.AuthCookieName)
	if err == nil && strings.TrimSpace(cookie.Value) != "" {
		if _, err := db.ExecContext(
			ctx,
			`UPDATE user_sessions SET revoked_at = UTC_TIMESTAMP() WHERE session_token_hash = ? AND revoked_at IS NULL`,
			sha256Hex(cookie.Value),
		); err != nil {
			return err
		}
	}

	http.SetCookie(w, &http.Cookie{
		Name:     cfg.AuthCookieName,
		Value:    "",
		Path:     "/",
		Expires:  time.Unix(0, 0),
		MaxAge:   -1,
		HttpOnly: true,
		SameSite: http.SameSiteLaxMode,
		Secure:   strings.HasPrefix(cfg.OAuthRedirectBaseURL, "https://"),
	})
	return nil
}

func googleOAuthRedirectURI(cfg config) string {
	return strings.TrimRight(cfg.OAuthRedirectBaseURL, "/") + "/api/auth/google/callback"
}

func randomURLToken(byteLength int) (string, error) {
	if byteLength <= 0 {
		return "", validationError("token length must be positive")
	}
	buffer := make([]byte, byteLength)
	if _, err := rand.Read(buffer); err != nil {
		return "", err
	}
	return hex.EncodeToString(buffer), nil
}

func safeRedirectPath(value string) string {
	redirectPath := strings.TrimSpace(value)
	if redirectPath == "" {
		return "/"
	}
	if !strings.HasPrefix(redirectPath, "/") || strings.HasPrefix(redirectPath, "//") {
		return "/"
	}
	return redirectPath
}

func getMe(ctx context.Context, db *sql.DB, cfg config, r *http.Request) (meResponse, error) {
	cookie, err := r.Cookie(cfg.AuthCookieName)
	if err != nil || strings.TrimSpace(cookie.Value) == "" {
		return meResponse{Authenticated: false}, nil
	}

	const query = `
SELECT
  u.id,
  u.display_name,
  COALESCE(u.email, ''),
  COALESCE(u.avatar_url, ''),
  COALESCE(p.instrument, 'guitar'),
  CAST(COALESCE(p.preferred_keys_json, JSON_ARRAY()) AS CHAR),
  COALESCE(p.capo_enabled, 1),
  COALESCE(p.max_capo, 5),
  COALESCE(p.piano_transpose_enabled, 1),
  COALESCE(p.show_original_key, 1)
FROM user_sessions s
JOIN users u ON u.id = s.user_id
LEFT JOIN user_preferences p ON p.user_id = u.id
WHERE s.session_token_hash = ?
  AND s.revoked_at IS NULL
  AND s.expires_at > UTC_TIMESTAMP()
  AND u.status = 'active'
LIMIT 1`

	var user currentUserResponse
	var preferences userPreferencesResponse
	var preferredKeysJSON string
	var capoEnabled int
	var pianoTransposeEnabled int
	var showOriginalKey int
	err = db.QueryRowContext(ctx, query, sha256Hex(cookie.Value)).Scan(
		&user.ID,
		&user.DisplayName,
		&user.Email,
		&user.AvatarURL,
		&preferences.Instrument,
		&preferredKeysJSON,
		&capoEnabled,
		&preferences.MaxCapo,
		&pianoTransposeEnabled,
		&showOriginalKey,
	)
	if errors.Is(err, sql.ErrNoRows) {
		return meResponse{Authenticated: false}, nil
	}
	if err != nil {
		return meResponse{}, err
	}

	preferredKeys, err := parsePreferredKeysJSON(preferredKeysJSON)
	if err != nil {
		return meResponse{}, err
	}
	preferences.PreferredKeys = preferredKeys
	preferences.CapoEnabled = capoEnabled == 1
	preferences.PianoTransposeEnabled = pianoTransposeEnabled == 1
	preferences.ShowOriginalKey = showOriginalKey == 1

	return meResponse{
		Authenticated: true,
		User:          &user,
		Preferences:   &preferences,
	}, nil
}

func currentUserIDFromRequest(ctx context.Context, db *sql.DB, cfg config, r *http.Request) (int64, bool, error) {
	cookie, err := r.Cookie(cfg.AuthCookieName)
	if err != nil || strings.TrimSpace(cookie.Value) == "" {
		return 0, false, nil
	}

	const query = `
SELECT u.id
FROM user_sessions s
JOIN users u ON u.id = s.user_id
WHERE s.session_token_hash = ?
  AND s.revoked_at IS NULL
  AND s.expires_at > UTC_TIMESTAMP()
  AND u.status = 'active'
LIMIT 1`

	var userID int64
	err = db.QueryRowContext(ctx, query, sha256Hex(cookie.Value)).Scan(&userID)
	if errors.Is(err, sql.ErrNoRows) {
		return 0, false, nil
	}
	if err != nil {
		return 0, false, err
	}
	return userID, true, nil
}

func updateUserPreferences(
	ctx context.Context,
	db *sql.DB,
	userID int64,
	payload updateUserPreferencesRequest,
) (userPreferencesResponse, error) {
	preferences, err := normalizeUserPreferences(payload)
	if err != nil {
		return userPreferencesResponse{}, err
	}

	preferredKeysJSON, err := json.Marshal(preferences.PreferredKeys)
	if err != nil {
		return userPreferencesResponse{}, err
	}

	const query = `
INSERT INTO user_preferences (
  user_id,
  instrument,
  preferred_keys_json,
  capo_enabled,
  max_capo,
  piano_transpose_enabled,
  show_original_key
) VALUES (?, ?, ?, ?, ?, ?, ?)
ON DUPLICATE KEY UPDATE
  instrument = VALUES(instrument),
  preferred_keys_json = VALUES(preferred_keys_json),
  capo_enabled = VALUES(capo_enabled),
  max_capo = VALUES(max_capo),
  piano_transpose_enabled = VALUES(piano_transpose_enabled),
  show_original_key = VALUES(show_original_key)`

	_, err = db.ExecContext(
		ctx,
		query,
		userID,
		preferences.Instrument,
		string(preferredKeysJSON),
		boolParam(preferences.CapoEnabled),
		preferences.MaxCapo,
		boolParam(preferences.PianoTransposeEnabled),
		boolParam(preferences.ShowOriginalKey),
	)
	if err != nil {
		return userPreferencesResponse{}, err
	}

	return preferences, nil
}

func normalizeUserPreferences(payload updateUserPreferencesRequest) (userPreferencesResponse, error) {
	instrument := strings.ToLower(strings.TrimSpace(payload.Instrument))
	if instrument == "" {
		instrument = "guitar"
	}
	switch instrument {
	case "guitar", "piano", "vocal", "other":
	default:
		return userPreferencesResponse{}, validationError("instrument must be guitar, piano, vocal, or other")
	}

	if payload.MaxCapo < 0 || payload.MaxCapo > 12 {
		return userPreferencesResponse{}, validationError("maxCapo must be between 0 and 12")
	}

	preferredKeys := make([]string, 0, len(payload.PreferredKeys))
	seenKeys := make(map[string]struct{}, len(payload.PreferredKeys))
	for _, key := range payload.PreferredKeys {
		normalizedKey := strings.TrimSpace(key)
		if normalizedKey == "" {
			continue
		}
		if len(normalizedKey) > 16 {
			return userPreferencesResponse{}, validationError("preferred key is too long")
		}
		if _, exists := seenKeys[normalizedKey]; exists {
			continue
		}
		seenKeys[normalizedKey] = struct{}{}
		preferredKeys = append(preferredKeys, normalizedKey)
	}
	if len(preferredKeys) > 12 {
		return userPreferencesResponse{}, validationError("preferredKeys must contain at most 12 keys")
	}

	return userPreferencesResponse{
		Instrument:            instrument,
		PreferredKeys:         preferredKeys,
		CapoEnabled:           payload.CapoEnabled,
		MaxCapo:               payload.MaxCapo,
		PianoTransposeEnabled: payload.PianoTransposeEnabled,
		ShowOriginalKey:       payload.ShowOriginalKey,
	}, nil
}

func getUserSongPreference(ctx context.Context, db *sql.DB, userID int64, songID string) (userSongPreferenceResponse, error) {
	normalizedSongID, err := normalizeSongID(songID)
	if err != nil {
		return userSongPreferenceResponse{}, err
	}

	const query = `
SELECT
  COALESCE(target_key, ''),
  transpose_steps,
  capo,
  COALESCE(note, '')
FROM user_song_preferences
WHERE user_id = ? AND song_id = ?
LIMIT 1`

	preference := userSongPreferenceResponse{SongID: normalizedSongID}
	var transposeSteps sql.NullInt64
	var capo sql.NullInt64
	err = db.QueryRowContext(ctx, query, userID, normalizedSongID).Scan(
		&preference.TargetKey,
		&transposeSteps,
		&capo,
		&preference.Note,
	)
	if errors.Is(err, sql.ErrNoRows) {
		return preference, nil
	}
	if err != nil {
		return userSongPreferenceResponse{}, err
	}

	preference.TransposeSteps = intPtrFromNull(transposeSteps)
	preference.Capo = intPtrFromNull(capo)
	return preference, nil
}

func updateUserSongPreference(
	ctx context.Context,
	db *sql.DB,
	userID int64,
	songID string,
	payload updateUserSongPreferenceRequest,
) (userSongPreferenceResponse, error) {
	preference, err := normalizeUserSongPreference(songID, payload)
	if err != nil {
		return userSongPreferenceResponse{}, err
	}

	const query = `
INSERT INTO user_song_preferences (
  user_id,
  song_id,
  target_key,
  transpose_steps,
  capo,
  note
) VALUES (?, ?, NULLIF(?, ''), ?, ?, NULLIF(?, ''))
ON DUPLICATE KEY UPDATE
  target_key = VALUES(target_key),
  transpose_steps = VALUES(transpose_steps),
  capo = VALUES(capo),
  note = VALUES(note)`

	_, err = db.ExecContext(
		ctx,
		query,
		userID,
		preference.SongID,
		preference.TargetKey,
		optionalIntPtrParam(preference.TransposeSteps),
		optionalIntPtrParam(preference.Capo),
		preference.Note,
	)
	if err != nil {
		return userSongPreferenceResponse{}, err
	}

	return preference, nil
}

func deleteUserSongPreference(ctx context.Context, db *sql.DB, userID int64, songID string) (userSongPreferenceResponse, error) {
	normalizedSongID, err := normalizeSongID(songID)
	if err != nil {
		return userSongPreferenceResponse{}, err
	}

	_, err = db.ExecContext(ctx, `DELETE FROM user_song_preferences WHERE user_id = ? AND song_id = ?`, userID, normalizedSongID)
	if err != nil {
		return userSongPreferenceResponse{}, err
	}

	return userSongPreferenceResponse{SongID: normalizedSongID}, nil
}

func normalizeUserSongPreference(
	songID string,
	payload updateUserSongPreferenceRequest,
) (userSongPreferenceResponse, error) {
	normalizedSongID, err := normalizeSongID(songID)
	if err != nil {
		return userSongPreferenceResponse{}, err
	}

	targetKey := strings.TrimSpace(payload.TargetKey)
	if len(targetKey) > 16 {
		return userSongPreferenceResponse{}, validationError("targetKey is too long")
	}

	if payload.TransposeSteps != nil && (*payload.TransposeSteps < -11 || *payload.TransposeSteps > 11) {
		return userSongPreferenceResponse{}, validationError("transposeSteps must be between -11 and 11")
	}

	if payload.Capo != nil && (*payload.Capo < 0 || *payload.Capo > 12) {
		return userSongPreferenceResponse{}, validationError("capo must be between 0 and 12")
	}

	note := strings.TrimSpace(payload.Note)
	if len(note) > 1000 {
		return userSongPreferenceResponse{}, validationError("note is too long")
	}

	return userSongPreferenceResponse{
		SongID:         normalizedSongID,
		TargetKey:      targetKey,
		TransposeSteps: payload.TransposeSteps,
		Capo:           payload.Capo,
		Note:           note,
	}, nil
}

func normalizeSongID(songID string) (string, error) {
	normalizedSongID := strings.TrimSpace(songID)
	if normalizedSongID == "" {
		return "", validationError("song id is required")
	}
	if len(normalizedSongID) > 64 {
		return "", validationError("song id is too long")
	}
	return normalizedSongID, nil
}

func sha256Hex(value string) string {
	sum := sha256.Sum256([]byte(value))
	return hex.EncodeToString(sum[:])
}

func boolParam(value bool) int {
	if value {
		return 1
	}
	return 0
}

func optionalIntPtrParam(value *int) any {
	if value == nil {
		return nil
	}
	return *value
}

func parsePreferredKeysJSON(value string) ([]string, error) {
	if strings.TrimSpace(value) == "" {
		return []string{}, nil
	}

	var keys []string
	if err := json.Unmarshal([]byte(value), &keys); err != nil {
		return nil, err
	}
	if keys == nil {
		return []string{}, nil
	}
	return keys, nil
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

	songID, err := uniqueSongID(ctx, tx, version.ID, normalized.Title, fmt.Sprintf("song-%d", nextNumber))
	if err != nil {
		return approveSubmissionResponse{}, err
	}
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

	songID, err := uniqueSongID(ctx, tx, version.ID, normalized.Title, fmt.Sprintf("song-%d", nextNumber))
	if err != nil {
		return approveSubmissionResponse{}, err
	}
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

func uniqueSongID(ctx context.Context, tx *sql.Tx, catalogVersionID int64, title string, fallback string) (string, error) {
	base := songSlug(title, fallback)
	songID := base
	for suffix := 2; ; suffix++ {
		var exists int
		if err := tx.QueryRowContext(ctx, `SELECT COUNT(*) FROM songs WHERE catalog_version_id = ? AND id = ?`, catalogVersionID, songID).Scan(&exists); err != nil {
			return "", err
		}
		if exists == 0 {
			return songID, nil
		}
		songID = fmt.Sprintf("%s-%d", base, suffix)
	}
}

func songSlug(title string, fallback string) string {
	var builder strings.Builder
	lastDash := false
	for _, letter := range strings.ToLower(title) {
		part, ok := transliterateLetter(letter)
		if !ok {
			if !lastDash && builder.Len() > 0 {
				builder.WriteByte('-')
				lastDash = true
			}
			continue
		}
		builder.WriteString(part)
		lastDash = false
	}

	slug := strings.Trim(builder.String(), "-")
	if slug == "" {
		return fallback
	}
	return slug
}

func transliterateLetter(letter rune) (string, bool) {
	switch letter {
	case 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9':
		return string(letter), true
	case 'а':
		return "a", true
	case 'б':
		return "b", true
	case 'в':
		return "v", true
	case 'г':
		return "g", true
	case 'д':
		return "d", true
	case 'е', 'ё':
		return "e", true
	case 'ж':
		return "zh", true
	case 'з':
		return "z", true
	case 'и', 'й':
		return "i", true
	case 'к':
		return "k", true
	case 'л':
		return "l", true
	case 'м':
		return "m", true
	case 'н':
		return "n", true
	case 'о':
		return "o", true
	case 'п':
		return "p", true
	case 'р':
		return "r", true
	case 'с':
		return "s", true
	case 'т':
		return "t", true
	case 'у':
		return "u", true
	case 'ф':
		return "f", true
	case 'х':
		return "h", true
	case 'ц':
		return "cz", true
	case 'ч':
		return "ch", true
	case 'ш':
		return "sh", true
	case 'щ':
		return "sch", true
	case 'ы':
		return "y", true
	case 'ь', 'ъ':
		return "", true
	case 'э':
		return "e", true
	case 'ю':
		return "yu", true
	case 'я':
		return "ya", true
	default:
		return "", false
	}
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
			if currentIndex >= 0 && len(sections[currentIndex].Lines) > 0 {
				currentIndex = -1
			}
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
			currentIndex = len(sections) - 1
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
		if line == "" {
			currentIndex = -1
			hasHeadings = true
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

package main

import (
	"errors"
	"log"
	"net/http"
	"net/http/httputil"
	"net/url"
	"os"
	"path/filepath"
	"strings"
	"time"
)

type spaHandler struct {
	staticDir string
	indexPath string
}

func main() {
	staticDir := getenv("STATIC_DIR", "dist")
	httpAddr := getenv("HTTP_ADDR", ":8080")

	mux := http.NewServeMux()
	upstream := getenv("API_UPSTREAM", "http://christian-songbook-api:8082")
	proxyURL, err := url.Parse(upstream)
	if err != nil {
		log.Fatalf("invalid API_UPSTREAM: %v", err)
	}
	mux.Handle("/api/", httputil.NewSingleHostReverseProxy(proxyURL))

	mux.Handle("/", spaHandler{
		staticDir: staticDir,
		indexPath: filepath.Join(staticDir, "index.html"),
	})

	server := &http.Server{
		Addr:              httpAddr,
		Handler:           mux,
		ReadHeaderTimeout: 5 * time.Second,
	}

	log.Printf("starting christian-songbook web on %s", httpAddr)
	if err := server.ListenAndServe(); err != nil && !errors.Is(err, http.ErrServerClosed) {
		log.Fatal(err)
	}
}

func (h spaHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodGet && r.Method != http.MethodHead {
		http.Error(w, "method not allowed", http.StatusMethodNotAllowed)
		return
	}

	cleanPath := filepath.Clean(strings.TrimPrefix(r.URL.Path, "/"))
	if cleanPath == "." {
		cleanPath = "index.html"
	}

	fullPath := filepath.Join(h.staticDir, cleanPath)
	if !strings.HasPrefix(fullPath, filepath.Clean(h.staticDir)+string(os.PathSeparator)) && fullPath != filepath.Clean(h.staticDir) {
		http.NotFound(w, r)
		return
	}

	if info, err := os.Stat(fullPath); err == nil && !info.IsDir() {
		setCacheHeaders(w, r.URL.Path)
		http.ServeFile(w, r, fullPath)
		return
	}

	setCacheHeaders(w, "/")
	http.ServeFile(w, r, h.indexPath)
}

func setCacheHeaders(w http.ResponseWriter, requestPath string) {
	switch {
	case strings.HasPrefix(requestPath, "/assets/"):
		w.Header().Set("Cache-Control", "public, max-age=31536000, immutable")
	case requestPath == "/sw.js" || requestPath == "/manifest.webmanifest" || requestPath == "/":
		w.Header().Set("Cache-Control", "no-store, no-cache, must-revalidate, proxy-revalidate")
	default:
		w.Header().Set("Cache-Control", "public, max-age=300")
	}
}

func getenv(key string, fallback string) string {
	value := os.Getenv(key)
	if value == "" {
		return fallback
	}
	return value
}

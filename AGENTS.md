# AGENTS - Христианский сборник песен

## Product identity
- Display name: `Христианский сборник песен`.
- Keep technical identifiers such as package names, image names, repository names, and service names stable unless the user explicitly asks to rename infrastructure.
- UI language is Russian.
- The product is an offline-first PWA for church song reading, chords, transposition, local collections, and live/service preparation.

## Architecture snapshot
- Frontend: React + TypeScript + Vite.
- Offline storage: bundled catalog plus IndexedDB/local snapshot cache.
- Backend: Go HTTP API with MySQL catalog storage.
- Admin: separate `/admin` route protected by `ADMIN_API_KEY`.
- Deployment: web and backend are built as separate Docker images and deployed through GitHub Actions plus the management playbook.

## Required engineering behavior
- Preserve offline catalog reading for regular users.
- Do not make backend availability required for opening already bundled or locally cached songs.
- Keep regular user flows read-only against the backend.
- Do not expose admin import/export/editing controls in the regular user UI.
- Do not add public API routes, admin mutation behavior, auth/security changes, schema changes, migrations, or production deployment changes without explicit user confirmation.
- Keep song IDs/slugs self-contained and derived from song titles; do not encode external source names in public routes or bundled catalog IDs.
- Keep transposition, BPM, playback, and view settings scoped to the current song when the UI behavior is song-specific.
- Keep live collections separate from normal user collections unless the user explicitly asks to merge those concepts.

## UI style
- Style direction: calm, readable, service-ready, mobile-first.
- Lyrics and chords are the highest priority visual layer.
- Use semantic CSS variables/tokens for colors, spacing, radius, elevation, typography, and states.
- Do not introduce one-off raw colors in components.
- Keep the main catalog focused on search, categories, recent songs, collections, and song reading.
- Use compact status indicators; detailed network/catalog/sync text belongs in settings or overflow areas.
- Avoid marketing hero sections, decorative blobs, emoji-as-icons, hover-only controls, and fixed-width layouts that create mobile horizontal scroll.
- Touch targets must stay at least `44px` where practical.
- Preserve visible focus states and accessible labels/titles for icon-only or status-only controls.

## Documentation rules
- Update relevant docs in the same change when behavior, data shape, API, config, deployment, seed/import flow, or project rules change.
- If docs are not updated, state the reason in the final response.
- Keep project docs factual and specific to this repository; remove stale phase wording when implementation has moved past it.
- Prefer English for agent and engineering instruction files. Keep user-facing product text in Russian.

## Checks
- Frontend/code changes: run `npm test` and `npm run build` unless the change is docs-only or tooling is unavailable.
- Backend changes: run `cd backend && go test ./...` for Go code changes.
- Docker/deployment changes: run the narrowest relevant Docker/GitHub Actions syntax check available.
- UI changes should be checked on mobile and desktop viewports when practical; report skipped visual checks explicitly.
- Final reports must list only checks that actually ran.

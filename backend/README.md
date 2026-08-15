# Христианский сборник песен Backend

Local backend foundation for Phase 1.5.

Current scope:
- Go HTTP service with health endpoints.
- MySQL-backed read-only catalog endpoints.
- Initial catalog schema and seed data via `migrations/001_catalog.up.sql`.
- Admin-key protected minimal catalog management endpoints.
- Optional song playback fields: `bpm`, `beatsPerLine`, `introBeats`.

Endpoints:
- `GET /healthz` - service liveness.
- `GET /readyz` - service readiness and MySQL reachability.
- `GET /api/catalog/version` - current published catalog version.
- `GET /api/catalog/snapshot` - published catalog snapshot for PWA local cache, including song categories, capped at 1000 songs.
- `GET /api/songs` - published song list with categories, optional `?query=` search, capped at 1000 songs.
- `GET /api/songs/{id}` - one song in the frontend-compatible shape.
- `GET /api/auth/google/start?redirect=/settings` - starts Google OAuth when provider env is configured.
- `GET /api/auth/google/callback` - handles Google OAuth callback, creates/updates user identity, and sets an app session cookie.
- `POST /api/auth/logout` - revokes the current app session and clears the session cookie.
- `GET /api/me` - optional current-user endpoint; returns `authenticated=false` when no valid session exists.
- `PUT /api/me/preferences` - authenticated user global preference upsert.
- `GET /api/me/song-preferences/{id}` - authenticated per-song preference read.
- `PUT /api/me/song-preferences/{id}` - authenticated per-song preference upsert.
- `DELETE /api/me/song-preferences/{id}` - authenticated per-song preference reset.
- `GET /api/admin/song-submissions` - admin-only pending song submissions.
- `PUT /api/admin/song-submissions/{id}` - admin-only edit for pending song submissions.
- `POST /api/admin/songs` - admin-only direct publish into the current MySQL catalog.
- `POST /api/admin/song-submissions/{id}/approve` - admin-only approve for pending song submissions.
- `POST /api/admin/song-submissions/{id}/reject` - admin-only reject for pending song submissions.

Environment:
- `SERVICE_NAME` default `christian-songbook-api`
- `HTTP_ADDR` default `:8082`
- `DB_HOST` default `127.0.0.1`
- `DB_PORT` default `3306`
- `DB_NAME` default `christian_songbook`
- `DB_USER` default `songbook`
- `DB_PASSWORD` default `songbook`
- `ADMIN_API_KEY` default `123456`, used as a local/dev fallback

Rules:
- Regular user flows stay read-only.
- Admin catalog mutation is protected by `X-Admin-Key`; keep a non-default `ADMIN_API_KEY` in production and replace this with a stronger auth/security design before broader team access.
- Frontend offline reading must not depend on backend availability.
- Playback fields are optional; clients keep local defaults when a song has no stored playback settings.

User account foundation:
- Users authenticate through external OAuth providers only; the app does not store passwords.
- Accounts and personal settings are optional; regular catalog reading works while logged out.
- Google OAuth is the first target provider; Apple OAuth uses the same identity/session model after provider setup is ready.
- Google OAuth start returns `503` until `GOOGLE_OAUTH_CLIENT_ID` and `GOOGLE_OAUTH_CLIENT_SECRET` are configured.
- Session tokens are stored as hashes in MySQL and sent to clients through `HttpOnly` cookies.
- Saving preferences requires a valid app session; anonymous users receive `401` and can keep using the catalog.
- Personal song preferences store target key, transpose steps, capo hint, and notes without mutating canonical song rows, and can be reset per song.

Additional environment for upcoming auth implementation:
- `AUTH_COOKIE_NAME` default `christian_songbook_session`
- `AUTH_SESSION_TTL_HOURS` default `720`
- `OAUTH_REDIRECT_BASE_URL` public web origin used for OAuth callbacks
- `GOOGLE_OAUTH_CLIENT_ID`
- `GOOGLE_OAUTH_CLIENT_SECRET`
- `APPLE_OAUTH_CLIENT_ID`
- `APPLE_OAUTH_TEAM_ID`
- `APPLE_OAUTH_KEY_ID`
- `APPLE_OAUTH_PRIVATE_KEY_PATH`

# Christian Songbook Backend

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

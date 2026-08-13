# Christian Songbook Backend

Local backend foundation for Phase 1.5.

Current scope:
- Go HTTP service with health endpoints.
- MySQL-backed read-only catalog endpoints.
- Initial catalog schema and seed data via `migrations/001_catalog.up.sql`.
- No auth.
- No admin mutation API.

Endpoints:
- `GET /healthz` - service liveness.
- `GET /readyz` - service readiness and MySQL reachability.
- `GET /api/catalog/version` - current published catalog version.
- `GET /api/catalog/snapshot` - full published catalog snapshot for PWA local cache, including song categories.
- `GET /api/songs` - published song list with categories, optional `?query=` search.
- `GET /api/songs/{id}` - one song in the frontend-compatible shape.

Environment:
- `SERVICE_NAME` default `christian-songbook-api`
- `HTTP_ADDR` default `:8082`
- `DB_HOST` default `127.0.0.1`
- `DB_PORT` default `3306`
- `DB_NAME` default `christian_songbook`
- `DB_USER` default `songbook`
- `DB_PASSWORD` default `songbook`

Rules:
- Regular user flows stay read-only.
- Admin catalog mutation must wait for auth/security design.
- Frontend offline reading must not depend on backend availability.

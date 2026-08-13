# Backend + MySQL Plan

## Goal
Add a backend and MySQL as the canonical data layer for songs, catalog versions, admin operations, and future user-linked features, while preserving the PWA offline-first reading experience.

## Core Decision
The frontend must not depend on the network for basic reading after initial catalog sync.

Backend + MySQL becomes:
- source of truth for the unified song catalog;
- admin-only place for catalog editing/import/export;
- future source for users, collections sync, setlists, and live sessions.

The PWA keeps:
- local app shell cache;
- local catalog snapshot;
- local read path when offline;
- local display settings.

## Recommended Backend Shape
- Backend service: Go API service by default, because live-sync/WebSocket work is expected later.
- Database: MySQL.
- SQL style: native SQL, explicit migrations, explicit indexes.
- Runtime: Docker-first, with app and MySQL runnable locally in parallel.
- API style for early phases: REST JSON. Do not introduce gRPC before there is a service boundary that justifies it.

PHP remains acceptable if the implementation later needs to fit an existing PHP stack, but the current project does not require that yet.

## Current Phase 1.5 Scaffold
- `backend/cmd/api`: Go HTTP service.
- `GET /healthz`: service liveness.
- `GET /readyz`: MySQL readiness.
- `GET /api/catalog/version`: current published catalog version.
- `GET /api/catalog/snapshot`: full published catalog snapshot for PWA local cache.
- `GET /api/songs`: published song list with optional `query`.
- `GET /api/songs/{id}`: one published song in the frontend-compatible shape.
- `POST /api/song-submissions`: public pending song proposal endpoint with size/required-field validation.
- `GET /api/admin/song-submissions`: admin-key protected pending submissions list.
- `POST /api/admin/song-submissions/{id}/approve`: admin-key protected approval that appends the song to the current catalog version.
- `docker-compose.yml`: local MySQL + backend.
- `migrations/001_catalog.up.sql`: read-only catalog schema and initial seed catalog.
- `migrations/001_catalog.down.sql`: rollback for the initial catalog schema.
- `migrations/003_song_submissions.up.sql`: pending song submissions.

This scaffold intentionally does not include full user auth, users, collections sync, setlists, or live session tables.
Admin mutation endpoints are protected by `ADMIN_API_KEY` and must be replaced or extended with a real auth/audit model before broader team administration.

## Domain Boundaries
- Catalog: songs, sections, lines, chords, tags, catalog versions.
- Users: accounts or invite-based identities in later phases.
- User Library: collections, display preferences, recently opened songs.
- Setlists: planned worship sets and song order.
- Live Sessions: current song/section/line position, participants, role views.

## Initial MySQL Entities
Implemented now:

- `catalog_versions`: published snapshot metadata.
- `songs`: stable song identity, number, title, category, default key, status.
- `song_sections`: song section order and type (`verse`, `chorus`, `bridge`).
- `song_lines`: text lines ordered inside a section.
- `song_line_chords`: chord tokens linked to line/order.

Planned later after user/auth confirmation:

- `song_tags`: searchable tags.
- `users`: future user identities.
- `user_collections`: user-owned song collections.
- `user_collection_items`: song membership inside user collections.
- `setlists`: worship set headers.
- `setlist_items`: setlist song order and overrides.
- `live_sessions`: current worship session state.
- `live_participants`: user/device role inside a session.

## Future User-Link Model Draft
This is a planning draft only. Do not add these tables to production migrations until auth, invite, and ownership rules are approved.

### Identity
- `users`
  - `id`: stable internal identity.
  - `display_name`: visible participant name.
  - `status`: `active`, `disabled`.
  - `created_at`, `updated_at`.
- Early implementation can use invite-based identities instead of external OAuth. Passwords, OAuth accounts, and long-lived session storage require a separate auth/security decision.

### User collections
- `user_collections`
  - `id`, `user_id`, `name`, `description`, `created_at`, `updated_at`.
  - Purpose: personal or team-visible song groups selected from the canonical catalog.
- `user_collection_items`
  - `collection_id`, `song_id`, `position`, `note`, `created_at`.
  - Purpose: ordered membership only; it must not duplicate song text/chords from the catalog.

Expected access patterns:
- list collections for a user;
- fetch one collection with ordered songs;
- add/remove/reorder songs inside one collection.

Indexes:
- `user_collections(user_id, name)`.
- `user_collection_items(collection_id, position)`.
- `user_collection_items(collection_id, song_id)` unique.

### Setlists
- `setlists`
  - `id`, `owner_user_id`, `title`, `date`, `status`, `created_at`, `updated_at`.
  - `status`: draft values `draft`, `ready`, `archived`.
- `setlist_items`
  - `setlist_id`, `song_id`, `position`, `preferred_key`, `tempo_bpm`, `beats_per_line`, `intro_beats`, `note`.
  - Purpose: performance-specific ordering and playback hints without mutating the canonical song.

Expected access patterns:
- list upcoming setlists for a user/team;
- fetch a setlist with ordered songs and playback metadata;
- reorder setlist items atomically.

Indexes:
- `setlists(owner_user_id, date)`.
- `setlist_items(setlist_id, position)`.
- `setlist_items(setlist_id, song_id)`.

### Live sessions
- `live_sessions`
  - `id`, `setlist_id`, `leader_user_id`, `code`, `status`, `active_song_id`, `active_section_id`, `active_line_index`, `revision`, `started_at`, `ended_at`, `updated_at`.
  - `status`: draft values `planned`, `active`, `ended`.
  - `revision`: monotonic counter for idempotent future sync events.
- `live_participants`
  - `session_id`, `user_id`, `device_id`, `role_preset`, `last_seen_at`.
  - `role_preset`: draft values `lead`, `singer`, `chords`.

Expected access patterns:
- join a live session by code;
- fetch current session position;
- update position from a master/leader role;
- list active participants.

Indexes:
- `live_sessions(code)` unique if join codes are used.
- `live_sessions(status, updated_at)`.
- `live_participants(session_id, user_id)`.
- `live_participants(session_id, device_id)`.

### Data safety rules
- User-linked tables must reference canonical `songs`; do not copy lyrics/chords into collections, setlists, or live session rows.
- Reordering collections/setlists should be transactional.
- Position updates should use optimistic concurrency with `revision` once live sync is implemented.
- Access checks must be defined before any write API is exposed.
- Offline PWA reading must continue to use the latest local catalog snapshot when user-linked backend state is unavailable.

## Access Patterns
- List songs by current published catalog version.
- Search songs by title, number, text, and tags.
- Fetch one song with ordered sections, lines, and chords.
- Fetch changed catalog data since version.
- Save user collection state.
- Fetch setlist with songs in display order.
- Update live session position from a master role.

## Indexing Notes
- `songs(number)`, `songs(status)`.
- `songs(title)` or full-text strategy once data volume is known.
- `song_sections(song_id, position)`.
- `song_lines(section_id, position)`.
- `song_chords(line_id, position)`.
- `user_collections(user_id, name)` index.
- `user_collection_items(collection_id, song_id)` unique.
- `setlist_items(setlist_id, position)`.
- `live_sessions(code)` unique if join codes are used.

Use `EXPLAIN` once real queries exist.

## Sync Strategy
1. Backend publishes a catalog version.
2. PWA checks current version when online.
3. If version changed, PWA downloads a compact catalog snapshot.
4. PWA persists snapshot locally.
5. Offline reading uses the local snapshot without blocking on network.

Conflict policy:
- Regular users do not edit the catalog.
- Admin catalog edits happen on backend only.
- User-local settings can remain local until user accounts are introduced.

## Admin Catalog Management Plan
This is a planning draft only. Do not expose admin mutation endpoints until auth, audit, and ownership rules are approved.

### Goal
Admin flow should let a trusted maintainer import, review, edit, and publish the canonical song catalog without exposing catalog mutation tools to regular users.

### Draft flow
1. Admin prepares an import file from a trusted source.
2. Backend validates the file into a draft catalog version.
3. Admin reviews validation errors, duplicate matches, categories, keys, lyrics, and chord line alignment.
4. Backend stores the draft separately from the current published catalog.
5. Admin publishes the draft as a new `catalog_versions` row and marks it current in one transaction.
6. PWA clients discover the new version through `/api/catalog/version` and download `/api/catalog/snapshot`.

### Draft entities
- `catalog_import_jobs`
  - import status, source metadata, validation summary, created by admin.
- `catalog_draft_versions`
  - unpublished catalog version candidate.
- `catalog_draft_songs`
  - normalized song draft rows before publication.
- `catalog_audit_log`
  - append-only admin action log.

These entities are not in production migrations yet. They need auth/security approval before implementation.

### Validation rules
- Reject empty title, empty song body, invalid section order, or chord rows that cannot be mapped to song lines.
- Normalize category using the approved Russian category list; unknown categories should be review warnings, not silent replacements.
- Detect possible duplicates by title and normalized lyrics.
- Keep original source metadata for audit, but do not expose it to regular PWA clients.

### Publication safety
- Publishing must be transactional: either the whole new catalog version becomes current, or the previous current version remains active.
- Never update published song rows in place for catalog content changes; publish a new version instead.
- Rollback should mark the previous known-good catalog version as current, not delete historical rows.
- Regular PWA read APIs must continue to serve only published versions.

### Access control requirements before implementation
- Admin identity and session model.
- Least-privilege admin roles for import, edit, publish, and rollback.
- Audit trail for every import, publish, rollback, and destructive draft cleanup.
- Rate limits or upload size limits for import endpoints.
- No secrets, raw credentials, or private source tokens in import logs.

## Phase Safety Rules
- Do not add auth, users, or public write APIs in Phase 1.
- Do not expose admin catalog mutation without auth.
- Do not make frontend reading depend on backend availability.
- Do not introduce realtime/live transport before the catalog backend is stable.

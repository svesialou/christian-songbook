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
- `docker-compose.yml`: local MySQL + backend.
- `migrations/001_catalog.up.sql`: read-only catalog schema and initial seed catalog.
- `migrations/001_catalog.down.sql`: rollback for the initial catalog schema.

This scaffold intentionally does not include auth, admin mutation APIs, users, collections sync, setlists, or live session tables.

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

## Phase Safety Rules
- Do not add auth, users, or public write APIs in Phase 1.
- Do not expose admin catalog mutation without auth.
- Do not make frontend reading depend on backend availability.
- Do not introduce realtime/live transport before the catalog backend is stable.

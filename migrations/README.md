# MySQL Migrations

Current migrations:
- `001_catalog.up.sql` - creates the catalog schema with canonical `songs.lead_sheet` content and seeds the initial empty published catalog version.
- `001_catalog.down.sql` - drops the catalog schema and removes the initial seed catalog.
- `002_song_categories.up.sql` - adds song categories and seed category values.
- `002_song_categories.down.sql` - removes the song category index and column.
- `003_song_submissions.up.sql` - adds pending song submissions for admin approval.
- `003_song_submissions.down.sql` - removes song submissions.
- `004_song_playback.up.sql` - adds optional BPM/autoscroll playback fields to songs and submissions.
- `004_song_playback.down.sql` - removes optional playback fields.
- `005_user_preferences.up.sql` - adds users, OAuth identities, sessions, OAuth state, global preferences, and per-song preferences.
- `005_user_preferences.down.sql` - removes user account and preference tables.
- `006_sheet_music_url.up.sql` - adds optional sheet music URL fields for piano-friendly song view.
- `006_sheet_music_url.down.sql` - removes optional sheet music URL fields.
- `007_song_edit_submissions.up.sql` - adds edit submission source fields for review diffs.
- `007_song_edit_submissions.down.sql` - removes edit submission source fields.
- `008_user_live_state.up.sql` - stores authenticated live collections and active live queue per user.
- `008_user_live_state.down.sql` - removes user live state.
- `009_user_collections.up.sql` - stores authenticated regular collections per user with share tokens.
- `009_user_collections.down.sql` - removes authenticated regular collections.
- `010_user_collection_subscriptions.up.sql` - stores read-only subscriptions to shared user collections.
- `010_user_collection_subscriptions.down.sql` - removes shared collection subscriptions.

Apply locally:
- `make db-migrate`

Rollback locally:
- `make db-rollback`

Rules before adding more migrations:
- Include forward migration and rollback notes.
- Add indexes for real access patterns.
- Use `EXPLAIN` for list/search/song detail queries once data volume becomes representative.
- Do not add destructive migrations without explicit approval.
- During the current development reset, old normalized section tables are intentionally removed; refill published songs from `lead_sheet` seed/import SQL.
- User/auth schema is allowed only through the approved OAuth and personal preferences foundation; avoid password storage.

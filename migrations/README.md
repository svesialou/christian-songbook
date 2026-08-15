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

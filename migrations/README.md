# MySQL Migrations

Current migrations:
- `001_catalog.up.sql` - creates the read-only catalog schema and seeds the initial published catalog.
- `001_catalog.down.sql` - drops the catalog schema and removes the initial seed catalog.
- `002_song_categories.up.sql` - adds song categories and seed category values.
- `002_song_categories.down.sql` - removes the song category index and column.
- `003_song_submissions.up.sql` - adds pending song submissions for admin approval.
- `003_song_submissions.down.sql` - removes song submissions.
- `004_song_playback.up.sql` - adds optional BPM/autoscroll playback fields to songs and submissions.
- `004_song_playback.down.sql` - removes optional playback fields.

Apply locally:
- `make db-migrate`

Rollback locally:
- `make db-rollback`

Rules before adding more migrations:
- Include forward migration and rollback notes.
- Add indexes for real access patterns.
- Use `EXPLAIN` for list/search/song detail queries once data volume becomes representative.
- Do not add destructive migrations without explicit approval.
- Keep user/auth/setlist/live schema out until the user model is confirmed.

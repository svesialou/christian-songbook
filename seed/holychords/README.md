# HolyChords/Fonki/KG Music photo song seed staging

This directory is a staging area for songs identified from the attached mobile app screenshots.

## Important rights rule

Do not commit copied lyrics or chord charts from HolyChords, Fonki, KG Music, or another external catalog unless the team has explicit rights to publish them.

The current staging file stores only metadata that is safe to review:

- source screenshot number and old list number;
- observed title from the screenshot;
- candidate full title from external source metadata;
- category mapped to the local category list;
- source URLs;
- BPM/key only when visible/confirmed from previous manual checks;
- review/import status.

## Files

- `songs.from-photos.staging.json` - metadata manifest for the full visible screenshot list.
- `submissions.generated.sql` - optional generated MySQL seed for pending admin submissions. It is not committed by default.

## Current coverage

The manifest contains old song numbers `1..253`.

Current metadata coverage:

- `253` total rows;
- `252` titles captured from screenshots;
- `1` missing row: number `231` is not visible in the provided screenshots;
- `10` manually confirmed HolyChords URL candidates;
- `87` KG Music URL candidates found through WordPress REST metadata;
- `92` songs have at least one external source candidate;
- `74` songs have a strong source match score;
- `161` songs still need source review or manual fill.

Known gaps:

- titles ending with `...` were truncated by the original mobile UI and need manual confirmation;
- `fonki.pro` HTML search returned no usable candidates for checked samples;
- `holychords.pro/search` is disallowed in `robots.txt`, so only manually confirmed HolyChords URLs are retained;
- lyrics and chords are intentionally empty until an approved content source is provided.

## Next import path

1. Review every `confidence` value below `high` manually.
2. Fill lyrics/chords only from a source the team is allowed to publish.
3. Convert approved songs to the current legacy import shape or add a dedicated importer for this manifest.
4. Generate SQL with the project importer once complete content is available.

Current catalog SQL requires non-empty song sections and lines, so this staging file is intentionally not imported directly into MySQL.

## Generate pending admin submissions

If you want to load the title/source backlog into the admin queue, generate SQL:

```bash
npm run seed:staging:submissions-sql
```

Apply it to local MySQL:

```bash
docker exec -i -e MYSQL_PWD=songbook christian-songbook-mysql \
  mysql --default-character-set=utf8mb4 -usongbook christian_songbook \
  < seed/holychords/submissions.generated.sql
```

The generated rows are marked with `submitter_name = 'Seed import'` and a `[staging:photo-staging-2026-08-13]` note marker.

Do not approve generated rows before replacing the placeholder lyrics/chords with approved song content.

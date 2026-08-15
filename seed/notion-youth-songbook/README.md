# Notion youth songbook staging

This directory contains a staging manifest extracted from the public Notion page:

`https://blagochestie.notion.site/beb07ba87e894122bb76e7872045ccbc`

## Files

- `songs.staging.json` - staging manifest for the imported songbook.
- `catalog.generated.sql` - generated MySQL seed for immediately published songs.
- `submissions.generated.sql` - generated MySQL seed for pending admin submissions.
- App song ids are generated from song titles and do not expose the original import source.

## Current coverage

- `263` song titles extracted from top-level Notion child pages.
- `263` songs have lyrics extracted from Notion song pages.
- `238` songs have chords extracted from nested `*` pages.
- `25` songs remain without extracted chords because Notion did not expose a recognizable chord version.
- Songs without extracted lyrics still use placeholder lyrics and remain safe for manual completion.
- `catalog.generated.sql` publishes all generated rows immediately.
- `submissions.generated.sql` keeps rows `pending` for admin review.

## Refresh Notion content

```bash
npm run seed:songbook:extract
```

The extractor uses Notion's public page chunk endpoint and does not require credentials.

## Generate published catalog seed

```bash
npm run seed:songbook:published-sql
```

Apply to local MySQL after migrations:

```bash
docker exec -i -e MYSQL_PWD=songbook christian-songbook-mysql \
  mysql --default-character-set=utf8mb4 -usongbook christian_songbook \
  < seed/notion-youth-songbook/catalog.generated.sql
```

## Generate pending admin submissions

```bash
npm run seed:songbook:submissions-sql
```

Apply to local MySQL:

```bash
docker exec -i -e MYSQL_PWD=songbook christian-songbook-mysql \
  mysql --default-character-set=utf8mb4 -usongbook christian_songbook \
  < seed/notion-youth-songbook/submissions.generated.sql
```

Do not approve generated rows before replacing placeholder lyrics/chords with approved song content.

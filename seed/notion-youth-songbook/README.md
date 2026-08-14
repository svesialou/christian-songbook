# Notion youth songbook staging

This directory contains a staging manifest extracted from the public Notion page:

`https://blagochestie.notion.site/beb07ba87e894122bb76e7872045ccbc`

## Files

- `songs.staging.json` - staging manifest for the Notion "Молодёжный сборник" page.
- `submissions.generated.sql` - generated MySQL seed for pending admin submissions.

## Current coverage

- `263` song titles extracted from top-level Notion child pages.
- `263` songs have lyrics extracted from Notion song pages.
- `238` songs have chords extracted from nested `*` pages.
- `25` songs remain without extracted chords because Notion did not expose a recognizable chord version.
- Songs without extracted lyrics still use placeholder lyrics and remain safe for manual completion.
- Every generated SQL row remains `pending` for admin review.

## Refresh Notion content

```bash
npm run seed:notion-youth:extract
```

The extractor uses Notion's public page chunk endpoint and does not require credentials.

## Generate pending admin submissions

```bash
npm run seed:notion-youth:submissions-sql
```

Apply to local MySQL:

```bash
docker exec -i -e MYSQL_PWD=songbook christian-songbook-mysql \
  mysql --default-character-set=utf8mb4 -usongbook christian_songbook \
  < seed/notion-youth-songbook/submissions.generated.sql
```

Do not approve generated rows before replacing placeholder lyrics/chords with approved song content.

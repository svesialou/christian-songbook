# Legacy song seed

## Source audit

The reference repository `pavelliolia/christian-songs-mobile-app` does not contain a committed song database, JSON dump, SQLite file, or Realm file.

The mobile app fetches songs from:

```text
https://quiet-sierra-94562.herokuapp.com/songs
```

At the time of the first seed preparation this endpoint returned `404`, so a full automatic import could not be generated from the live source.

## Expected legacy payload

Use the original mobile app `/songs` response shape:

```json
[
  {
    "_id": "legacy-id",
    "name": "Song title",
    "number": 1,
    "verses": [
      {
        "_id": "verse-id",
        "rows": ["Line 1", "Line 2"]
      }
    ],
    "chorus": {
      "_id": "chorus-id",
      "rows": ["Chorus line"]
    },
    "bridge": {
      "_id": "bridge-id",
      "rows": ["Bridge line"]
    },
    "chords": {
      "verse": [
        [
          {
            "_id": "chord-row-id",
            "items": ["C", "G"]
          }
        ]
      ],
      "chorus": [
        {
          "_id": "chorus-chord-row-id",
          "items": ["F"]
        }
      ],
      "bridge": [
        {
          "_id": "bridge-chord-row-id",
          "items": ["Am"]
        }
      ]
    }
  }
]
```

## Generate frontend catalog JSON

```bash
node scripts/import-legacy-songs.mjs \
  --input seed/legacy/songs.dump.json \
  --out src/data/importedCatalog.generated.json
```

## Generate MySQL seed SQL

```bash
node scripts/import-legacy-songs.mjs \
  --input seed/legacy/songs.dump.json \
  --sql-out migrations/003_legacy_catalog_seed.generated.sql \
  --version 2026.08.13.legacy
```

## Try live legacy API

```bash
node scripts/import-legacy-songs.mjs \
  --url https://quiet-sierra-94562.herokuapp.com/songs \
  --out src/data/importedCatalog.generated.json
```

## Category mapping

The importer maps songs to the Russian category list from `src/data/songCategories.ts`.

Mapping is keyword-based and intentionally conservative:

- clear Christmas keywords -> `Рождественские`
- clear Easter/cross/resurrection keywords -> `Пасхальные`
- prayer words -> `Молитвенные`
- praise/worship words -> `Прославление`
- salvation/forgiveness/faith/family/church/etc. keywords -> matching Holychords-derived Russian category
- otherwise -> `Разное`

After a real full dump is available, review the generated categories manually before publishing the seed as current catalog.

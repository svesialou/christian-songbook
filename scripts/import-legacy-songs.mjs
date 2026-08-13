#!/usr/bin/env node
import { execFile } from 'node:child_process';
import { readFile, writeFile } from 'node:fs/promises';
import { promisify } from 'node:util';

const DEFAULT_LEGACY_URL = 'https://quiet-sierra-94562.herokuapp.com/songs';
const DEFAULT_CATEGORY = 'Разное';
const execFileAsync = promisify(execFile);

const CATEGORY_RULES = [
  ['Рождественские', ['рождеств', 'вифлеем', 'ясли', 'младенец']],
  ['Пасхальные', ['пасх', 'воскрес', 'голгоф', 'крест', 'кровь']],
  ['Детские', ['дети', 'детск', 'дитя', 'малыш']],
  ['Дух Святой', ['дух свят', 'утешитель']],
  ['Молитвенные', ['молитв', 'молюсь', 'услышь', 'прошу', 'господи']],
  ['Прославление', ['слав', 'хвал', 'поклон', 'аллилуй']],
  ['Благодарение', ['благодар']],
  ['Божья любовь', ['любов', 'возлюб']],
  ['Вера и упование', ['вер', 'довер', 'упован', 'надежд']],
  ['Спасение', ['спас']],
  ['Прощение', ['прост', 'прощ']],
  ['Церковь', ['церков']],
  ['Небо', ['небес', 'небо']],
  ['Семья', ['семья', 'семье']],
  ['Свадебные', ['свадьб', 'жених', 'невест']],
  ['Хлебопреломление', ['хлеб', 'чаша']],
  ['Крещение', ['крещ']],
  ['Утешение и ободрение', ['утеш', 'ободр']],
  ['Евангелизация', ['евангел', 'благовест']],
  ['Жизнь христианина', ['христиан', 'путь', 'жизнь']],
];

const args = parseArgs(process.argv.slice(2));

if (args.help) {
  printHelp();
  process.exit(0);
}

const rawSongs = await loadLegacySongs(args);
const categories = await loadCategories();
const songs = rawSongs
  .map((song, index) => normalizeLegacySong(song, index, categories))
  .filter((song) => song.verses.length > 0)
  .sort((a, b) => a.number - b.number || a.title.localeCompare(b.title, 'ru'));

if (songs.length === 0) {
  throw new Error('No valid legacy songs found.');
}

if (args.out) {
  await writeFile(args.out, `${JSON.stringify(songs, null, 2)}\n`, 'utf8');
}

if (args.sqlOut) {
  await writeFile(args.sqlOut, buildSeedSQL(songs, args.version || buildVersion()), 'utf8');
}

if (!args.out && !args.sqlOut) {
  process.stdout.write(`${JSON.stringify(songs, null, 2)}\n`);
}

function parseArgs(items) {
  const parsed = {};
  for (let i = 0; i < items.length; i += 1) {
    const item = items[i];
    if (item === '--help' || item === '-h') parsed.help = true;
    else if (item === '--apk') parsed.apk = items[++i];
    else if (item === '--input') parsed.input = items[++i];
    else if (item === '--url') parsed.url = items[++i];
    else if (item === '--out') parsed.out = items[++i];
    else if (item === '--sql-out') parsed.sqlOut = items[++i];
    else if (item === '--version') parsed.version = items[++i];
    else throw new Error(`Unknown argument: ${item}`);
  }
  return parsed;
}

function printHelp() {
  console.log(`Usage:
  node scripts/import-legacy-songs.mjs --apk base.apk --out src/data/importedCatalog.generated.json
  node scripts/import-legacy-songs.mjs --input legacy-songs.json --out src/data/importedCatalog.generated.json
  node scripts/import-legacy-songs.mjs --url ${DEFAULT_LEGACY_URL} --sql-out migrations/003_legacy_catalog_seed.generated.sql

Options:
  --apk        Inspect a React Native APK, extract its legacy /songs API URL, then fetch songs.
  --input      Read legacy /songs JSON from a local file.
  --url        Fetch legacy /songs JSON from a URL. Defaults to the original mobile app API.
  --out        Write normalized frontend catalog JSON.
  --sql-out    Write MySQL seed SQL for the current catalog schema.
  --version    Catalog version for SQL output.
`);
}

async function loadLegacySongs(options) {
  if (options.apk) {
    return loadLegacySongsFromApk(options.apk);
  }

  if (options.input) {
    return parseSongList(await readFile(options.input, 'utf8'));
  }

  const url = options.url || DEFAULT_LEGACY_URL;
  const response = await fetch(url);
  if (!response.ok) {
    throw new Error(`Legacy songs request failed: ${response.status} ${response.statusText}`);
  }
  return parseSongList(await response.text());
}

async function loadLegacySongsFromApk(apkPath) {
  let bundle;
  try {
    const result = await execFileAsync('unzip', ['-p', apkPath, 'assets/index.android.bundle'], {
      maxBuffer: 8 * 1024 * 1024,
    });
    bundle = result.stdout;
  } catch (err) {
    throw new Error(`Failed to extract assets/index.android.bundle from APK: ${err.message}`);
  }

  const baseURL = findBundleString(bundle, 'BASE_URL') || DEFAULT_LEGACY_URL.replace(/\/songs$/, '');
  const songsPath = findBundleString(bundle, 'SONGS') || '/songs';
  const songsURL = new URL(songsPath, baseURL).toString();

  const response = await fetch(songsURL);
  if (!response.ok) {
    throw new Error(
      `APK does not contain an embedded song catalog; discovered legacy API ${songsURL}, but request failed: ${response.status} ${response.statusText}`,
    );
  }

  return parseSongList(await response.text());
}

function findBundleString(bundle, exportName) {
  const pattern = new RegExp(`e\\.${exportName}='([^']+)'`);
  return bundle.match(pattern)?.[1];
}

function parseSongList(text) {
  const payload = JSON.parse(text);
  const songs = Array.isArray(payload) ? payload : payload?.songs;
  if (!Array.isArray(songs)) {
    throw new Error('Legacy payload must be an array or an object with songs array.');
  }
  return songs;
}

async function loadCategories() {
  const source = await readFile('src/data/songCategories.ts', 'utf8');
  const categories = [...source.matchAll(/'([^']+)'/g)].map((match) => match[1]);
  return new Set(categories);
}

function normalizeLegacySong(raw, index, categories) {
  const number = Number(raw?.number) || index + 1;
  const title = String(raw?.name || raw?.title || `Песня ${number}`).trim();
  const id = normalizeId(raw?._id || raw?.id || `legacy-${number}`);
  const category = inferCategory(raw, categories);

  return {
    id,
    number,
    title,
    category,
    verses: normalizeVerses(raw?.verses, raw?.chords?.verse),
    chorus: normalizeSection(raw?.chorus, raw?.chords?.chorus),
    bridge: normalizeSection(raw?.bridge, raw?.chords?.bridge),
  };
}

function normalizeId(value) {
  return String(value)
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9а-яё_-]+/gi, '-')
    .replace(/^-+|-+$/g, '')
    || `legacy-${Date.now()}`;
}

function normalizeVerses(verses, chordVerses) {
  if (!Array.isArray(verses)) return [];
  return verses.flatMap((verse, index) => {
    const section = normalizeSection(verse, Array.isArray(chordVerses) ? chordVerses[index] : undefined);
    return section ? [section] : [];
  });
}

function normalizeSection(section, chordRows) {
  const rows = Array.isArray(section?.rows) ? section.rows.map((row) => String(row)) : [];
  if (rows.length === 0) return undefined;

  return {
    rows,
    chords: rows.map((_, index) => normalizeChordRow(Array.isArray(chordRows) ? chordRows[index] : undefined)),
  };
}

function normalizeChordRow(row) {
  if (!row) return [];
  const items = Array.isArray(row?.items) ? row.items : Array.isArray(row) ? row : [];
  return items.map((item) => String(item).trim()).filter(Boolean);
}

function inferCategory(raw, categories) {
  const explicit = String(raw?.category || '').trim();
  if (explicit && categories.has(explicit)) return explicit;

  const text = [
    raw?.name,
    raw?.title,
    ...(Array.isArray(raw?.verses) ? raw.verses.flatMap((verse) => verse?.rows || []) : []),
    ...(Array.isArray(raw?.chorus?.rows) ? raw.chorus.rows : []),
    ...(Array.isArray(raw?.bridge?.rows) ? raw.bridge.rows : []),
  ]
    .join(' ')
    .toLowerCase();

  for (const [category, keywords] of CATEGORY_RULES) {
    if (categories.has(category) && keywords.some((keyword) => text.includes(keyword))) {
      return category;
    }
  }

  return categories.has(DEFAULT_CATEGORY) ? DEFAULT_CATEGORY : 'Общее';
}

function buildSeedSQL(songs, version) {
  const lines = [
    'SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;',
    'START TRANSACTION;',
    '',
    'INSERT INTO catalog_versions (version, published_at, is_current, notes)',
    `VALUES (${sql(version)}, UTC_TIMESTAMP(), 1, 'Legacy mobile app import seed')`,
    'ON DUPLICATE KEY UPDATE',
    '  published_at = VALUES(published_at),',
    '  is_current = VALUES(is_current),',
    '  notes = VALUES(notes);',
    '',
    `SET @catalog_version_id := (SELECT id FROM catalog_versions WHERE version = ${sql(version)} LIMIT 1);`,
    'UPDATE catalog_versions SET is_current = 0 WHERE id <> @catalog_version_id;',
    'DELETE FROM songs WHERE catalog_version_id = @catalog_version_id;',
    '',
  ];

  for (const song of songs) {
    lines.push(
      `INSERT INTO songs (id, catalog_version_id, number, title, category, default_key, status) VALUES (${sql(song.id)}, @catalog_version_id, ${Number(song.number)}, ${sql(song.title)}, ${sql(song.category)}, NULL, 'published');`,
    );

    let position = 1;
    for (const verse of song.verses) {
      appendSectionSQL(lines, song.id, 'verse', position, `Куплет ${position}`, verse);
      position += 1;
    }
    if (song.chorus) {
      appendSectionSQL(lines, song.id, 'chorus', position, 'Припев', song.chorus);
      position += 1;
    }
    if (song.bridge) {
      appendSectionSQL(lines, song.id, 'bridge', position, 'Мост', song.bridge);
    }
    lines.push('');
  }

  lines.push('COMMIT;', '');
  return lines.join('\n');
}

function appendSectionSQL(lines, songId, type, position, title, section) {
  lines.push(`INSERT INTO song_sections (song_id, section_type, position, title) VALUES (${sql(songId)}, ${sql(type)}, ${position}, ${sql(title)});`);
  lines.push('SET @section_id := LAST_INSERT_ID();');

  section.rows.forEach((row, rowIndex) => {
    lines.push(`INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, ${rowIndex + 1}, ${sql(row)});`);
    lines.push('SET @line_id := LAST_INSERT_ID();');
    const chords = section.chords[rowIndex] || [];
    chords.forEach((chord, chordIndex) => {
      lines.push(`INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, ${chordIndex + 1}, ${sql(chord)});`);
    });
  });
}

function sql(value) {
  return `'${String(value).replaceAll('\\', '\\\\').replaceAll("'", "''")}'`;
}

function buildVersion() {
  return new Date().toISOString().slice(0, 10).replaceAll('-', '.') + '.legacy';
}

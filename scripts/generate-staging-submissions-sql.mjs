#!/usr/bin/env node
import { readFile, writeFile } from 'node:fs/promises';

const DEFAULT_INPUT = 'seed/holychords/songs.from-photos.staging.json';
const DEFAULT_MARKER = 'photo-staging-2026-08-13';
const PLACEHOLDER_LYRICS = '[Текст песни нужно добавить вручную перед апрувом]';

const args = parseArgs(process.argv.slice(2));

if (args.help) {
  printHelp();
  process.exit(0);
}

const input = args.input || DEFAULT_INPUT;
const marker = args.marker || DEFAULT_MARKER;
const payload = JSON.parse(await readFile(input, 'utf8'));
const songs = normalizeSongs(payload);
const generatedSQL = buildSQL(songs, marker);

if (args.sqlOut) {
  await writeFile(args.sqlOut, generatedSQL, 'utf8');
} else {
  process.stdout.write(generatedSQL);
}

function parseArgs(items) {
  const parsed = {};
  for (let i = 0; i < items.length; i += 1) {
    const item = items[i];
    if (item === '--help' || item === '-h') parsed.help = true;
    else if (item === '--input') parsed.input = items[++i];
    else if (item === '--sql-out') parsed.sqlOut = items[++i];
    else if (item === '--marker') parsed.marker = items[++i];
    else throw new Error(`Unknown argument: ${item}`);
  }
  return parsed;
}

function printHelp() {
  console.log(`Usage:
  node scripts/generate-staging-submissions-sql.mjs --sql-out seed/holychords/submissions.generated.sql

Options:
  --input      Read staging manifest JSON. Defaults to ${DEFAULT_INPUT}
  --sql-out    Write MySQL SQL seed for pending song_submissions.
  --marker     Idempotency marker stored in note. Defaults to ${DEFAULT_MARKER}
`);
}

function normalizeSongs(payload) {
  if (!Array.isArray(payload?.songs)) {
    throw new Error('Staging payload must contain songs array.');
  }

  return payload.songs.map((song) => {
    const oldNumber = Number(song.oldNumber);
    const title = String(song.resolvedTitle || song.observedTitle || `Песня ${oldNumber} (название нужно добавить)`).trim();
    if (!Number.isInteger(oldNumber) || oldNumber <= 0) {
      throw new Error(`Invalid oldNumber: ${song.oldNumber}`);
    }
    return {
      oldNumber,
      title,
      category: String(song.category || 'Разное').trim() || 'Разное',
      defaultKey: nullableString(song.defaultKey),
      bpm: nullableNumber(song.bpm),
      beatsPerLine: nullableNumber(song.beatsPerLine),
      introBeats: nullableNumber(song.introBeats),
      lyrics: nullableString(song.lyrics) || PLACEHOLDER_LYRICS,
      chords: nullableString(song.chords),
      note: buildNote(song),
    };
  });
}

function nullableString(value) {
  if (typeof value !== 'string') return null;
  const trimmed = value.trim();
  return trimmed.length > 0 ? trimmed : null;
}

function nullableNumber(value) {
  if (value === null || value === undefined || value === '') return null;
  const parsed = Number(value);
  return Number.isFinite(parsed) ? Math.round(parsed) : null;
}

function buildNote(song) {
  const sources = [];
  if (song.holychordsUrl) sources.push(`HolyChords: ${song.holychordsUrl}`);
  if (song.kgMusicUrl) sources.push(`KG Music: ${song.kgMusicUrl}`);
  if (song.notionUrl) sources.push(`Notion: ${song.notionUrl}`);
  if (song.backingTrackUrl) sources.push(`Backing track: ${song.backingTrackUrl}`);
  if (song.originalPerformanceUrl) sources.push(`Original: ${song.originalPerformanceUrl}`);

  const parts = [
    `oldNumber=${song.oldNumber}`,
    `photo=${song.photoIndex ?? 'unknown'}`,
    song.notionPageId ? `notionPageId=${song.notionPageId}` : null,
    song.notionChordPageId ? `notionChordPageId=${song.notionChordPageId}` : null,
    `status=${song.status || 'pending'}`,
    `confidence=${song.confidence || 'unknown'}`,
    ...sources,
    song.lyrics ? null : 'Fill lyrics from an approved source before approval.',
    song.chords ? null : 'Fill chords from an approved source before approval.',
  ].filter(Boolean);

  return parts.join(' | ').slice(0, 1000);
}

function buildSQL(songs, marker) {
  const lines = [
    'SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;',
    'START TRANSACTION;',
    '',
  ];

  for (const song of songs) {
    const note = `[staging:${marker}] ${song.note}`;
    lines.push(
      'INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)',
      `SELECT ${sql(song.title)}, ${sql(song.category)}, ${sql(song.defaultKey)}, ${sql(song.lyrics)}, ${sql(song.chords)}, ${sql(song.bpm)}, ${sql(song.beatsPerLine)}, ${sql(song.introBeats)}, 'Seed import', NULL, ${sql(note)}, 'pending'`,
      'WHERE NOT EXISTS (',
      '  SELECT 1 FROM song_submissions',
      `  WHERE title = ${sql(song.title)}`,
      `    AND note LIKE ${sql(`[staging:${marker}] oldNumber=${song.oldNumber}%`)}`,
      '  LIMIT 1',
      ');',
      '',
    );
  }

  lines.push('COMMIT;', '');
  return lines.join('\n');
}

function sql(value) {
  if (value === null || value === undefined) return 'NULL';
  return `'${String(value).replace(/'/g, "''")}'`;
}

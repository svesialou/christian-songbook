#!/usr/bin/env node
import { readFile, writeFile } from 'node:fs/promises';

const DEFAULT_INPUT = 'seed/notion-youth-songbook/songs.staging.json';
const DEFAULT_OUTPUT = DEFAULT_INPUT;
const NOTION_LOAD_PAGE_CHUNK_URL = 'https://www.notion.so/api/v3/loadPageChunk';
const REQUEST_DELAY_MS = 1000;
const MAX_RETRIES = 10;
const TEXT_BLOCK_TYPES = new Set([
  'text',
  'header',
  'sub_header',
  'sub_sub_header',
  'bulleted_list',
  'numbered_list',
  'quote',
  'callout',
]);
const SECTION_BREAK_BLOCK_TYPES = new Set(['divider']);

const args = parseArgs(process.argv.slice(2));

if (args.help) {
  printHelp();
  process.exit(0);
}

const input = args.input || DEFAULT_INPUT;
const output = args.output || DEFAULT_OUTPUT;
const limit = args.limit ? Number(args.limit) : null;
const payload = JSON.parse(await readFile(input, 'utf8'));

if (!Array.isArray(payload?.songs)) {
  throw new Error('Staging payload must contain songs array.');
}

const songs = limit ? payload.songs.slice(0, limit) : payload.songs;
const nextPayload = {
  ...payload,
  songs: [...payload.songs],
};

for (let index = 0; index < songs.length; index += 1) {
  const song = songs[index];
  if (!song.notionPageId) {
    nextPayload.songs[index] = song;
    continue;
  }

  const page = await loadNotionPage(song.notionPageId);
  const root = getBlock(page.blocks, song.notionPageId);
  const lyricsLines = extractTextLines(page.blocks, root);
  const nestedPages = findNestedPages(page.blocks, root);
  const chordPage = selectChordPage(song, nestedPages);
  let chordsLines = [];
  let notionChordPageId = null;

  if (chordPage) {
    const nestedPage = await loadNotionPage(chordPage.id);
    const nestedRoot = getBlock(nestedPage.blocks, chordPage.id);
    const nestedLines = extractTextLines(nestedPage.blocks, nestedRoot);
    const nestedChordLines = extractChordTextLines(nestedLines);

    if (hasChordLines(nestedChordLines)) {
      chordsLines = nestedChordLines;
      notionChordPageId = chordPage.id;
    }
  }

  const nextSong = {
    ...song,
    lyrics: lyricsLines.length > 0 ? lyricsLines.join('\n') : song.lyrics,
    chords: chordsLines.length > 0 ? chordsLines.join('\n') : song.chords,
    status: buildStatus(lyricsLines, chordsLines, song.status),
    confidence: buildConfidence(lyricsLines, chordsLines, song.confidence),
    notionExtractedAt: new Date().toISOString(),
    contentLineCount: lyricsLines.length,
    chordLineCount: chordsLines.length,
  };

  if (notionChordPageId) {
    nextSong.notionChordPageId = notionChordPageId;
  }

  nextPayload.songs[index] = nextSong;

  if (!args.quiet) {
    process.stderr.write(
      `[${index + 1}/${songs.length}] ${song.resolvedTitle || song.observedTitle}: ` +
        `${lyricsLines.length} lyrics lines, ${chordsLines.length} chord lines\n`,
    );
  }

  nextPayload.generatedAt = new Date().toISOString();
  await writeFile(output, `${JSON.stringify(nextPayload, null, 2)}\n`, 'utf8');
}

nextPayload.generatedAt = new Date().toISOString();
await writeFile(output, `${JSON.stringify(nextPayload, null, 2)}\n`, 'utf8');

function parseArgs(items) {
  const parsed = {};
  for (let i = 0; i < items.length; i += 1) {
    const item = items[i];
    if (item === '--help' || item === '-h') parsed.help = true;
    else if (item === '--input') parsed.input = items[++i];
    else if (item === '--output') parsed.output = items[++i];
    else if (item === '--limit') parsed.limit = items[++i];
    else if (item === '--quiet') parsed.quiet = true;
    else throw new Error(`Unknown argument: ${item}`);
  }
  return parsed;
}

function printHelp() {
  console.log(`Usage:
  node scripts/extract-notion-songbook.mjs --output seed/notion-youth-songbook/songs.staging.json

Options:
  --input     Read existing Notion staging manifest. Defaults to ${DEFAULT_INPUT}
  --output    Write enriched staging manifest. Defaults to ${DEFAULT_OUTPUT}
  --limit     Extract only first N songs for smoke checks.
  --quiet     Do not print per-song progress.
`);
}

async function loadNotionPage(pageId) {
  for (let attempt = 0; attempt <= MAX_RETRIES; attempt += 1) {
    if (attempt > 0 || REQUEST_DELAY_MS > 0) {
      await sleep(REQUEST_DELAY_MS * (attempt + 1));
    }

    const response = await fetch(NOTION_LOAD_PAGE_CHUNK_URL, {
      method: 'POST',
      headers: {
        'content-type': 'application/json',
        'user-agent': 'Mozilla/5.0',
      },
      body: JSON.stringify({
        pageId,
        limit: 100,
        cursor: { stack: [] },
        chunkNumber: 0,
        verticalColumns: false,
      }),
    });

    if (response.ok) {
      const payload = await response.json();
      return {
        blocks: payload?.recordMap?.block || {},
      };
    }

    if (response.status !== 429 || attempt === MAX_RETRIES) {
      throw new Error(`Notion loadPageChunk failed for ${pageId}: ${response.status} ${response.statusText}`);
    }

    const retryAfter = Number(response.headers.get('retry-after'));
    const retryDelayMs = Number.isFinite(retryAfter)
      ? retryAfter * 1000
      : Math.min(60000, REQUEST_DELAY_MS * 2 ** (attempt + 1));
    await sleep(retryDelayMs);
  }

  throw new Error(`Notion loadPageChunk failed for ${pageId}: retry limit exceeded`);
}

function sleep(ms) {
  return new Promise((resolve) => {
    setTimeout(resolve, ms);
  });
}

function getBlock(blocks, id) {
  return unwrapRecord(blocks[id]);
}

function unwrapRecord(record) {
  let value = record?.value || record;
  while (value?.value && typeof value.value === 'object') {
    value = value.value;
  }
  return value && typeof value === 'object' ? value : {};
}

function extractTextLines(blocks, root) {
  const lines = [];
  for (const childId of root?.content || []) {
    const block = getBlock(blocks, childId);
    if (SECTION_BREAK_BLOCK_TYPES.has(block.type)) {
      lines.push('');
      continue;
    }
    if (!TEXT_BLOCK_TYPES.has(block.type)) continue;

    const line = getTitle(block);
    lines.push(line);
  }
  return trimEmptyEdges(lines);
}

function findNestedPages(blocks, root) {
  const pages = [];
  for (const childId of root?.content || []) {
    const block = getBlock(blocks, childId);
    if (block.type === 'page') {
      pages.push({ id: childId, title: getTitle(block) });
    }
  }
  return pages;
}

function selectChordPage(song, nestedPages) {
  if (nestedPages.length === 0) return null;

  const title = normalizeTitle(song.resolvedTitle || song.observedTitle || '');
  return (
    nestedPages.find((page) => {
      const pageTitle = normalizeTitle(page.title).replace(/\*+$/g, '').trim();
      return page.title.includes('*') && pageTitle === title;
    }) ||
    nestedPages.find((page) => page.title.includes('*')) ||
    nestedPages[0]
  );
}

function getTitle(block) {
  const title = block?.properties?.title || [];
  return title
    .map((part) => (Array.isArray(part) && typeof part[0] === 'string' ? part[0] : ''))
    .join('')
    .trim();
}

function trimEmptyEdges(lines) {
  let start = 0;
  let end = lines.length;

  while (start < end && !lines[start].trim()) start += 1;
  while (end > start && !lines[end - 1].trim()) end -= 1;

  return lines.slice(start, end);
}

function hasChordLines(lines) {
  return lines.some((line) => isChordLine(line));
}

function extractChordTextLines(lines) {
  return trimEmptyEdges(lines.filter((line) => isSectionHeading(line) || isChordLine(line)));
}

function isSectionHeading(line) {
  return /^(?:куплет|припев|бридж|мост|verse|chorus|bridge)(?:\\s+\\d+)?\\s*:?$/i.test(line.trim());
}

function isChordLine(line) {
  const normalized = line.replace(/[|()[\],.]/g, ' ').replace(/\s+/g, ' ').trim();
  if (!normalized) return false;

  const tokens = normalized.split(' ');
  if (tokens.length > 8) return false;
  return tokens.every((token) => /^[A-H](?:#|b)?(?:m|maj|min|sus|dim|aug|add)?\d*(?:\/[A-H](?:#|b)?)?$/.test(token));
}

function normalizeTitle(value) {
  return String(value)
    .replace(/[ёЁ]/g, (char) => (char === 'ё' ? 'е' : 'Е'))
    .replace(/\s+/g, ' ')
    .trim()
    .toLowerCase();
}

function buildStatus(lyricsLines, chordsLines, fallback) {
  if (lyricsLines.length > 0 && chordsLines.length > 0) return 'notion-lyrics-chords';
  if (lyricsLines.length > 0) return 'notion-lyrics';
  return fallback || 'title-only';
}

function buildConfidence(lyricsLines, chordsLines, fallback) {
  if (lyricsLines.length > 0 && chordsLines.length > 0) return 'notion-page-with-nested-chords';
  if (lyricsLines.length > 0) return 'notion-page-lyrics';
  return fallback || 'notion-title';
}

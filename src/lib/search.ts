import type { Song } from '../types/song';

const SEARCH_SEPARATOR_PATTERN = /[\p{P}\p{S}_]+/gu;
const SEARCH_SEPARATOR_CHAR_PATTERN = /[\p{P}\p{S}_]/u;
const WHITESPACE_PATTERN = /\s+/g;
const WHITESPACE_CHAR_PATTERN = /\s/u;
const SECTION_HEADING_PATTERN = /^\s*\[[^\]]+\]\s*$/;
const CHORD_LINE_TOKEN_PATTERN = /^(?:[A-Ha-h][#b]?(?:m|maj|min|sus|dim|aug|add|\d)*(?:\/[A-Ha-h][#b]?)?|[|,;()[\]{}.-]+)$/;

export type SearchTextSegment = {
  text: string;
  isMatch: boolean;
};

type SearchMatchRange = {
  start: number;
  end: number;
};

type NormalizedSearchIndex = {
  text: string;
  originalStartByNormalizedIndex: number[];
  originalEndByNormalizedIndex: number[];
};

export const normalizeSearchText = (value: string): string =>
  value
    .normalize('NFKC')
    .toLocaleLowerCase('ru-RU')
    .replace(SEARCH_SEPARATOR_PATTERN, ' ')
    .replace(WHITESPACE_PATTERN, ' ')
    .trim();

const buildNormalizedSearchIndex = (value: string): NormalizedSearchIndex => {
  let text = '';
  const originalStartByNormalizedIndex: number[] = [];
  const originalEndByNormalizedIndex: number[] = [];
  let pendingSeparator: SearchMatchRange | null = null;
  let originalIndex = 0;

  for (const rawCharacter of value) {
    const characterStart = originalIndex;
    const characterEnd = characterStart + rawCharacter.length;
    const normalizedCharacter = rawCharacter.normalize('NFKC').toLocaleLowerCase('ru-RU');
    originalIndex = characterEnd;

    if (SEARCH_SEPARATOR_CHAR_PATTERN.test(normalizedCharacter) || WHITESPACE_CHAR_PATTERN.test(normalizedCharacter)) {
      if (text.length > 0) {
        pendingSeparator = pendingSeparator
          ? { start: pendingSeparator.start, end: characterEnd }
          : { start: characterStart, end: characterEnd };
      }
      continue;
    }

    if (pendingSeparator) {
      text += ' ';
      originalStartByNormalizedIndex.push(pendingSeparator.start);
      originalEndByNormalizedIndex.push(pendingSeparator.end);
      pendingSeparator = null;
    }

    for (const normalizedPart of normalizedCharacter) {
      text += normalizedPart;
      originalStartByNormalizedIndex.push(characterStart);
      originalEndByNormalizedIndex.push(characterEnd);
    }
  }

  return { text, originalStartByNormalizedIndex, originalEndByNormalizedIndex };
};

const findSearchMatchRanges = (value: string, query: string): SearchMatchRange[] => {
  const normalizedQuery = normalizeSearchText(query);
  if (!normalizedQuery || !value) return [];

  const normalizedIndex = buildNormalizedSearchIndex(value);
  const ranges: SearchMatchRange[] = [];
  let offset = 0;

  while (offset < normalizedIndex.text.length) {
    const normalizedStart = normalizedIndex.text.indexOf(normalizedQuery, offset);
    if (normalizedStart < 0) break;

    const normalizedEnd = normalizedStart + normalizedQuery.length;
    const start = normalizedIndex.originalStartByNormalizedIndex[normalizedStart];
    const end = normalizedIndex.originalEndByNormalizedIndex[normalizedEnd - 1];
    if (start !== undefined && end !== undefined && end > start) {
      ranges.push({ start, end });
    }
    offset = normalizedEnd;
  }

  return ranges;
};

export const matchesSearchQuery = (value: string, query: string): boolean => {
  const normalizedQuery = normalizeSearchText(query);
  if (!normalizedQuery) return true;

  return normalizeSearchText(value).includes(normalizedQuery);
};

const cleanLeadSheetPreview = (leadSheet: string): string =>
  leadSheet
    .split(/\r?\n/)
    .map((line) => line.trim())
    .filter((line) => line && !SECTION_HEADING_PATTERN.test(line) && !isLikelyChordLine(line))
    .join(' ');

const isLikelyChordLine = (line: string): boolean => {
  const tokens = line.split(/\s+/).filter(Boolean);
  return tokens.length > 0 && tokens.every((token) => CHORD_LINE_TOKEN_PATTERN.test(token));
};

export const buildSongTextSearchSource = (song: Song): string => {
  const sectionRows = song.sections?.flatMap((section) => section.rows) ?? [];
  const fallbackRows = [
    ...song.verses.flatMap((verse) => verse.rows),
    ...(song.chorus?.rows ?? []),
    ...(song.bridge?.rows ?? []),
  ];
  const rows = sectionRows.length > 0 ? sectionRows : fallbackRows;

  return rows.length > 0 ? rows.join(' ') : cleanLeadSheetPreview(song.leadSheet ?? '');
};

export const buildSongSearchIndex = (song: Song): string => [song.title, buildSongTextSearchSource(song)].join(' ');

export const songMatchesSearchQuery = (song: Song, query: string): boolean => {
  const normalizedQuery = normalizeSearchText(query);
  if (!normalizedQuery) return true;

  return matchesSearchQuery(song.title, normalizedQuery) || matchesSearchQuery(buildSongTextSearchSource(song), normalizedQuery);
};

export const buildSearchTextSegments = (value: string, query: string): SearchTextSegment[] => {
  const ranges = findSearchMatchRanges(value, query);
  if (ranges.length === 0 || !value) return [{ text: value, isMatch: false }];

  const selectedRanges = ranges
    .sort((a, b) => a.start - b.start || b.end - a.end)
    .reduce<{ start: number; end: number }[]>((acc, range) => {
      if (acc.some((item) => range.start < item.end && range.end > item.start)) return acc;
      return [...acc, range];
    }, [])
    .sort((a, b) => a.start - b.start);

  if (selectedRanges.length === 0) return [{ text: value, isMatch: false }];

  const segments: SearchTextSegment[] = [];
  let cursor = 0;
  for (const range of selectedRanges) {
    if (range.start > cursor) segments.push({ text: value.slice(cursor, range.start), isMatch: false });
    segments.push({ text: value.slice(range.start, range.end), isMatch: true });
    cursor = range.end;
  }
  if (cursor < value.length) segments.push({ text: value.slice(cursor), isMatch: false });

  return segments;
};

export const buildSearchSnippet = (value: string, query: string, radius = 64): string | null => {
  const normalizedQuery = normalizeSearchText(query);
  if (!normalizedQuery || !value.trim()) return null;

  const compactValue = value.replace(WHITESPACE_PATTERN, ' ').trim();
  const firstMatch = findSearchMatchRanges(compactValue, normalizedQuery)[0];
  if (!firstMatch) return null;

  const rawStart = Math.max(0, firstMatch.start - radius);
  const rawEnd = Math.min(compactValue.length, firstMatch.end + radius);
  const nextSpace = compactValue.indexOf(' ', rawStart);
  const previousSpace = compactValue.lastIndexOf(' ', rawEnd);
  const start = rawStart > 0 && nextSpace >= 0 && nextSpace < firstMatch.start ? nextSpace + 1 : rawStart;
  const end = rawEnd < compactValue.length && previousSpace > firstMatch.end ? previousSpace : rawEnd;
  const snippet = compactValue.slice(start, end).trim();

  return `${start > 0 ? '... ' : ''}${snippet}${end < compactValue.length ? ' ...' : ''}`;
};

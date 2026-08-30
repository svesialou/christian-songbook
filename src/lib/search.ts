import type { Song } from '../types/song';

const SEARCH_SEPARATOR_PATTERN = /[\p{P}\p{S}_]+/gu;
const WHITESPACE_PATTERN = /\s+/g;
const SECTION_HEADING_PATTERN = /^\s*\[[^\]]+\]\s*$/;
const CHORD_LINE_TOKEN_PATTERN = /^(?:[A-Ha-h][#b]?(?:m|maj|min|sus|dim|aug|add|\d)*(?:\/[A-Ha-h][#b]?)?|[|,;()[\]{}.-]+)$/;

export type SearchTextSegment = {
  text: string;
  isMatch: boolean;
};

export const normalizeSearchText = (value: string): string =>
  value
    .normalize('NFKC')
    .toLocaleLowerCase('ru-RU')
    .replace(SEARCH_SEPARATOR_PATTERN, ' ')
    .replace(WHITESPACE_PATTERN, ' ')
    .trim();

export const searchWords = (value: string): string[] => {
  const seen = new Set<string>();
  return normalizeSearchText(value)
    .split(' ')
    .flatMap((word) => {
      if (!word || seen.has(word)) return [];
      seen.add(word);
      return [word];
    });
};

export const matchesSearchQuery = (value: string, query: string): boolean => {
  const normalizedQuery = normalizeSearchText(query);
  if (!normalizedQuery) return true;

  const normalizedValue = normalizeSearchText(value);
  if (normalizedValue.includes(normalizedQuery)) return true;

  return searchWords(normalizedQuery).every((word) => normalizedValue.includes(word));
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

export const buildSearchTextSegments = (value: string, query: string): SearchTextSegment[] => {
  const words = searchWords(query).sort((a, b) => b.length - a.length);
  if (words.length === 0 || !value) return [{ text: value, isMatch: false }];

  const lowerValue = value.toLocaleLowerCase('ru-RU');
  const ranges = words.flatMap((word) => {
    const matches: { start: number; end: number }[] = [];
    let offset = 0;
    while (offset < lowerValue.length) {
      const start = lowerValue.indexOf(word, offset);
      if (start < 0) break;
      const end = start + word.length;
      matches.push({ start, end });
      offset = end;
    }
    return matches;
  });

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
  const words = searchWords(query);
  if (words.length === 0 || !value.trim()) return null;

  const compactValue = value.replace(WHITESPACE_PATTERN, ' ').trim();
  const lowerValue = compactValue.toLocaleLowerCase('ru-RU');
  const firstMatch = words
    .flatMap((word) => {
      const index = lowerValue.indexOf(word);
      return index >= 0 ? [{ index, length: word.length }] : [];
    })
    .sort((a, b) => a.index - b.index)[0];
  if (!firstMatch) return null;

  const rawStart = Math.max(0, firstMatch.index - radius);
  const rawEnd = Math.min(compactValue.length, firstMatch.index + firstMatch.length + radius);
  const nextSpace = compactValue.indexOf(' ', rawStart);
  const previousSpace = compactValue.lastIndexOf(' ', rawEnd);
  const start = rawStart > 0 && nextSpace >= 0 && nextSpace < firstMatch.index ? nextSpace + 1 : rawStart;
  const end = rawEnd < compactValue.length && previousSpace > firstMatch.index + firstMatch.length ? previousSpace : rawEnd;
  const snippet = compactValue.slice(start, end).trim();

  return `${start > 0 ? '... ' : ''}${snippet}${end < compactValue.length ? ' ...' : ''}`;
};

import type { Song } from '../types/song';

const SEARCH_SEPARATOR_PATTERN = /[\p{P}\p{S}_]+/gu;
const WHITESPACE_PATTERN = /\s+/g;

export const normalizeSearchText = (value: string): string =>
  value
    .normalize('NFKC')
    .toLocaleLowerCase('ru-RU')
    .replace(SEARCH_SEPARATOR_PATTERN, ' ')
    .replace(WHITESPACE_PATTERN, ' ')
    .trim();

const searchWords = (value: string): string[] => normalizeSearchText(value).split(' ').filter(Boolean);

export const matchesSearchQuery = (value: string, query: string): boolean => {
  const normalizedQuery = normalizeSearchText(query);
  if (!normalizedQuery) return true;

  const normalizedValue = normalizeSearchText(value);
  if (normalizedValue.includes(normalizedQuery)) return true;

  return searchWords(normalizedQuery).every((word) => normalizedValue.includes(word));
};

export const buildSongSearchIndex = (song: Song): string =>
  [
    song.title,
    song.category,
    ...(song.authors ?? []),
    String(song.number),
    ...(song.leadSheet ? [song.leadSheet] : []),
    ...(song.sections?.flatMap((section) => [...section.rows, ...section.chords.flat()]) ?? []),
    ...song.verses.flatMap((verse) => [...verse.rows, ...verse.chords.flat()]),
    ...(song.chorus ? [...song.chorus.rows, ...song.chorus.chords.flat()] : []),
    ...(song.bridge ? [...song.bridge.rows, ...song.bridge.chords.flat()] : []),
  ].join(' ');

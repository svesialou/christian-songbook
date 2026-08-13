import { Song, SongPlayback, SongSection } from '../types/song';

type CatalogSnapshotResponse = {
  version: string;
  publishedAt: string;
  songs: Song[];
};

export type CatalogSnapshot = {
  version: string;
  publishedAt: string;
  songs: Song[];
};

const API_TIMEOUT_MS = 3500;

const resolveApiBaseUrl = (): string => {
  const configured = import.meta.env.VITE_API_BASE_URL?.trim();
  if (configured) return configured.replace(/\/$/, '');

  if (typeof window === 'undefined') return '';
  const { hostname, port } = window.location;
  if ((hostname === 'localhost' || hostname === '127.0.0.1') && port === '5173') {
    return 'http://127.0.0.1:8082';
  }

  return '';
};

const apiUrl = (path: string): string => `${resolveApiBaseUrl()}${path}`;

const isStringList = (value: unknown): value is string[] =>
  Array.isArray(value) && value.every((item) => typeof item === 'string');

const isChordGrid = (value: unknown): value is string[][] =>
  Array.isArray(value) && value.every(isStringList);

const isSongSection = (value: unknown): value is SongSection => {
  const section = value as SongSection;
  return (
    !!section &&
    typeof section === 'object' &&
    isStringList(section.rows) &&
    isChordGrid(section.chords)
  );
};

const isOptionalSongSection = (value: unknown): value is SongSection | undefined =>
  value === undefined || isSongSection(value);

const isOptionalSongPlayback = (value: unknown): value is SongPlayback | undefined => {
  if (value === undefined) return true;
  const playback = value as SongPlayback;
  return (
    !!playback &&
    typeof playback === 'object' &&
    Number.isFinite(playback.bpm) &&
    Number.isFinite(playback.beatsPerLine) &&
    (playback.introBeats === undefined || Number.isFinite(playback.introBeats))
  );
};

const isSong = (value: unknown): value is Song => {
  const song = value as Song;
  return (
    !!song &&
    typeof song === 'object' &&
    typeof song.id === 'string' &&
    typeof song.number === 'number' &&
    typeof song.title === 'string' &&
    typeof song.category === 'string' &&
    Array.isArray(song.verses) &&
    song.verses.every(isSongSection) &&
    isOptionalSongPlayback(song.playback) &&
    isOptionalSongSection(song.chorus) &&
    isOptionalSongSection(song.bridge)
  );
};

export const fetchCatalogSnapshot = async (): Promise<CatalogSnapshot | null> => {
  const controller = new AbortController();
  const timeout = window.setTimeout(() => controller.abort(), API_TIMEOUT_MS);

  try {
    const response = await fetch(apiUrl('/api/catalog/snapshot'), {
      headers: { Accept: 'application/json' },
      cache: 'no-store',
      signal: controller.signal,
    });
    if (!response.ok) return null;

    const payload = (await response.json()) as CatalogSnapshotResponse;
    if (
      typeof payload.version !== 'string' ||
      typeof payload.publishedAt !== 'string' ||
      !Array.isArray(payload.songs) ||
      !payload.songs.every(isSong)
    ) {
      return null;
    }

    return {
      version: payload.version,
      publishedAt: payload.publishedAt,
      songs: payload.songs,
    };
  } catch {
    return null;
  } finally {
    window.clearTimeout(timeout);
  }
};

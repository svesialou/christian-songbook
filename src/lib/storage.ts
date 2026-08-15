import { openDB } from 'idb';
import { CatalogSnapshotMeta, Song, SongCollection, SongPlaybackPosition, SongSettings } from '../types/song';

const DB_NAME = 'christian-songbook';
const DB_VERSION = 1;
const STORE = 'state';

const DEFAULT_SETTINGS: SongSettings = {
  viewPreset: 'lead',
  showChords: true,
  repeatChorus: false,
  splitSections: false,
  transposition: 0,
  showPlaybackDock: false,
  fontScale: 'normal',
  darkTheme: false,
};

const SONGS_KEY = 'songs';
const SETTINGS_KEY = 'settings';
const RECENT_SONGS_KEY = 'recentSongs';
const COLLECTIONS_KEY = 'collections';
const LIVE_COLLECTIONS_KEY = 'liveCollections';
const LIVE_COLLECTION_KEY = 'liveCollectionId';
const LIVE_SONG_KEY = 'liveSongId';
const LIVE_SONG_IDS_KEY = 'liveSongIds';
const CATALOG_META_KEY = 'catalogMeta';
const PLAYBACK_POSITION_KEY = 'playbackPosition';
const LEGACY_FAVORITES_KEY = 'favorites';
const SONGS_FALLBACK = 'csb:songs';
const SETTINGS_FALLBACK = 'csb:settings';
const RECENT_SONGS_FALLBACK = 'csb:recentSongs';
const COLLECTIONS_FALLBACK = 'csb:collections';
const LIVE_COLLECTIONS_FALLBACK = 'csb:liveCollections';
const LIVE_COLLECTION_FALLBACK = 'csb:liveCollectionId';
const LIVE_SONG_FALLBACK = 'csb:liveSongId';
const LIVE_SONG_IDS_FALLBACK = 'csb:liveSongIds';
const PLAYBACK_POSITION_FALLBACK = 'csb:playbackPosition';
const LEGACY_FAVORITES_FALLBACK = 'csb:favorites';

const dbPromise = openDB(DB_NAME, DB_VERSION, {
  upgrade(db) {
    if (!db.objectStoreNames.contains(STORE)) {
      db.createObjectStore(STORE);
    }
  },
});

const withDb = async () => {
  if (typeof window === 'undefined' || !window.indexedDB) return null;
  try {
    return await dbPromise;
  } catch {
    return null;
  }
};

const fallbackRead = <T>(key: string, fallback: T): T => {
  if (typeof localStorage === 'undefined') return fallback;
  try {
    const raw = localStorage.getItem(key);
    if (!raw) return fallback;
    return JSON.parse(raw) as T;
  } catch {
    return fallback;
  }
};

const fallbackWrite = <T>(key: string, value: T): void => {
  if (typeof localStorage === 'undefined') return;
  try {
    localStorage.setItem(key, JSON.stringify(value));
  } catch {
    // no-op
  }
};

const isViewPreset = (value: unknown): value is SongSettings['viewPreset'] =>
  value === 'lead' || value === 'singer' || value === 'chords';

const normalizeSettings = (settings: unknown): SongSettings => {
  if (!settings || typeof settings !== 'object') return { ...DEFAULT_SETTINGS };
  const raw = settings as Partial<SongSettings>;

  return {
    viewPreset: isViewPreset(raw.viewPreset) ? raw.viewPreset : DEFAULT_SETTINGS.viewPreset,
    showChords: typeof raw.showChords === 'boolean' ? raw.showChords : DEFAULT_SETTINGS.showChords,
    repeatChorus: typeof raw.repeatChorus === 'boolean' ? raw.repeatChorus : DEFAULT_SETTINGS.repeatChorus,
    splitSections: typeof raw.splitSections === 'boolean' ? raw.splitSections : DEFAULT_SETTINGS.splitSections,
    transposition: Number.isFinite(raw.transposition) ? Number(raw.transposition) : DEFAULT_SETTINGS.transposition,
    showPlaybackDock:
      typeof raw.showPlaybackDock === 'boolean' ? raw.showPlaybackDock : DEFAULT_SETTINGS.showPlaybackDock,
    fontScale: raw.fontScale === 'large' || raw.fontScale === 'normal' ? raw.fontScale : DEFAULT_SETTINGS.fontScale,
    darkTheme: typeof raw.darkTheme === 'boolean' ? raw.darkTheme : DEFAULT_SETTINGS.darkTheme,
  };
};

const normalizeCollections = (collections: unknown): SongCollection[] => {
  if (!Array.isArray(collections)) return [];

  return collections.flatMap((item) => {
    if (!item || typeof item !== 'object') return [];
    const raw = item as Partial<SongCollection>;
    const id = typeof raw.id === 'string' && raw.id.trim().length > 0 ? raw.id : '';
    const name = typeof raw.name === 'string' && raw.name.trim().length > 0 ? raw.name.trim() : '';
    if (!id || !name) return [];

    const createdAt =
      typeof raw.createdAt === 'string' && raw.createdAt.trim().length > 0
        ? raw.createdAt
        : new Date().toISOString();
    const updatedAt =
      typeof raw.updatedAt === 'string' && raw.updatedAt.trim().length > 0 ? raw.updatedAt : createdAt;

    return [
      {
        id,
        name,
        songIds: Array.isArray(raw.songIds)
          ? raw.songIds.filter((songId): songId is string => typeof songId === 'string')
          : [],
        createdAt,
        updatedAt,
      },
    ];
  });
};

const normalizePlaybackPosition = (position: unknown): SongPlaybackPosition | null => {
  if (!position || typeof position !== 'object') return null;
  const raw = position as Partial<SongPlaybackPosition>;
  const songId = typeof raw.songId === 'string' && raw.songId.trim().length > 0 ? raw.songId : '';
  const sectionId = typeof raw.sectionId === 'string' && raw.sectionId.trim().length > 0 ? raw.sectionId : '';
  const sectionTitle =
    typeof raw.sectionTitle === 'string' && raw.sectionTitle.trim().length > 0 ? raw.sectionTitle : '';
  const lineIndex = Number.isInteger(raw.lineIndex) && Number(raw.lineIndex) >= 0 ? Number(raw.lineIndex) : -1;
  const updatedAt =
    typeof raw.updatedAt === 'string' && raw.updatedAt.trim().length > 0 ? raw.updatedAt : new Date().toISOString();

  if (!songId || !sectionId || !sectionTitle || lineIndex < 0) return null;

  return {
    songId,
    sectionId,
    sectionTitle,
    lineIndex,
    updatedAt,
  };
};

const normalizeSongIds = (songIds: unknown): string[] => {
  if (!Array.isArray(songIds)) return [];

  return songIds.filter(
    (songId, index, items): songId is string =>
      typeof songId === 'string' && songId.trim().length > 0 && items.indexOf(songId) === index,
  );
};

const readFromStore = async <T>(key: string, fallback: T): Promise<T> => {
  const db = await withDb();
  if (!db) {
    return fallbackRead<T>(key, fallback);
  }

  try {
    const result = await db.get(STORE, key);
    return (result as T) ?? fallback;
  } catch {
    return fallbackRead<T>(key, fallback);
  }
};

const writeToStore = async <T>(key: string, value: T): Promise<void> => {
  const db = await withDb();
  if (!db) {
    fallbackWrite(key, value);
    return;
  }

  try {
    await db.put(STORE, value, key);
  } catch {
    fallbackWrite(key, value);
  }
};

const deleteFromStore = async (key: string): Promise<void> => {
  const db = await withDb();
  if (!db) {
    if (typeof localStorage !== 'undefined') {
      localStorage.removeItem(key);
    }
    return;
  }

  try {
    await db.delete(STORE, key);
  } catch {
    // no-op
  }
};

export const loadSongs = async (): Promise<Song[]> =>
  readFromStore<Song[]>(SONGS_KEY, []);

export const saveSongs = (songs: Song[]): Promise<void> => writeToStore(SONGS_KEY, songs);

export const loadSettings = async (): Promise<SongSettings> =>
  normalizeSettings(await readFromStore<unknown>(SETTINGS_KEY, DEFAULT_SETTINGS));

export const saveSettings = (settings: SongSettings): Promise<void> => writeToStore(SETTINGS_KEY, settings);

export const loadRecentSongs = async (): Promise<string[]> =>
  readFromStore<string[]>(RECENT_SONGS_KEY, []);

export const saveRecentSongs = (songIds: string[]): Promise<void> =>
  writeToStore(RECENT_SONGS_KEY, songIds);

export const loadCollections = async (): Promise<SongCollection[]> =>
  normalizeCollections(await readFromStore<unknown>(COLLECTIONS_KEY, []));

export const saveCollections = (collections: SongCollection[]): Promise<void> =>
  writeToStore(COLLECTIONS_KEY, collections);

export const loadLiveCollections = async (): Promise<SongCollection[]> =>
  normalizeCollections(await readFromStore<unknown>(LIVE_COLLECTIONS_KEY, []));

export const saveLiveCollections = (collections: SongCollection[]): Promise<void> =>
  writeToStore(LIVE_COLLECTIONS_KEY, collections);

export const loadLiveCollectionId = async (): Promise<string | null> =>
  readFromStore<string | null>(LIVE_COLLECTION_KEY, null);

export const saveLiveCollectionId = (collectionId: string | null): Promise<void> =>
  writeToStore(LIVE_COLLECTION_KEY, collectionId);

export const loadLiveSongId = async (): Promise<string | null> =>
  readFromStore<string | null>(LIVE_SONG_KEY, null);

export const saveLiveSongId = (songId: string | null): Promise<void> =>
  writeToStore(LIVE_SONG_KEY, songId);

export const loadLiveSongIds = async (): Promise<string[]> =>
  normalizeSongIds(await readFromStore<unknown>(LIVE_SONG_IDS_KEY, []));

export const saveLiveSongIds = (songIds: string[]): Promise<void> =>
  writeToStore(LIVE_SONG_IDS_KEY, songIds);

export const loadCatalogMeta = async (): Promise<CatalogSnapshotMeta | null> =>
  readFromStore<CatalogSnapshotMeta | null>(CATALOG_META_KEY, null);

export const saveCatalogMeta = (meta: CatalogSnapshotMeta): Promise<void> =>
  writeToStore(CATALOG_META_KEY, meta);

export const loadPlaybackPosition = async (): Promise<SongPlaybackPosition | null> =>
  normalizePlaybackPosition(await readFromStore<unknown>(PLAYBACK_POSITION_KEY, null));

export const savePlaybackPosition = (position: SongPlaybackPosition | null): Promise<void> =>
  writeToStore(PLAYBACK_POSITION_KEY, position);

export const defaultSettings = (): SongSettings => ({ ...DEFAULT_SETTINGS });

// backward/legacy helper for direct localStorage migration from very old sessions
export const hydrateLegacyState = async () => {
  if (typeof localStorage === 'undefined') return;
  const songs = fallbackRead<Song[] | null>(SONGS_FALLBACK, null);
  const settings = fallbackRead<SongSettings | null>(SETTINGS_FALLBACK, null);
  const recentSongs = fallbackRead<string[] | null>(RECENT_SONGS_FALLBACK, null);
  const collections = fallbackRead<SongCollection[] | null>(COLLECTIONS_FALLBACK, null);
  const liveCollections = fallbackRead<SongCollection[] | null>(LIVE_COLLECTIONS_FALLBACK, null);
  const liveCollectionId = fallbackRead<string | null>(LIVE_COLLECTION_FALLBACK, null);
  const liveSongId = fallbackRead<string | null>(LIVE_SONG_FALLBACK, null);
  const liveSongIds = fallbackRead<string[] | null>(LIVE_SONG_IDS_FALLBACK, null);
  const playbackPosition = fallbackRead<SongPlaybackPosition | null>(PLAYBACK_POSITION_FALLBACK, null);

  if (songs) await saveSongs(songs);
  if (settings) await saveSettings(settings);
  if (recentSongs) await saveRecentSongs(recentSongs);
  if (collections) await saveCollections(normalizeCollections(collections));
  if (liveCollections) await saveLiveCollections(normalizeCollections(liveCollections));
  if (liveCollectionId) await saveLiveCollectionId(liveCollectionId);
  if (liveSongId) await saveLiveSongId(liveSongId);
  if (liveSongIds) await saveLiveSongIds(normalizeSongIds(liveSongIds));
  if (playbackPosition) await savePlaybackPosition(normalizePlaybackPosition(playbackPosition));

  if (songs) localStorage.removeItem(SONGS_FALLBACK);
  if (settings) localStorage.removeItem(SETTINGS_FALLBACK);
  if (recentSongs) localStorage.removeItem(RECENT_SONGS_FALLBACK);
  if (collections) localStorage.removeItem(COLLECTIONS_FALLBACK);
  if (liveCollections) localStorage.removeItem(LIVE_COLLECTIONS_FALLBACK);
  if (liveCollectionId) localStorage.removeItem(LIVE_COLLECTION_FALLBACK);
  if (liveSongId) localStorage.removeItem(LIVE_SONG_FALLBACK);
  if (liveSongIds) localStorage.removeItem(LIVE_SONG_IDS_FALLBACK);
  if (playbackPosition) localStorage.removeItem(PLAYBACK_POSITION_FALLBACK);
  localStorage.removeItem(LEGACY_FAVORITES_FALLBACK);
  await deleteFromStore(LEGACY_FAVORITES_KEY);
};

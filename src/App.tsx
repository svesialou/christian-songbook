import { FormEvent, useEffect, useMemo, useRef, useState } from 'react';
import { CatalogSnapshotMeta, Song, SongCollection, SongOrderedSection, SongPlayback, SongPlaybackPosition, SongSettings } from './types/song';
import {
  defaultSettings,
  hydrateLegacyState,
  loadCatalogMeta,
  loadCollections,
  loadLiveCollections,
  loadLiveCollectionId,
  loadLiveSongId,
  loadLiveSongIds,
  loadRecentSongs,
  loadPlaybackPosition,
  loadSettings,
  loadSongs,
  saveCatalogMeta,
  saveCollections,
  saveLiveCollections,
  saveLiveCollectionId,
  saveLiveSongId,
  saveLiveSongIds,
  saveRecentSongs,
  savePlaybackPosition,
  saveSettings,
  saveSongs,
} from './lib/storage';
import { bundledCatalog } from './data/bundledCatalog.generated';
import { songCategories } from './data/songCategories';
import {
  AdminSongUpdatePayload,
  CurrentUserState,
  SongSubmission,
  SongSubmissionPayload,
  UserPreferences,
  approveSongSubmission,
  deleteAdminSong,
  fetchCatalogSnapshot,
  fetchCurrentUser,
  fetchPendingSongSubmissions,
  fetchSharedCollection,
  fetchUserCollections,
  fetchUserLiveState,
  googleAuthStartUrl,
  importSharedCollection,
  logoutCurrentUser,
  rejectSongSubmission,
  saveUserCollections,
  saveUserLiveState,
  saveUserPreferences,
  submitSongEditSubmission,
  updateAdminSong,
  updateSongSubmission,
  UserCollectionsState,
  UserLiveState,
} from './lib/catalogApi';
import AdminPanel, { AdminRoute } from './components/AdminPanel';
import SongList from './components/SongList';
import SongSubmissionSheet from './components/SongSubmissionSheet';
import SongView from './components/SongView';
import SettingsPanel from './components/SettingsPanel';

type SongListMode = 'all' | 'recent' | 'collection' | 'live';
type CatalogSource = 'bundled' | 'local' | 'mysql';
type SyncState = 'idle' | 'syncing' | 'success' | 'failed';
type StatusTone = 'fresh' | 'syncing' | 'stale' | 'offline';
type CollectionSheetState = { kind: 'create'; songId?: string } | { kind: 'pick'; songId: string } | null;
type BeforeInstallPromptEvent = Event & {
  prompt: () => Promise<void>;
  userChoice: Promise<{ outcome: 'accepted' | 'dismissed'; platform: string }>;
};

const PULL_REFRESH_THRESHOLD = 72;
const PULL_REFRESH_MAX = 104;
const RECENT_LIMIT = 8;
const DEFAULT_CATEGORY = 'Общее';
const LIVE_PREVIEW_COLLECTION: SongCollection = {
  id: 'collection-live-preview',
  name: 'Live команда',
  songIds: ['a-ty-ne-dumai', 'agnecz-pashalnyi'],
  createdAt: '2026-08-13T00:00:00.000Z',
  updatedAt: '2026-08-13T00:00:00.000Z',
};
const LIVE_PREVIEW_FIRST_SONG_ID = LIVE_PREVIEW_COLLECTION.songIds[0] ?? null;
const MIN_BPM = 40;
const MAX_BPM = 220;
const MIN_BEATS_PER_LINE = 1;
const MAX_BEATS_PER_LINE = 16;
const MAX_INTRO_BEATS = 64;
const DEFAULT_ADMIN_API_KEY = '123456';
const LIVE_LOGIN_MESSAGE = 'Live-сборники доступны после входа. Так они будут привязаны к аккаунту и откроются на другом телефоне.';
const COLLECTION_LOGIN_MESSAGE = 'Сборники доступны после входа. Это нужно для привязки к аккаунту и доступа на другом телефоне.';
const KNOWN_SECTION_TYPES: SongOrderedSection['sectionType'][] = [
  'intro',
  'verse',
  'prechorus',
  'chorus',
  'bridge',
  'instrumental',
  'outro',
  'tag',
];

const shouldPrefillDefaultAdminKey = (): boolean => {
  if (typeof window === 'undefined') return false;
  return window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1';
};

const readSearchParam = (key: string) => {
  if (typeof window === 'undefined') return null;
  return new URLSearchParams(window.location.search).get(key);
};

const readSongRouteParam = () => {
  if (typeof window === 'undefined') return null;
  const match = window.location.pathname.match(/^\/song\/([^/]+)\/?$/);
  return match ? decodeURIComponent(match[1]) : null;
};

const readCollectionShareRouteParam = () => {
  if (typeof window === 'undefined') return null;
  const match = window.location.pathname.match(/^\/collection\/([^/]+)\/?$/);
  return match ? decodeURIComponent(match[1]) : null;
};

const isAdminRoute = () => {
  if (typeof window === 'undefined') return false;
  const pathname = window.location.pathname.replace(/\/+$/, '') || '/';
  return pathname === '/admin' || pathname.startsWith('/admin/');
};

const normalizeUserLiveStateForCatalog = (state: UserLiveState, catalogSongs: Song[]): UserLiveState => {
  const catalogSongIds = new Set(catalogSongs.map((song) => song.id));
  const collections = (state.collections ?? []).map((collection) => ({
    ...collection,
    songIds: collection.songIds.filter((songId) => catalogSongIds.has(songId)),
  }));
  const songIds = (state.songIds ?? []).filter((songId) => catalogSongIds.has(songId));
  const collectionId =
    state.collectionId && collections.some((collection) => collection.id === state.collectionId)
      ? state.collectionId
      : undefined;
  const songId = state.songId && songIds.includes(state.songId) ? state.songId : songIds[0] ?? undefined;

  return {
    collections,
    collectionId,
    songId,
    songIds,
  };
};

const liveStateSnapshot = (state: UserLiveState): string => JSON.stringify(state);

const normalizeCollectionsForCatalog = (items: SongCollection[], catalogSongs: Song[]): SongCollection[] => {
  const catalogSongIds = new Set(catalogSongs.map((song) => song.id));

  return items.map((collection) => ({
    ...collection,
    songIds: collection.songIds.filter((songId) => catalogSongIds.has(songId)),
  }));
};

const ownedCollections = (items: SongCollection[]): SongCollection[] =>
  items.filter((collection) => collection.isOwner !== false);

const collectionsSnapshot = (items: SongCollection[]): string => JSON.stringify(items);

const areSongIdListsEqual = (left: string[], right: string[]): boolean =>
  left.length === right.length && left.every((songId, index) => songId === right[index]);

const readAdminRoute = (): AdminRoute => {
  if (typeof window === 'undefined') return { page: 'home' };
  const pathname = window.location.pathname.replace(/\/+$/, '') || '/admin';
  const segments = pathname.replace(/^\/admin\/?/, '').split('/').filter(Boolean);
  if (segments.length === 0) return { page: 'home' };
  if (segments[0] === 'songs' && segments[1]) return { page: 'song', songId: decodeURIComponent(segments[1]) };
  if (segments[0] === 'songs') return { page: 'songs' };
  if (segments[0] === 'new') return { page: 'new' };
  if (segments[0] === 'submissions' && segments[1]) {
    const submissionId = Number(segments[1]);
    return Number.isFinite(submissionId) ? { page: 'submission', submissionId } : { page: 'submissions' };
  }
  if (segments[0] === 'submissions') return { page: 'submissions' };
  return { page: 'home' };
};

const adminRoutePath = (route: AdminRoute) => {
  if (route.page === 'songs') return '/admin/songs';
  if (route.page === 'song') return `/admin/songs/${encodeURIComponent(route.songId)}`;
  if (route.page === 'new') return '/admin/new';
  if (route.page === 'submissions') return '/admin/submissions';
  if (route.page === 'submission') return `/admin/submissions/${route.submissionId}`;
  return '/admin';
};

const updateSongQuery = (songId: string | null) => {
  if (typeof window === 'undefined') return;

  const url = new URL(window.location.href);
  if (songId) {
    url.pathname = `/song/${encodeURIComponent(songId)}`;
    url.searchParams.delete('song');
    url.searchParams.delete('menu');
  } else {
    url.searchParams.delete('song');
    if (url.pathname.match(/^\/song\/[^/]+\/?$/)) {
      url.pathname = '/';
    }
  }

  window.history.replaceState(null, '', `${url.pathname}${url.search}${url.hash}`);
};

const buildExport = (songs: Song[], settings: SongSettings, collections: SongCollection[]) => {
  const payload = {
    version: 1,
    exportedAt: new Date().toISOString(),
    songs,
    settings,
    collections,
  };
  const blob = new Blob([JSON.stringify(payload, null, 2)], { type: 'application/json;charset=utf-8' });
  const url = URL.createObjectURL(blob);
  const link = document.createElement('a');
  link.href = url;
  link.download = `songbook-export-${new Date().toISOString().slice(0, 10)}.json`;
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);
  URL.revokeObjectURL(url);
};

const getShareOrigin = () => {
  if (typeof window === 'undefined') return '';
  return window.location.origin;
};

const buildSongShareText = (song: Song) => {
  const origin = getShareOrigin();
  const link = origin ? `${origin}/song/${encodeURIComponent(song.id)}` : '';
  return [`Песня №${song.number}: ${song.title}`, normalizeCategory(song.category), link].filter(Boolean).join('\n');
};

const buildCollectionShareText = (title: string, songIds: string[], songs: Song[]) => {
  const songMap = new Map(songs.map((song) => [song.id, song]));
  const rows = songIds.flatMap((songId, index) => {
    const song = songMap.get(songId);
    return song ? [`${index + 1}. №${song.number} ${song.title}`] : [];
  });

  return [title, rows.length > 0 ? rows.join('\n') : 'Песни не выбраны'].join('\n');
};

const normalizeImportedSettings = (settings: unknown): SongSettings | undefined => {
  if (!settings || typeof settings !== 'object') return undefined;
  const raw = settings as Record<string, unknown>;
  const defaults = defaultSettings();

    return {
      viewPreset:
        raw.viewPreset === 'lead' || raw.viewPreset === 'singer' || raw.viewPreset === 'chords'
          ? raw.viewPreset
          : defaults.viewPreset,
      showChords: typeof raw.showChords === 'boolean' ? raw.showChords : defaults.showChords,
      repeatChorus: typeof raw.repeatChorus === 'boolean' ? raw.repeatChorus : defaults.repeatChorus,
      splitSections: typeof raw.splitSections === 'boolean' ? raw.splitSections : defaults.splitSections,
      transposition: Number.isFinite(raw.transposition) ? Number(raw.transposition) : defaults.transposition,
      showPlaybackDock:
        typeof raw.showPlaybackDock === 'boolean' ? raw.showPlaybackDock : defaults.showPlaybackDock,
      fontScale: raw.fontScale === 'large' || raw.fontScale === 'normal' ? raw.fontScale : defaults.fontScale,
      darkTheme: typeof raw.darkTheme === 'boolean' ? raw.darkTheme : defaults.darkTheme,
    };
};

const normalizeImportedCollections = (collections: unknown, validSongIds: Set<string>): SongCollection[] | undefined => {
  if (!Array.isArray(collections)) return undefined;

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
          ? raw.songIds.filter((songId): songId is string => typeof songId === 'string' && validSongIds.has(songId))
          : [],
        createdAt,
        updatedAt,
      },
    ];
  });
};

const normalizeCategory = (value: unknown) =>
  typeof value === 'string' && value.trim().length > 0 ? value.trim() : DEFAULT_CATEGORY;

const normalizeSongPlayback = (value: unknown): SongPlayback | undefined => {
  if (!value || typeof value !== 'object') return undefined;
  const raw = value as Partial<SongPlayback>;
  const bpm = Number(raw.bpm);
  const beatsPerLine = Number(raw.beatsPerLine);
  const introBeats = raw.introBeats === undefined ? undefined : Number(raw.introBeats);

  if (
    !Number.isFinite(bpm) ||
    !Number.isFinite(beatsPerLine) ||
    (introBeats !== undefined && !Number.isFinite(introBeats)) ||
    bpm < MIN_BPM ||
    bpm > MAX_BPM ||
    beatsPerLine < MIN_BEATS_PER_LINE ||
    beatsPerLine > MAX_BEATS_PER_LINE ||
    (introBeats !== undefined && (introBeats < 0 || introBeats > MAX_INTRO_BEATS))
  ) {
    return undefined;
  }

  return {
    bpm: Math.round(bpm),
    beatsPerLine: Math.round(beatsPerLine),
    introBeats: introBeats === undefined ? undefined : Math.round(introBeats),
  };
};

const normalizeSongAuthors = (value: unknown): string[] => {
  if (!Array.isArray(value)) return [];
  const seen = new Set<string>();
  return value.flatMap((item) => {
    const author = typeof item === 'string' ? item.trim() : '';
    const key = author.toLowerCase();
    if (!author || seen.has(key)) return [];
    seen.add(key);
    return [author];
  });
};

const parseCatalogImport = (
  text: string,
): { songs: Song[]; settings?: SongSettings; collections?: SongCollection[] } => {
  const raw = JSON.parse(text);

  const list = (raw?.songs || raw) as unknown[];
  if (!Array.isArray(list)) {
    throw new Error('Формат импорта не распознан: нужен массив songs или объект с полем songs');
  }

  const normalized = list.map((item) => {
    const song = item as Record<string, unknown>;
    const id = typeof song.id === 'string' ? song.id : `song-${Math.random().toString(36).slice(2, 9)}`;
    const number = Number(song.number) || 0;
    const title = typeof song.title === 'string' && song.title.trim().length > 0 ? song.title.trim() : 'Без названия';

    if (!Array.isArray(song.verses)) {
      return null;
    }

    const verses = (song.verses as unknown[])
      .filter((v): v is { rows: string[]; chords: string[][] } => {
        const vv = v as Record<string, unknown>;
        return Array.isArray(vv.rows) && Array.isArray(vv.chords);
      })
      .map((verse) => ({
        rows: verse.rows.map((row) => String(row)),
        chords: verse.chords.map((line) => (Array.isArray(line) ? line.map(String) : [])),
      }));

    const normalizeSection = (section: unknown) => {
      if (!section || typeof section !== 'object') return undefined;
      const rawSection = section as Record<string, unknown>;
      if (!Array.isArray(rawSection.rows) || !Array.isArray(rawSection.chords)) return undefined;
      return {
        rows: rawSection.rows.map((row) => String(row)),
        chords: rawSection.chords.map((line) => (Array.isArray(line) ? line.map(String) : [])),
      };
    };

    const sections = Array.isArray(song.sections)
      ? song.sections
          .map((section): SongOrderedSection | undefined => {
            const normalizedSection = normalizeSection(section);
            const rawSection = section as Record<string, unknown>;
            if (!normalizedSection || typeof rawSection.title !== 'string') return undefined;
            const sectionType: SongOrderedSection['sectionType'] =
              typeof rawSection.sectionType === 'string' &&
              KNOWN_SECTION_TYPES.includes(rawSection.sectionType as SongOrderedSection['sectionType'])
                ? (rawSection.sectionType as SongOrderedSection['sectionType'])
                : 'verse';
            return { ...normalizedSection, sectionType, title: rawSection.title };
          })
          .filter((section): section is SongOrderedSection => Boolean(section))
      : undefined;

    if (verses.length === 0) return null;
    return {
      id,
      number,
      title,
      category: normalizeCategory(song.category),
      authors: normalizeSongAuthors(song.authors),
      defaultKey: typeof song.defaultKey === 'string' && song.defaultKey.trim().length > 0 ? song.defaultKey.trim() : undefined,
      leadSheet: typeof song.leadSheet === 'string' && song.leadSheet.trim().length > 0 ? song.leadSheet : undefined,
      sections,
      playback: normalizeSongPlayback(song.playback),
      verses,
      chorus: normalizeSection(song.chorus),
      bridge: normalizeSection(song.bridge),
    };
  });

  const prepared = normalized.flatMap((item) => (item ? [item] : []));

  if (prepared.length === 0) {
    throw new Error('Не найдено валидных песен в файле импорта.');
  }

  const importedIds = new Set(prepared.map((song) => song.id));

  return {
    songs: prepared.sort((a, b) => a.number - b.number),
    settings: normalizeImportedSettings(raw?.settings),
    collections: normalizeImportedCollections(raw?.collections, importedIds),
  };
};

const normalizeCatalog = (songs: Song[]) =>
  songs.map((song, index) => ({
    ...song,
    id: song.id || `song-${index + 1}`,
    number: song.number || index + 1,
    category: normalizeCategory(song.category),
    authors: normalizeSongAuthors(song.authors),
    defaultKey: typeof song.defaultKey === 'string' && song.defaultKey.trim().length > 0 ? song.defaultKey.trim() : undefined,
    playback: normalizeSongPlayback(song.playback),
    verses: song.verses ?? [],
  }));
const bundledSongs = normalizeCatalog(bundledCatalog);
const resolveRouteSongId = (songs: Song[], routeSongId: string | null) => {
  if (!routeSongId) return null;
  if (songs.some((song) => song.id === routeSongId)) return routeSongId;
  return null;
};
const isDemoCatalog = (songs: Song[]) => {
  const ids = new Set(songs.map((song) => song.id));
  return songs.length === 2 && ids.has('song-1') && ids.has('song-2');
};

const formatDateTime = (value: string | null | undefined) => {
  if (!value) return 'ещё не обновлялся';
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return 'ещё не обновлялся';
  return new Intl.DateTimeFormat('ru', {
    day: '2-digit',
    month: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
  }).format(date);
};

const SearchHint = ({ query, count }: { query: string; count: number }) => {
  if (!query) return null;
  return <p className="muted">Найдено: {count}</p>;
};

const statusTone = (isOnline: boolean, source: CatalogSource, state: SyncState): StatusTone => {
  if (!isOnline) return 'offline';
  if (state === 'syncing') return 'syncing';
  if (state === 'failed') return 'stale';
  if (state === 'success' || source === 'mysql' || source === 'local' || source === 'bundled') return 'fresh';
  return 'stale';
};

const statusLabel = (tone: StatusTone, source: CatalogSource, meta: CatalogSnapshotMeta | null) => {
  if (tone === 'fresh' && source === 'mysql') return `Online, каталог свежий${meta ? `, версия ${meta.version}` : ''}`;
  if (tone === 'fresh' && source === 'local') return 'Online, локальный сборник доступен';
  if (tone === 'fresh' && source === 'bundled') return 'Online, встроенный сборник доступен';
  if (tone === 'syncing') return 'Online, обновление каталога';
  if (tone === 'offline') return 'Offline, используется локальный каталог';
  if (source === 'bundled') return 'Online, встроенный сборник';
  return 'Online, локальный каталог';
};

function App() {
  const [isAdminMode] = useState(() => isAdminRoute() || readSearchParam('admin') === '1');
  const [isMenuPreview] = useState(() => readSearchParam('menu') === '1');
  const [isSplitPreview] = useState(() => readSearchParam('split') === '1');
  const [isCategoryPickerPreview] = useState(() => readSearchParam('categoryPicker') === '1');
  const [isPlaybackPreview] = useState(() => readSearchParam('position') === '1');
  const [isAutoPlaybackPreview] = useState(() => readSearchParam('auto') === '1');
  const [isLiveListPreview] = useState(() => readSearchParam('livePreview') === '1');
  const [isLiveModePreview] = useState(() => readSearchParam('liveMode') === '1');
  const [songs, setSongs] = useState<Song[]>(() => bundledSongs);
  const [recentSongIds, setRecentSongIds] = useState<string[]>([]);
  const [collections, setCollections] = useState<SongCollection[]>(() =>
    readSearchParam('livePreview') === '1' ? [LIVE_PREVIEW_COLLECTION] : [],
  );
  const [publicSharedCollection, setPublicSharedCollection] = useState<SongCollection | null>(null);
  const [liveCollections, setLiveCollections] = useState<SongCollection[]>(() =>
    readSearchParam('livePreview') === '1' ? [LIVE_PREVIEW_COLLECTION] : [],
  );
  const [liveCollectionId, setLiveCollectionId] = useState<string | null>(() =>
    readSearchParam('livePreview') === '1' ? LIVE_PREVIEW_COLLECTION.id : null,
  );
  const [liveSongId, setLiveSongId] = useState<string | null>(() =>
    readSearchParam('livePreview') === '1' && readSearchParam('liveMode') === '1' ? LIVE_PREVIEW_FIRST_SONG_ID : null,
  );
  const [liveSongIds, setLiveSongIds] = useState<string[]>(() =>
    readSearchParam('livePreview') === '1' && readSearchParam('liveMode') === '1' ? LIVE_PREVIEW_COLLECTION.songIds : [],
  );
  const [playbackPosition, setPlaybackPosition] = useState<SongPlaybackPosition | null>(null);
  const [settings, setSettings] = useState<SongSettings>(defaultSettings());
  const [songTranspositions, setSongTranspositions] = useState<Record<string, number>>({});
  const [query, setQuery] = useState('');
  const [activeCategory, setActiveCategory] = useState<string | null>(null);
  const [listMode, setListMode] = useState<SongListMode>(() =>
    readSearchParam('livePreview') === '1' && readSearchParam('liveMode') === '1'
      ? 'live'
      : readSearchParam('livePreview') === '1'
        ? 'collection'
        : 'all',
  );
  const [activeCollectionId, setActiveCollectionId] = useState<string | null>(() =>
    readSearchParam('livePreview') === '1' && readSearchParam('liveMode') !== '1'
      ? LIVE_PREVIEW_COLLECTION.id
      : null,
  );
  const [collectionSheet, setCollectionSheet] = useState<CollectionSheetState>(null);
  const [collectionName, setCollectionName] = useState('');
  const [activeSongId, setActiveSongId] = useState<string | null>(() => readSongRouteParam());
  const [error, setError] = useState<string | null>(null);
  const [notice, setNotice] = useState<string | null>(null);
  const [isOnline, setIsOnline] = useState(() => (typeof navigator === 'undefined' ? true : navigator.onLine));
  const [catalogSource, setCatalogSource] = useState<CatalogSource>('bundled');
  const [catalogMeta, setCatalogMeta] = useState<CatalogSnapshotMeta | null>(null);
  const [syncState, setSyncState] = useState<SyncState>('idle');
  const [account, setAccount] = useState<CurrentUserState | null>(null);
  const [isAccountLoading, setIsAccountLoading] = useState(false);
  const [isUserLiveStateReady, setIsUserLiveStateReady] = useState(false);
  const [isUserCollectionsReady, setIsUserCollectionsReady] = useState(false);
  const [installPrompt, setInstallPrompt] = useState<BeforeInstallPromptEvent | null>(null);
  const [isStandalone, setIsStandalone] = useState(() =>
    typeof window === 'undefined' ? false : window.matchMedia('(display-mode: standalone)').matches,
  );
  const pullStartY = useRef<number | null>(null);
  const listScrollYRef = useRef(0);
  const shouldRestoreListScrollRef = useRef(false);
  const appMenuRef = useRef<HTMLDetailsElement | null>(null);
  const adminStatusTapRef = useRef({ count: 0, lastAt: 0 });
  const lastLiveStateSnapshotRef = useRef('');
  const lastCollectionsSnapshotRef = useRef('');
  const sharedCollectionTokenRef = useRef(readCollectionShareRouteParam());
  const handledSharedCollectionTokenRef = useRef(false);
  const [isAppMenuOpen, setIsAppMenuOpen] = useState(isMenuPreview);
  const [pullDistance, setPullDistance] = useState(0);
  const [isSubmissionSheetOpen, setIsSubmissionSheetOpen] = useState(false);
  const [adminRoute, setAdminRoute] = useState<AdminRoute>(() => readAdminRoute());
  const [pendingSubmissions, setPendingSubmissions] = useState<SongSubmission[]>([]);
  const [isPendingSubmissionsLoading, setIsPendingSubmissionsLoading] = useState(false);
  const [savingSubmissionId, setSavingSubmissionId] = useState<number | null>(null);
  const [approvingSubmissionId, setApprovingSubmissionId] = useState<number | null>(null);
  const [rejectingSubmissionId, setRejectingSubmissionId] = useState<number | null>(null);
  const [savingAdminSongId, setSavingAdminSongId] = useState<string | null>(null);
  const [deletingAdminSongId, setDeletingAdminSongId] = useState<string | null>(null);
  const [adminApiKey, setAdminApiKey] = useState(() =>
    isAdminMode && shouldPrefillDefaultAdminKey() ? DEFAULT_ADMIN_API_KEY : '',
  );
  const [isAdminAuthenticated, setIsAdminAuthenticated] = useState(false);
  const [isAdminLoginLoading, setIsAdminLoginLoading] = useState(false);
  const [isCollectionAuthSheetOpen, setIsCollectionAuthSheetOpen] = useState(false);

  const loadCurrentUser = async () => {
    setIsAccountLoading(true);
    try {
      setAccount(await fetchCurrentUser());
    } catch {
      setAccount({ authenticated: false });
    } finally {
      setIsAccountLoading(false);
    }
  };

  const handleGoogleLogin = () => {
    if (typeof window === 'undefined') return;
    const redirectPath = `${window.location.pathname}${window.location.search}${window.location.hash}` || '/';
    window.location.assign(googleAuthStartUrl(redirectPath));
  };

  const openAccountBenefitsSheet = () => {
    setCollectionSheet(null);
    setNotice(null);
    setError(null);
    setIsCollectionAuthSheetOpen(true);
  };

  const handleLogout = async () => {
    setIsAccountLoading(true);
    try {
      await logoutCurrentUser();
      setAccount({ authenticated: false });
      setNotice('Вы вышли из аккаунта.');
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Не удалось выйти из аккаунта.');
    } finally {
      setIsAccountLoading(false);
    }
  };

  const handleSaveUserPreferences = async (preferences: UserPreferences) => {
    const savedPreferences = await saveUserPreferences(preferences);
    setAccount((current) =>
      current?.authenticated
        ? {
            ...current,
            preferences: savedPreferences,
          }
        : current,
    );
    setNotice('Персональные настройки сохранены.');
  };

  const navigateAdmin = (route: AdminRoute) => {
    setAdminRoute(route);
    setActiveSongId(null);
    if (typeof window !== 'undefined') {
      window.history.pushState(null, '', adminRoutePath(route));
    }
  };

  const applyCatalogSnapshot = async (snapshot: Awaited<ReturnType<typeof fetchCatalogSnapshot>>) => {
    if (!snapshot || snapshot.songs.length === 0) return false;

    const normalizedSongs = normalizeCatalog(snapshot.songs);
    if (isDemoCatalog(normalizedSongs)) return false;
    const nextMeta: CatalogSnapshotMeta = {
      version: snapshot.version,
      publishedAt: snapshot.publishedAt,
      syncedAt: new Date().toISOString(),
    };

    setSongs(normalizedSongs);
    setCatalogSource('mysql');
    setCatalogMeta(nextMeta);
    await Promise.all([saveSongs(normalizedSongs), saveCatalogMeta(nextMeta)]);
    return true;
  };

  const refreshCatalog = async (showNotice: boolean) => {
    if (typeof navigator !== 'undefined' && !navigator.onLine) {
      setSyncState('failed');
      if (showNotice) setError('Нет сети: используется локальный каталог.');
      return;
    }

    setSyncState('syncing');
    const snapshot = await fetchCatalogSnapshot();
    const applied = await applyCatalogSnapshot(snapshot);

    if (!applied) {
      setSyncState('failed');
      if (showNotice) setError('Backend недоступен или вернул некорректный каталог. Локальный каталог сохранён.');
      return;
    }

    setSyncState('success');
    setError(null);
    if (showNotice) setNotice(`Каталог обновлён: ${snapshot!.songs.length} песен`);
  };

  const loadPendingSubmissions = async () => {
    if (!isAdminMode || !isAdminAuthenticated) return;
    if (!adminApiKey.trim()) {
      setError('Введите admin key для загрузки заявок.');
      return;
    }

    setIsPendingSubmissionsLoading(true);
    try {
      const submissions = await fetchPendingSongSubmissions(adminApiKey);
      setPendingSubmissions(submissions);
      setError(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Не удалось загрузить заявки.');
    } finally {
      setIsPendingSubmissionsLoading(false);
    }
  };

  const handleApproveSubmission = async (submissionId: number) => {
    if (!isAdminAuthenticated) {
      setError('Нужно войти в админку.');
      return;
    }
    if (!adminApiKey.trim()) {
      setError('Введите admin key для апрува.');
      return;
    }

    setApprovingSubmissionId(submissionId);
    try {
      const result = await approveSongSubmission(submissionId, adminApiKey);
      setPendingSubmissions((current) => current.filter((submission) => submission.id !== submissionId));
      const snapshot = await fetchCatalogSnapshot();
      await applyCatalogSnapshot(snapshot);
      setNotice(`Песня добавлена в каталог: ${result.songId}`);
      setError(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Не удалось апрувить заявку.');
    } finally {
      setApprovingSubmissionId(null);
    }
  };

  const handleSaveSubmission = async (submissionId: number, payload: SongSubmissionPayload) => {
    if (!isAdminAuthenticated) {
      setError('Нужно войти в админку.');
      return;
    }
    if (!adminApiKey.trim()) {
      setError('Введите admin key для сохранения.');
      return;
    }

    setSavingSubmissionId(submissionId);
    try {
      await updateSongSubmission(submissionId, payload, adminApiKey);
      setPendingSubmissions((current) =>
        current.map((submission) => (submission.id === submissionId ? { ...submission, ...payload } : submission)),
      );
      setNotice(`Заявка #${submissionId} сохранена.`);
      setError(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Не удалось сохранить заявку.');
    } finally {
      setSavingSubmissionId(null);
    }
  };

  const handleRejectSubmission = async (submissionId: number) => {
    if (!isAdminAuthenticated) {
      setError('Нужно войти в админку.');
      return;
    }
    if (!adminApiKey.trim()) {
      setError('Введите admin key для отклонения.');
      return;
    }

    const reason = window.prompt('Причина отклонения заявки (опционально)', '') ?? '';
    setRejectingSubmissionId(submissionId);
    try {
      await rejectSongSubmission(submissionId, reason, adminApiKey);
      setPendingSubmissions((current) => current.filter((submission) => submission.id !== submissionId));
      setNotice(`Заявка #${submissionId} отклонена.`);
      setError(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Не удалось отклонить заявку.');
    } finally {
      setRejectingSubmissionId(null);
    }
  };

  const handleSaveAdminSong = async (songId: string, payload: AdminSongUpdatePayload) => {
    if (!isAdminAuthenticated) {
      setError('Нужно войти в админку.');
      return;
    }
    if (!adminApiKey.trim()) {
      setError('Введите admin key для сохранения.');
      return;
    }

    const normalizedPayload = {
      ...payload,
      title: payload.title.trim(),
      category: payload.category.trim() || DEFAULT_CATEGORY,
      authors: normalizeSongAuthors(payload.authors),
      defaultKey: payload.defaultKey.trim(),
    };

    setSavingAdminSongId(songId);
    try {
      const result = await updateAdminSong(songId, normalizedPayload, adminApiKey);
      setSongs((current) =>
        current.map((song) =>
          song.id === songId
            ? {
                ...song,
                title: normalizedPayload.title,
                category: normalizedPayload.category,
                authors: normalizedPayload.authors,
                defaultKey: normalizedPayload.defaultKey || undefined,
                leadSheet: normalizedPayload.leadSheet || undefined,
                sheetMusicUrl: normalizedPayload.sheetMusicUrl || undefined,
                playback: {
                  bpm: normalizedPayload.bpm,
                  beatsPerLine: normalizedPayload.beatsPerLine,
                  introBeats: normalizedPayload.introBeats,
                },
              }
            : song,
        ),
      );
      const snapshot = await fetchCatalogSnapshot();
      await applyCatalogSnapshot(snapshot);
      setNotice(`Песня сохранена: ${result.songId}`);
      setError(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Не удалось сохранить песню.');
    } finally {
      setSavingAdminSongId(null);
    }
  };

  const handleDeleteAdminSong = async (song: Song) => {
    if (!isAdminAuthenticated) {
      setError('Нужно войти в админку.');
      return;
    }
    if (!adminApiKey.trim()) {
      setError('Введите admin key для удаления.');
      return;
    }

    const confirmed = window.confirm(`Скрыть песню "${song.title}"? Она исчезнет из каталога, но останется в базе со статусом deleted.`);
    if (!confirmed) return;

    setDeletingAdminSongId(song.id);
    try {
      const result = await deleteAdminSong(song.id, adminApiKey);
      setSongs((current) => current.filter((item) => item.id !== song.id));
      const snapshot = await fetchCatalogSnapshot();
      await applyCatalogSnapshot(snapshot);
      setNotice(`Песня скрыта: ${result.songId}`);
      setError(null);
      navigateAdmin({ page: 'songs' });
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Не удалось скрыть песню.');
    } finally {
      setDeletingAdminSongId(null);
    }
  };

  const handleSubmitSongEdit = async (song: Song, payload: SongSubmissionPayload) => {
    await submitSongEditSubmission(song.id, payload);
    setNotice('Правка отправлена на проверку в админку.');
    setError(null);
  };

  const handleAdminLogin = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    const key = adminApiKey.trim();
    if (!key) {
      setError('Введите admin key.');
      return;
    }

    setIsAdminLoginLoading(true);
    setError(null);
    try {
      const submissions = await fetchPendingSongSubmissions(key);
      setPendingSubmissions(submissions);
      setIsAdminAuthenticated(true);
      setNotice(`Вход выполнен. Pending заявок: ${submissions.length}`);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Не удалось войти в админку.');
      setNotice(null);
    } finally {
      setIsAdminLoginLoading(false);
    }
  };

  const handleAdminLogout = () => {
    setAdminApiKey(DEFAULT_ADMIN_API_KEY);
    setPendingSubmissions([]);
    setIsAdminAuthenticated(false);
    setAdminRoute({ page: 'home' });
    if (typeof window !== 'undefined' && isAdminMode) {
      window.history.replaceState(null, '', '/admin');
    }
    setNotice(null);
    setError(null);
  };

  useEffect(() => {
    if (!isAdminMode) return undefined;
    const handlePopState = () => setAdminRoute(readAdminRoute());
    window.addEventListener('popstate', handlePopState);
    return () => window.removeEventListener('popstate', handlePopState);
  }, [isAdminMode]);

  useEffect(() => {
    if (!isAdminMode || !isAdminAuthenticated) return;
    if (adminRoute.page === 'submissions' || adminRoute.page === 'submission') {
      void loadPendingSubmissions();
    }
  }, [adminRoute.page, isAdminAuthenticated, isAdminMode]);

  useEffect(() => {
    let cancelled = false;

    const load = async () => {
      await hydrateLegacyState();
      const [
        loadedSongs,
        loadedRecentSongs,
        loadedCollections,
        loadedLiveCollections,
        loadedLiveCollectionId,
        loadedLiveSongId,
        loadedLiveSongIds,
        loadedPlaybackPosition,
        loadedSettings,
        loadedCatalogMeta,
      ] = await Promise.all([
        loadSongs(),
        loadRecentSongs(),
        loadCollections(),
        loadLiveCollections(),
        loadLiveCollectionId(),
        loadLiveSongId(),
        loadLiveSongIds(),
        loadPlaybackPosition(),
        loadSettings(),
        loadCatalogMeta(),
      ]);
      const loadedCatalog = normalizeCatalog(loadedSongs);
      const hasLocalCatalog = loadedCatalog.length > 0 && !isDemoCatalog(loadedCatalog);
      const baseCatalog = hasLocalCatalog ? loadedCatalog : bundledSongs;
      const baseCollections = isLiveListPreview ? [LIVE_PREVIEW_COLLECTION] : loadedCollections;
      const baseLiveCollections = isLiveListPreview ? [LIVE_PREVIEW_COLLECTION] : loadedLiveCollections;

      if (cancelled) return;
      setSongs(baseCatalog);
      setCatalogSource(hasLocalCatalog ? 'local' : 'bundled');
      setCatalogMeta(loadedCatalogMeta);
      if (!hasLocalCatalog) {
        void saveSongs(baseCatalog);
      }
      setRecentSongIds(loadedRecentSongs);
      setCollections(baseCollections);
      setLiveCollections(baseLiveCollections);
      setLiveCollectionId(
        isLiveListPreview
          ? LIVE_PREVIEW_COLLECTION.id
          : baseLiveCollections.some((collection) => collection.id === loadedLiveCollectionId)
            ? loadedLiveCollectionId
            : null,
      );
      setLiveSongId(
        isLiveListPreview
          ? isLiveModePreview
            ? LIVE_PREVIEW_FIRST_SONG_ID
            : null
          : baseCatalog.some((song) => song.id === loadedLiveSongId)
            ? loadedLiveSongId
            : null,
      );
      setLiveSongIds(isLiveListPreview ? (isLiveModePreview ? LIVE_PREVIEW_COLLECTION.songIds : []) : loadedLiveSongIds);
      if (isLiveListPreview) {
        setListMode(isLiveModePreview ? 'live' : 'collection');
        setActiveCollectionId(isLiveModePreview ? null : LIVE_PREVIEW_COLLECTION.id);
      }
      setPlaybackPosition(loadedPlaybackPosition);
      setSettings(loadedSettings);
      const resolvedActiveSongId = resolveRouteSongId(baseCatalog, activeSongId);
      if (activeSongId && resolvedActiveSongId && resolvedActiveSongId !== activeSongId) {
        setActiveSongId(resolvedActiveSongId);
        updateSongQuery(resolvedActiveSongId);
      } else if (activeSongId && !resolvedActiveSongId) {
        setActiveSongId(null);
        updateSongQuery(null);
      }

      if (typeof navigator !== 'undefined' && !navigator.onLine) return;

      setSyncState('syncing');
      const snapshot = await fetchCatalogSnapshot();
      if (cancelled) return;

      const applied = await applyCatalogSnapshot(snapshot);
      setSyncState(applied ? 'success' : 'idle');
    };

    load();

    return () => {
      cancelled = true;
    };
  }, [isAdminMode, isLiveListPreview, isLiveModePreview]);

  useEffect(() => {
    const updateOnlineStatus = () => setIsOnline(navigator.onLine);
    window.addEventListener('online', updateOnlineStatus);
    window.addEventListener('offline', updateOnlineStatus);

    return () => {
      window.removeEventListener('online', updateOnlineStatus);
      window.removeEventListener('offline', updateOnlineStatus);
    };
  }, []);

  useEffect(() => {
    const handleBeforeInstallPrompt = (event: Event) => {
      event.preventDefault();
      setInstallPrompt(event as BeforeInstallPromptEvent);
    };
    const handleInstalled = () => {
      setInstallPrompt(null);
      setIsStandalone(true);
    };

    window.addEventListener('beforeinstallprompt', handleBeforeInstallPrompt);
    window.addEventListener('appinstalled', handleInstalled);

    return () => {
      window.removeEventListener('beforeinstallprompt', handleBeforeInstallPrompt);
      window.removeEventListener('appinstalled', handleInstalled);
    };
  }, []);

  useEffect(() => {
    saveSettings(settings);
  }, [settings]);

  useEffect(() => {
    void loadCurrentUser();
  }, []);

  useEffect(() => {
    if (isLiveListPreview) return;
    if (!account) return;

    lastLiveStateSnapshotRef.current = '';

    if (!account.authenticated) {
      setIsUserLiveStateReady(false);
      setLiveCollections([]);
      setLiveCollectionId(null);
      setLiveSongId(null);
      setLiveSongIds([]);
      if (listMode === 'live') setListMode('all');
      return;
    }

    let cancelled = false;
    setIsUserLiveStateReady(false);

    const loadUserLiveState = async () => {
      try {
        const state = normalizeUserLiveStateForCatalog(await fetchUserLiveState(), songs);
        if (cancelled) return;
        setLiveCollections(state.collections);
        setLiveCollectionId(state.collectionId ?? null);
        setLiveSongIds(state.songIds);
        setLiveSongId(state.songId ?? null);
        lastLiveStateSnapshotRef.current = liveStateSnapshot(state);
        setIsUserLiveStateReady(true);
      } catch (err) {
        if (cancelled) return;
        setIsUserLiveStateReady(false);
        setError(err instanceof Error ? err.message : 'Не удалось загрузить live-сборники аккаунта.');
      }
    };

    void loadUserLiveState();

    return () => {
      cancelled = true;
    };
  }, [account?.authenticated, account?.user?.id, isLiveListPreview]);

  useEffect(() => {
    if (isLiveListPreview || !account?.authenticated || !isUserLiveStateReady) return;

    const state = normalizeUserLiveStateForCatalog(
      {
        collections: liveCollections,
        collectionId: liveCollectionId ?? undefined,
        songId: liveSongId ?? undefined,
        songIds: liveSongIds,
      },
      songs,
    );
    const snapshot = liveStateSnapshot(state);
    if (snapshot === lastLiveStateSnapshotRef.current) return;

    lastLiveStateSnapshotRef.current = snapshot;
    void saveUserLiveState(state).catch((err) => {
      lastLiveStateSnapshotRef.current = '';
      setError(err instanceof Error ? err.message : 'Не удалось сохранить live-сборники аккаунта.');
    });
  }, [account?.authenticated, isLiveListPreview, isUserLiveStateReady, liveCollectionId, liveCollections, liveSongId, liveSongIds, songs]);

  useEffect(() => {
    saveRecentSongs(recentSongIds);
  }, [recentSongIds]);

  useEffect(() => {
    if (isLiveListPreview || account?.authenticated) return;
    saveCollections(collections);
  }, [account?.authenticated, collections, isLiveListPreview]);

  useEffect(() => {
    if (isLiveListPreview) return;
    if (!account) return;

    lastCollectionsSnapshotRef.current = '';

    if (!account.authenticated) {
      setIsUserCollectionsReady(false);
      setCollections([]);
      setCollectionSheet(null);
      if (listMode === 'collection') {
        setListMode('all');
        setActiveCollectionId(null);
      }
      return;
    }

    let cancelled = false;
    setIsUserCollectionsReady(false);

    const loadUserCollections = async () => {
      try {
        const serverState = await fetchUserCollections();
        if (cancelled) return;

        const localCollections = normalizeCollectionsForCatalog(collections, songs);
        const state =
          serverState.collections.length === 0 && localCollections.length > 0
            ? await saveUserCollections(ownedCollections(localCollections))
            : serverState;
        if (cancelled) return;

        const normalizedCollections = normalizeCollectionsForCatalog(state.collections, songs);
        setCollections(normalizedCollections);
        lastCollectionsSnapshotRef.current = collectionsSnapshot(ownedCollections(normalizedCollections));
        setIsUserCollectionsReady(true);
      } catch (err) {
        if (cancelled) return;
        setIsUserCollectionsReady(false);
        setError(err instanceof Error ? err.message : 'Не удалось загрузить сборники аккаунта.');
      }
    };

    void loadUserCollections();

    return () => {
      cancelled = true;
    };
  }, [account?.authenticated, account?.user?.id, isLiveListPreview]);

  useEffect(() => {
    if (isLiveListPreview || !account?.authenticated || !isUserCollectionsReady) return;

    const normalizedCollections = normalizeCollectionsForCatalog(collections, songs);
    const editableCollections = ownedCollections(normalizedCollections);
    const snapshot = collectionsSnapshot(editableCollections);
    if (snapshot === lastCollectionsSnapshotRef.current) return;

    lastCollectionsSnapshotRef.current = snapshot;
    void saveUserCollections(editableCollections)
      .then((state) => {
        const savedCollections = normalizeCollectionsForCatalog(state.collections, songs);
        lastCollectionsSnapshotRef.current = collectionsSnapshot(ownedCollections(savedCollections));
        setCollections(savedCollections);
      })
      .catch((err) => {
        lastCollectionsSnapshotRef.current = '';
        setError(err instanceof Error ? err.message : 'Не удалось сохранить сборники аккаунта.');
      });
  }, [account?.authenticated, collections, isLiveListPreview, isUserCollectionsReady, songs]);

  useEffect(() => {
    if (isLiveListPreview || account?.authenticated) return;
    saveLiveCollections(liveCollections);
  }, [account?.authenticated, isLiveListPreview, liveCollections]);

  useEffect(() => {
    if (isLiveListPreview || account?.authenticated) return;
    saveLiveCollectionId(liveCollectionId);
  }, [account?.authenticated, liveCollectionId, isLiveListPreview]);

  useEffect(() => {
    if (isLiveListPreview || account?.authenticated) return;
    saveLiveSongId(liveSongId);
  }, [account?.authenticated, liveSongId, isLiveListPreview]);

  useEffect(() => {
    if (isLiveListPreview || account?.authenticated) return;
    saveLiveSongIds(liveSongIds);
  }, [account?.authenticated, liveSongIds, isLiveListPreview]);

  useEffect(() => {
    if (!account) return;
    if (account.authenticated) {
      setIsCollectionAuthSheetOpen(false);
      return;
    }

    setCollectionSheet(null);
    if (listMode === 'collection' && activeCollectionId !== publicSharedCollection?.id) {
      setListMode('all');
      setActiveCollectionId(null);
    }
  }, [account?.authenticated, activeCollectionId, listMode, publicSharedCollection?.id]);

  useEffect(() => {
    const shareToken = sharedCollectionTokenRef.current;
    if (!shareToken || handledSharedCollectionTokenRef.current || isAdminMode || isLiveListPreview) return;
    if (!account) return;

    if (!account.authenticated) {
      handledSharedCollectionTokenRef.current = true;
      void fetchSharedCollection(shareToken)
        .then((state: UserCollectionsState) => {
          const collection = state.collection ?? state.collections[0];
          if (!collection) {
            throw new Error('Сборник по ссылке не найден.');
          }

          const [normalizedCollection] = normalizeCollectionsForCatalog(
            [{ ...collection, isOwner: false }],
            songs,
          );
          setPublicSharedCollection(normalizedCollection);
          setActiveCollectionId(normalizedCollection.id);
          setListMode('collection');
          setCollectionSheet(null);
          setIsCollectionAuthSheetOpen(false);
          setNotice('Открыт сборник по ссылке. Войдите, чтобы подписаться и сохранить его в аккаунте.');
          setError(null);
        })
        .catch((err) => {
          handledSharedCollectionTokenRef.current = false;
          setError(err instanceof Error ? err.message : 'Не удалось открыть сборник по ссылке.');
        });
      return;
    }
    if (!isUserCollectionsReady) return;

    handledSharedCollectionTokenRef.current = true;
    setPublicSharedCollection(null);
    void importSharedCollection(shareToken)
      .then((state: UserCollectionsState) => {
        const normalizedCollections = normalizeCollectionsForCatalog(state.collections, songs);
        setCollections(normalizedCollections);
        lastCollectionsSnapshotRef.current = collectionsSnapshot(ownedCollections(normalizedCollections));
        if (state.collection?.id) {
          setActiveCollectionId(state.collection.id);
          setListMode('collection');
        }
        setCollectionSheet(null);
        setIsCollectionAuthSheetOpen(false);
        setNotice('Сборник добавлен в ваш аккаунт.');
        setError(null);
        if (typeof window !== 'undefined') {
          window.history.replaceState(null, '', '/');
        }
      })
      .catch((err) => {
        setError(err instanceof Error ? err.message : 'Не удалось добавить сборник по ссылке.');
      });
  }, [account?.authenticated, account?.user?.id, isAdminMode, isLiveListPreview, isUserCollectionsReady, songs]);

  useEffect(() => {
    if (isLiveListPreview) return;
    if (!liveCollectionId) {
      if (listMode === 'live') return;
      if (liveSongId) setLiveSongId(null);
      if (liveSongIds.length > 0) setLiveSongIds([]);
      return;
    }

    const liveCollection = liveCollections.find((collection) => collection.id === liveCollectionId);
    if (!liveCollection) {
      if (liveSongId) setLiveSongId(null);
      if (liveSongIds.length > 0) setLiveSongIds([]);
      return;
    }

    const catalogSongIds = new Set(songs.map((song) => song.id));
    const sourceSongIds = new Set(liveCollection.songIds.filter((songId) => catalogSongIds.has(songId)));
    const nextLiveSongIds = liveSongIds.filter((songId) => sourceSongIds.has(songId));
    if (nextLiveSongIds.length !== liveSongIds.length) {
      setLiveSongIds(nextLiveSongIds);
    }
    if (liveSongId && !nextLiveSongIds.includes(liveSongId)) {
      setLiveSongId(nextLiveSongIds[0] ?? null);
    }
  }, [isLiveListPreview, listMode, liveCollectionId, liveCollections, liveSongId, liveSongIds, songs]);

  useEffect(() => {
    if (isLiveListPreview || listMode !== 'live' || !liveCollectionId) return;
    setLiveCollections((current) =>
      current.map((collection) => {
        if (collection.id !== liveCollectionId) return collection;
        if (areSongIdListsEqual(collection.songIds, liveSongIds)) return collection;

        return { ...collection, songIds: liveSongIds, updatedAt: new Date().toISOString() };
      }),
    );
  }, [isLiveListPreview, listMode, liveCollectionId, liveSongIds]);

  useEffect(() => {
    savePlaybackPosition(playbackPosition);
  }, [playbackPosition]);

  useEffect(() => {
    if (activeSongId || !shouldRestoreListScrollRef.current) return;

    shouldRestoreListScrollRef.current = false;
    window.requestAnimationFrame(() => {
      window.scrollTo({ top: listScrollYRef.current, left: 0, behavior: 'auto' });
    });
  }, [activeSongId]);

  useEffect(() => {
    if (isAdminMode && songs.length > 0) {
      saveSongs(songs);
    }
  }, [isAdminMode, songs]);

  useEffect(() => {
    if (!isAppMenuOpen) return undefined;

    const closeOnOutsidePointer = (event: PointerEvent) => {
      if (appMenuRef.current?.contains(event.target as Node)) return;
      setIsAppMenuOpen(false);
    };
    const closeOnEscape = (event: KeyboardEvent) => {
      if (event.key === 'Escape') {
        setIsAppMenuOpen(false);
      }
    };

    document.addEventListener('pointerdown', closeOnOutsidePointer);
    document.addEventListener('keydown', closeOnEscape);

    return () => {
      document.removeEventListener('pointerdown', closeOnOutsidePointer);
      document.removeEventListener('keydown', closeOnEscape);
    };
  }, [isAppMenuOpen]);

  const onSettingsChange = (next: SongSettings) => setSettings(next);

  const requireCollectionAccount = () => {
    if (account?.authenticated && isUserCollectionsReady) return true;
    if (account?.authenticated) {
      setNotice('Загружаю сборники аккаунта...');
      setError(null);
      return false;
    }

    setCollectionSheet(null);
    setNotice(isAccountLoading || !account ? 'Проверяю вход в аккаунт...' : COLLECTION_LOGIN_MESSAGE);
    setError(null);
    setIsCollectionAuthSheetOpen(true);
    return false;
  };

  const selectListMode = (mode: SongListMode) => {
    if (mode === 'collection' && !requireCollectionAccount()) return;
    setListMode(mode);
    if (mode !== 'collection') {
      setActiveCollectionId(null);
    }
    if (mode === 'live') {
      setQuery('');
      setActiveCategory(null);
    }
  };

  const selectCollection = (collectionId: string) => {
    if (!requireCollectionAccount()) return;
    setListMode('collection');
    setActiveCollectionId(collectionId);
  };

  const openCreateCollection = (initialSongId?: string) => {
    if (!requireCollectionAccount()) return;
    setCollectionName('');
    setCollectionSheet({ kind: 'create', songId: initialSongId });
  };

  const createCollection = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    if (!requireCollectionAccount()) return;
    const normalizedName = collectionName.trim();
    if (!normalizedName) return;

    const now = new Date().toISOString();
    const collection: SongCollection = {
      id: `collection-${Date.now().toString(36)}-${Math.random().toString(36).slice(2, 7)}`,
      name: normalizedName,
      songIds: collectionSheet?.kind === 'create' && collectionSheet.songId ? [collectionSheet.songId] : [],
      createdAt: now,
      updatedAt: now,
      authorName: account?.authenticated ? account.user?.displayName : undefined,
      isOwner: true,
    };

    setCollections((current) => [...current, collection]);
    setListMode('collection');
    setActiveCollectionId(collection.id);
    setCollectionName('');
    setCollectionSheet(null);
  };

  const toggleSongInCollection = (songId: string, targetCollectionId: string) => {
    if (!requireCollectionAccount()) return;
    const now = new Date().toISOString();
    setCollections((current) =>
      current.map((collection) => {
        if (collection.id !== targetCollectionId) return collection;
        if (collection.isOwner === false) return collection;
        const hasSong = collection.songIds.includes(songId);

        return {
          ...collection,
          songIds: hasSong ? collection.songIds.filter((item) => item !== songId) : [...collection.songIds, songId],
          updatedAt: now,
        };
      }),
    );
  };

  const toggleSongCollection = (songId: string) => {
    if (!requireCollectionAccount()) return;
    if (ownedCollections(collections).length === 0) {
      openCreateCollection(songId);
      return;
    }

    setCollectionSheet({ kind: 'pick', songId });
  };

  const pickCollectionForSong = (songId: string, collectionId: string) => {
    toggleSongInCollection(songId, collectionId);
  };

  const deleteCollection = (collectionId: string) => {
    if (!requireCollectionAccount()) return;
    const collection = collections.find((item) => item.id === collectionId);
    if (!collection) return;
    if (collection.isOwner === false) return;
    if (typeof window !== 'undefined' && !window.confirm(`Удалить сборник «${collection.name}»?`)) return;

    setCollections((current) => current.filter((item) => item.id !== collectionId));
    if (activeCollectionId === collectionId) {
      setActiveCollectionId(null);
      setListMode('all');
    }
  };

  const recentSongs = useMemo(
    () => recentSongIds.flatMap((songId) => songs.find((song) => song.id === songId) ?? []),
    [recentSongIds, songs],
  );

  const activeCollection = useMemo(
    () => {
      if (account?.authenticated && isUserCollectionsReady) {
        return collections.find((collection) => collection.id === activeCollectionId) ?? null;
      }
      if (publicSharedCollection?.id === activeCollectionId) {
        return publicSharedCollection;
      }
      return null;
    },
    [account?.authenticated, activeCollectionId, collections, isUserCollectionsReady, publicSharedCollection],
  );
  const liveCollection = useMemo(
    () => liveCollections.find((collection) => collection.id === liveCollectionId) ?? null,
    [liveCollections, liveCollectionId],
  );
  const liveSourceSongs = songs;

  const syncActiveLiveCollectionSongs = (nextSongIds: string[]) => {
    if (!liveCollectionId) return;

    setLiveCollections((current) =>
      current.map((collection) => {
        if (collection.id !== liveCollectionId) return collection;
        if (areSongIdListsEqual(collection.songIds, nextSongIds)) return collection;

        return { ...collection, songIds: nextSongIds, updatedAt: new Date().toISOString() };
      }),
    );
  };

  const requireLiveAccount = () => {
    if (isLiveListPreview) return true;
    if (account?.authenticated && isUserLiveStateReady) return true;
    if (account?.authenticated) {
      setNotice('Загружаю live-сборники аккаунта...');
      setError(null);
      return false;
    }
    setNotice(isAccountLoading || !account ? 'Проверяю вход в аккаунт...' : LIVE_LOGIN_MESSAGE);
    setError(null);
    setIsAppMenuOpen(true);
    return false;
  };

  const openLiveMode = () => {
    if (!requireLiveAccount()) return;
    const catalogSongIds = new Set(songs.map((song) => song.id));
    const nextLiveSongIds = liveSongIds.filter((songId) => catalogSongIds.has(songId));
    setLiveCollectionId(null);
    setLiveSongIds(nextLiveSongIds);
    setLiveSongId(liveSongId && nextLiveSongIds.includes(liveSongId) ? liveSongId : nextLiveSongIds[0] ?? null);
    setQuery('');
    setActiveCategory(null);
    setListMode('live');
    setActiveCollectionId(null);
  };

  const selectLiveCollection = (collectionId: string) => {
    if (!requireLiveAccount()) return;
    const collection = liveCollections.find((item) => item.id === collectionId);
    if (!collection) return;

    const catalogSongIds = new Set(songs.map((song) => song.id));
    const nextLiveSongIds = collection.songIds.filter((songId) => catalogSongIds.has(songId));
    setLiveCollectionId(collection.id);
    setLiveSongIds(nextLiveSongIds);
    setLiveSongId(nextLiveSongIds[0] ?? null);
    setQuery('');
    setActiveCategory(null);
    setListMode('live');
    setActiveCollectionId(null);
  };

  const createLiveCollection = () => {
    if (!requireLiveAccount()) return;
    if (typeof window === 'undefined') return;
    const name = window.prompt('Название live-сборника')?.trim();
    if (!name) return;

    const now = new Date().toISOString();
    const collection: SongCollection = {
      id: `live-${Date.now().toString(36)}-${Math.random().toString(36).slice(2, 7)}`,
      name,
      songIds: liveSongIds,
      createdAt: now,
      updatedAt: now,
    };

    setLiveCollections((current) => [...current, collection]);
    setLiveCollectionId(collection.id);
    setListMode('live');
    setActiveCollectionId(null);
  };

  const deleteLiveCollection = (collectionId: string) => {
    if (!requireLiveAccount()) return;
    const collection = liveCollections.find((item) => item.id === collectionId);
    if (!collection) return;
    if (typeof window !== 'undefined' && !window.confirm(`Удалить live-сборник «${collection.name}»?`)) return;

    setLiveCollections((current) => current.filter((item) => item.id !== collectionId));
    if (liveCollectionId === collectionId) {
      setLiveCollectionId(null);
      setLiveSongIds([]);
      setLiveSongId(null);
    }
  };

  const addLiveSong = (songId: string) => {
    if (!requireLiveAccount()) return;
    if (!liveSourceSongs.some((song) => song.id === songId)) return;

    setLiveSongIds((current) => {
      if (current.includes(songId)) return current;
      const next = [...current, songId];
      syncActiveLiveCollectionSongs(next);
      return next;
    });
    setLiveSongId((current) => current ?? songId);
  };

  const removeLiveSong = (songId: string) => {
    if (!requireLiveAccount()) return;
    const nextLiveSongIds = liveSongIds.filter((item) => item !== songId);
    syncActiveLiveCollectionSongs(nextLiveSongIds);
    setLiveSongIds(nextLiveSongIds);
    setLiveSongId((current) => (current === songId ? nextLiveSongIds[0] ?? null : current));
  };

  const resetLiveSongs = () => {
    if (!requireLiveAccount()) return;
    syncActiveLiveCollectionSongs([]);
    setLiveSongIds([]);
    setLiveSongId(null);
  };

  const shareText = async (title: string, text: string) => {
    try {
      if (typeof navigator !== 'undefined' && navigator.share) {
        await navigator.share({ title, text });
      } else if (typeof navigator !== 'undefined' && navigator.clipboard) {
        await navigator.clipboard.writeText(text);
        setNotice('Текст для отправки скопирован.');
      } else {
        setNotice(text);
      }
      setError(null);
    } catch (shareError) {
      if (shareError instanceof DOMException && shareError.name === 'AbortError') return;
      setError('Не удалось подготовить отправку.');
    }
  };

  const shareSong = (song: Song) => void shareText(song.title, buildSongShareText(song));

  const shareCollection = (collectionId: string) => {
    const publicCollection = publicSharedCollection?.id === collectionId ? publicSharedCollection : null;
    if (!publicCollection && !requireCollectionAccount()) return;
    const collection = collections.find((item) => item.id === collectionId) ?? publicCollection;
    if (!collection) return;
    if (!collection.shareToken) {
      setNotice('Сборник сохраняется. Попробуйте поделиться через пару секунд.');
      setError(null);
      return;
    }

    const origin = getShareOrigin();
    const link = origin ? `${origin}/collection/${encodeURIComponent(collection.shareToken)}` : '';
    const body = [
      `Сборник: ${collection.name}`,
      link,
      '',
      buildCollectionShareText('Песни', collection.songIds, songs),
    ].filter(Boolean).join('\n');
    void shareText(collection.name, body);
  };

  const shareLive = () => {
    if (!requireLiveAccount()) return;
    const title = liveCollection ? `Live: ${liveCollection.name}` : 'Live';
    void shareText(title, buildCollectionShareText(title, liveSongIds, songs));
  };

  const moveLiveSong = (songId: string, direction: -1 | 1) => {
    if (!requireLiveAccount()) return;
    setLiveSongIds((current) => {
      const index = current.indexOf(songId);
      const nextIndex = index + direction;
      if (index < 0 || nextIndex < 0 || nextIndex >= current.length) return current;

      const next = [...current];
      [next[index], next[nextIndex]] = [next[nextIndex], next[index]];
      syncActiveLiveCollectionSongs(next);
      return next;
    });
  };

  const collectionCounts = useMemo(() => {
    const songIds = new Set(songs.map((song) => song.id));
    return collections.reduce<Record<string, number>>((acc, collection) => {
      acc[collection.id] = collection.songIds.filter((songId) => songIds.has(songId)).length;
      return acc;
    }, {});
  }, [collections, songs]);

  const categoryOptions = useMemo(() => {
    const counts = songs.reduce<Record<string, number>>((acc, song) => {
      const category = normalizeCategory(song.category);
      acc[category] = (acc[category] ?? 0) + 1;
      return acc;
    }, {});

    const categoryOrder = new Map<string, number>(songCategories.map((category, index) => [category, index]));

    return Object.entries(counts)
      .map(([name, count]) => ({ name, count }))
      .sort((a, b) => {
        const orderA = categoryOrder.get(a.name) ?? songCategories.length;
        const orderB = categoryOrder.get(b.name) ?? songCategories.length;

        return orderA === orderB ? a.name.localeCompare(b.name, 'ru') : orderA - orderB;
      });
  }, [songs]);

  const filteredSongs = useMemo(() => {
    const source =
      listMode === 'live'
        ? liveSongIds.flatMap((songId) => songs.find((song) => song.id === songId) ?? [])
        : listMode === 'recent'
          ? recentSongs
          : listMode === 'collection'
            ? activeCollection
              ? activeCollection.songIds.flatMap((songId) => songs.find((song) => song.id === songId) ?? [])
              : []
          : songs;
    if (listMode === 'live') {
      return source;
    }
    const categoryFiltered = activeCategory
      ? source.filter((song) => normalizeCategory(song.category) === activeCategory)
      : source;
    const normalized = query.trim().toLowerCase();
    if (!normalized) {
      return categoryFiltered;
    }
    return categoryFiltered.filter((song) => {
      const text = [
        song.title,
        ...(song.authors ?? []),
        normalizeCategory(song.category),
        String(song.number),
        ...(song.leadSheet ? [song.leadSheet] : []),
        ...(song.sections?.flatMap((section) => [...section.rows, ...section.chords.flat()]) ?? []),
        ...song.verses.flatMap((verse) => [...verse.rows, ...verse.chords.flat()]),
        ...(song.chorus ? [...song.chorus.rows, ...song.chorus.chords.flat()] : []),
        ...(song.bridge ? [...song.bridge.rows, ...song.bridge.chords.flat()] : []),
      ]
        .join(' ')
        .toLowerCase();

      return text.includes(normalized);
    });
  }, [songs, recentSongs, activeCollection, liveSongIds, listMode, activeCategory, query]);

  const activeSong = useMemo(() => {
    const resolvedSongId = resolveRouteSongId(songs, activeSongId);
    return resolvedSongId ? songs.find((item) => item.id === resolvedSongId) : undefined;
  }, [songs, activeSongId]);
  const activeLiveSongIndex = activeSong && listMode === 'live' ? liveSongIds.indexOf(activeSong.id) : -1;
  const previousLiveSong =
    activeLiveSongIndex > 0 ? songs.find((song) => song.id === liveSongIds[activeLiveSongIndex - 1]) : undefined;
  const nextLiveSong =
    activeLiveSongIndex >= 0 && activeLiveSongIndex < liveSongIds.length - 1
      ? songs.find((song) => song.id === liveSongIds[activeLiveSongIndex + 1])
      : undefined;
  const livePositionLabel =
    activeLiveSongIndex >= 0 ? `${activeLiveSongIndex + 1} из ${liveSongIds.length}` : undefined;
  const previewPlaybackPosition: SongPlaybackPosition | null =
    isPlaybackPreview && activeSong
      ? {
          songId: activeSong.id,
          sectionId: 'verse-0',
          sectionTitle: 'Куплет 1',
          lineIndex: 0,
          updatedAt: 'preview',
        }
      : playbackPosition;

  const importHandler = async (file: File) => {
    try {
      const text = await file.text();
      const imported = parseCatalogImport(text);
      setSongs(imported.songs);
      if (imported.settings) {
        setSettings(imported.settings);
      }
      if (imported.collections) {
        setCollections(imported.collections);
      }
      setError(null);
      setNotice(`Импортировано песен: ${imported.songs.length}`);
      setActiveSongId(null);
      updateSongQuery(null);
      setQuery('');
      setActiveCategory(null);
      setListMode('all');
      setActiveCollectionId(null);
      setLiveCollectionId(null);
      setLiveSongId(null);
      setLiveSongIds([]);
      setPlaybackPosition(null);
    } catch (err) {
      const message = err instanceof Error ? err.message : 'Ошибка импорта файла';
      setError(message);
      setNotice(null);
    }
  };

  const handleQueryChange = (value: string) => setQuery(value);

  const handleFileInput = async (file: File) => {
    await importHandler(file);
  };

  const openSong = (songId: string) => {
    listScrollYRef.current = window.scrollY;
    shouldRestoreListScrollRef.current = false;

    if (listMode === 'live') {
      setLiveSongId(songId);
    }

    setRecentSongIds((current) => [songId, ...current.filter((item) => item !== songId)].slice(0, RECENT_LIMIT));
    setActiveSongId(songId);
    updateSongQuery(songId);
    window.requestAnimationFrame(() => window.scrollTo({ top: 0, left: 0, behavior: 'auto' }));
  };

  const closeSong = () => {
    shouldRestoreListScrollRef.current = true;
    setActiveSongId(null);
    updateSongQuery(null);
  };

  const handleInstall = async () => {
    if (!installPrompt) return;
    await installPrompt.prompt();
    const choice = await installPrompt.userChoice;
    if (choice.outcome === 'accepted') {
      setIsStandalone(true);
    }
    setInstallPrompt(null);
  };

  const canPullRefresh = isOnline && syncState !== 'syncing';
  const isPullReady = pullDistance >= PULL_REFRESH_THRESHOLD;
  const tone = statusTone(isOnline, catalogSource, syncState);
  const toneLabel = statusLabel(tone, catalogSource, catalogMeta);
  const activeSongTransposition = activeSong ? songTranspositions[activeSong.id] ?? 0 : 0;
  const songViewSettings = {
    ...settings,
    splitSections: isSplitPreview ? true : settings.splitSections,
    transposition: activeSongTransposition,
  };
  const onSongTranspositionChange = (songId: string, transposition: number) =>
    setSongTranspositions((current) => ({ ...current, [songId]: transposition }));
  const canUseCollections = !!account?.authenticated && isUserCollectionsReady;
  const canUseLive = !!account?.authenticated && isUserLiveStateReady;
  const canShowLiveButton = !isAdminMode && !activeSong && canUseLive;

  const handleTouchStart = (event: React.TouchEvent<HTMLElement>) => {
    if (!canPullRefresh || window.scrollY > 2) return;
    pullStartY.current = event.touches[0]?.clientY ?? null;
  };

  const handleTouchMove = (event: React.TouchEvent<HTMLElement>) => {
    if (pullStartY.current === null) return;
    const currentY = event.touches[0]?.clientY;
    if (currentY === undefined) return;

    const distance = currentY - pullStartY.current;
    if (distance <= 0) {
      setPullDistance(0);
      return;
    }

    setPullDistance(Math.min(distance * 0.56, PULL_REFRESH_MAX));
  };

  const finishPullRefresh = async () => {
    if (pullDistance >= PULL_REFRESH_THRESHOLD && canPullRefresh) {
      await refreshCatalog(true);
    }
    pullStartY.current = null;
    setPullDistance(0);
  };

  const handleStatusDotClick = () => {
    if (isAdminMode || typeof window === 'undefined') return;
    const now = Date.now();
    const nextCount = now - adminStatusTapRef.current.lastAt > 1400 ? 1 : adminStatusTapRef.current.count + 1;
    adminStatusTapRef.current = { count: nextCount, lastAt: now };
    if (nextCount >= 3) {
      adminStatusTapRef.current = { count: 0, lastAt: 0 };
      window.location.assign('/admin');
    }
  };

  if (isAdminMode && !isAdminAuthenticated) {
    return (
      <main className={`app ${settings.darkTheme ? 'theme-dark' : 'theme-light'} ${settings.fontScale}`}>
        <div className="admin-login-shell">
          <section className="admin-login-card" aria-labelledby="admin-login-title">
            <div>
              <h1 id="admin-login-title">Вход в админку</h1>
            </div>

            {error ? <div className="error">{error}</div> : null}
            {notice ? <div className="notice">{notice}</div> : null}

            <form className="admin-login-form" onSubmit={handleAdminLogin}>
              <label className="submission-field">
                <span>Ключ доступа</span>
                <input
                  type="password"
                  value={adminApiKey}
                  onChange={(event) => setAdminApiKey(event.target.value)}
                  placeholder="Ключ доступа"
                  autoComplete="off"
                  autoFocus
                />
              </label>
              <button type="submit" className="sheet-primary" disabled={isAdminLoginLoading || !adminApiKey.trim()}>
                {isAdminLoginLoading ? 'Проверка...' : 'Войти'}
              </button>
            </form>

            <a className="admin-login-link" href="/">
              Вернуться в сборник
            </a>
          </section>
        </div>
      </main>
    );
  }

  return (
    <main
      className={`app ${settings.darkTheme ? 'theme-dark' : 'theme-light'} ${settings.fontScale}`}
      onTouchStart={handleTouchStart}
      onTouchMove={handleTouchMove}
      onTouchEnd={finishPullRefresh}
      onTouchCancel={finishPullRefresh}
    >
      <div
        className={`pull-refresh ${pullDistance > 0 || syncState === 'syncing' ? 'is-visible' : ''}`}
        style={{ transform: `translate3d(-50%, ${pullDistance > 0 ? Math.min(pullDistance, 72) - 84 : -84}px, 0)` }}
        aria-live="polite"
      >
        <span className={`pull-refresh-ring ${syncState === 'syncing' ? 'is-spinning' : ''}`} aria-hidden="true" />
        <span>
          {syncState === 'syncing'
            ? 'Обновляю каталог'
            : isPullReady
              ? 'Отпустите для обновления'
              : 'Потяните вниз'}
        </span>
      </div>

      <div className="app-shell">
        <header className="top-bar">
          <div className="top-title-row">
            {activeSong ? (
              <button type="button" className="top-back-button" onClick={closeSong} aria-label="Назад к списку">
                Назад
              </button>
            ) : null}
            <h1>{activeSong ? activeSong.title : isAdminMode ? 'Админка' : 'Песни'}</h1>
          </div>
          <div className="top-actions">
            {!account?.authenticated ? (
              <button
                className="top-login-button"
                type="button"
                onClick={openAccountBenefitsSheet}
                disabled={isAccountLoading}
              >
                {isAccountLoading ? 'Проверка...' : 'Войти'}
              </button>
            ) : null}
            {canShowLiveButton ? (
              <button className="top-live-button" type="button" onClick={openLiveMode} aria-pressed={listMode === 'live'}>
                Live
              </button>
            ) : null}
            <button
              type="button"
              className={`status-dot status-${tone}`}
              title={toneLabel}
              aria-label={toneLabel}
              onClick={handleStatusDotClick}
            >
              <span className="sr-only">{toneLabel}</span>
            </button>
            <details
              ref={appMenuRef}
              className="app-menu"
              open={isAppMenuOpen}
              onToggle={(event) => setIsAppMenuOpen(event.currentTarget.open)}
            >
              <summary className="menu-trigger" aria-label="Открыть меню">
                <span aria-hidden="true" />
                <span aria-hidden="true" />
                <span aria-hidden="true" />
              </summary>
              <div className="menu-panel">
                <SettingsPanel
                  settings={settings}
                  account={account}
                  isAccountLoading={isAccountLoading}
                  onChange={onSettingsChange}
                  onGoogleLogin={handleGoogleLogin}
                  onLogout={handleLogout}
                  onSavePreferences={handleSaveUserPreferences}
                />

                {!isStandalone && installPrompt ? (
                  <button className="toolbar-button install-button" onClick={handleInstall}>
                    Установить приложение
                  </button>
                ) : null}

                {!isAdminMode ? (
                  <button
                    className="toolbar-button install-button"
                    onClick={() => {
                      setIsAppMenuOpen(false);
                      setIsSubmissionSheetOpen(true);
                    }}
                  >
                    Предложить песню
                  </button>
                ) : null}

                {isAdminMode ? (
                  <div className="admin-tools">
                    <div>
                      <p className="admin-tools-title">Admin</p>
                      <p className="admin-tools-note">Отдельные страницы управления без модальных окон.</p>
                    </div>
                    <div className="toolbar">
	                      <button
	                        type="button"
	                        className="toolbar-button"
	                        onClick={() => {
	                          setIsAppMenuOpen(false);
	                          navigateAdmin({ page: 'songs' });
	                        }}
	                      >
	                        Каталог
	                      </button>
	                      <button
	                        type="button"
	                        className="toolbar-button"
	                        onClick={() => {
                          setIsAppMenuOpen(false);
                          navigateAdmin({ page: 'new' });
                        }}
                      >
                        Добавить песню
                      </button>
                      <button
                        type="button"
                        className="toolbar-button"
                        onClick={() => {
                          setIsAppMenuOpen(false);
                          navigateAdmin({ page: 'submissions' });
                        }}
                      >
                        Заявки
                      </button>
                      <button
                        type="button"
                        className="toolbar-button"
                        onClick={() => {
                          setIsAppMenuOpen(false);
                          void refreshCatalog(true);
                        }}
                      >
                        Обновить из БД
                      </button>
                      <label className="toolbar-button upload">
                        Импорт
                        <input type="file" accept="application/json" onChange={(event) => {
                          const file = event.target.files?.[0];
                          if (!file) return;
                          void handleFileInput(file);
                          event.currentTarget.value = '';
                        }} />
                      </label>
                      <button
                        onClick={() => {
                          buildExport(songs, settings, collections);
                          setNotice(`Экспорт подготовлен: ${songs.length} песен`);
                          setError(null);
                        }}
                        className="toolbar-button"
                      >
                        Экспорт
                      </button>
                      <button type="button" className="toolbar-button" onClick={handleAdminLogout}>
                        Выйти
                      </button>
                    </div>
                  </div>
                ) : null}
              </div>
            </details>
          </div>
        </header>

        <section className="content-panel">
          {error ? <div className="error">{error}</div> : null}
          {notice ? <div className="notice">{notice}</div> : null}
          {isAdminMode ? (
            <AdminPanel
              route={adminRoute}
              songs={songs}
              categories={categoryOptions.map((category) => category.name)}
              submissions={pendingSubmissions}
              isSubmissionsLoading={isPendingSubmissionsLoading}
              savingSubmissionId={savingSubmissionId}
              approvingSubmissionId={approvingSubmissionId}
              rejectingSubmissionId={rejectingSubmissionId}
              savingSongId={savingAdminSongId}
              deletingSongId={deletingAdminSongId}
              onNavigate={navigateAdmin}
              onRefreshCatalog={() => void refreshCatalog(true)}
              onRefreshSubmissions={() => void loadPendingSubmissions()}
              onCreateSong={async (message) => {
                setNotice(message);
                setError(null);
                await refreshCatalog(false);
                navigateAdmin({ page: 'songs' });
              }}
              onSaveSong={(songId, payload) => void handleSaveAdminSong(songId, payload)}
              onDeleteSong={(song) => void handleDeleteAdminSong(song)}
              onSaveSubmission={(submissionId, payload) => void handleSaveSubmission(submissionId, payload)}
              onApproveSubmission={(submissionId) => void handleApproveSubmission(submissionId)}
              onRejectSubmission={(submissionId) => void handleRejectSubmission(submissionId)}
              onLogout={handleAdminLogout}
              adminKey={adminApiKey}
            />
          ) : activeSong ? (
            <SongView
              song={activeSong}
              settings={songViewSettings}
              playbackPosition={previewPlaybackPosition}
              preferences={account?.authenticated ? account.preferences : undefined}
              initialAutoPlay={isAutoPlaybackPreview}
              livePositionLabel={livePositionLabel}
              previousLiveSong={previousLiveSong}
              nextLiveSong={nextLiveSong}
              onBack={closeSong}
              onShare={shareSong}
              onLiveSongSelect={openSong}
              onTranspositionChange={onSongTranspositionChange}
              onPlaybackPositionChange={setPlaybackPosition}
              onSubmitEdit={handleSubmitSongEdit}
            />
          ) : (
            <>
              <SongList
                songs={filteredSongs}
                query={query}
                onQuery={handleQueryChange}
                onOpen={openSong}
                categories={categoryOptions}
                activeCategory={activeCategory}
                onCategoryChange={setActiveCategory}
                initialCategoryPickerOpen={isCategoryPickerPreview}
                mode={listMode}
                onModeChange={selectListMode}
                totalCount={songs.length}
                recentCount={recentSongs.length}
                canUseCollections={canUseCollections}
                canUseLive={canUseLive}
                collections={canUseCollections ? collections : publicSharedCollection ? [publicSharedCollection] : []}
                activeCollectionId={activeCollectionId}
                liveCollectionId={liveCollectionId}
                liveCollections={liveCollections}
                activeLiveSongId={liveSongId}
                liveSongIds={liveSongIds}
                liveSourceSongs={liveSourceSongs}
                collectionCounts={collectionCounts}
                activeCollectionSongIds={listMode === 'collection' ? activeCollection?.songIds ?? [] : []}
                onCollectionSelect={selectCollection}
                onDeleteCollection={deleteCollection}
                onCreateCollection={() => openCreateCollection()}
                onShareCollection={shareCollection}
                onLiveCollectionChange={setLiveCollectionId}
                onLiveCollectionSelect={selectLiveCollection}
                onCreateLiveCollection={createLiveCollection}
                onDeleteLiveCollection={deleteLiveCollection}
                onLiveSongChange={setLiveSongId}
                onAddLiveSong={addLiveSong}
                onRemoveLiveSong={removeLiveSong}
                onMoveLiveSong={moveLiveSong}
                onResetLiveSongs={resetLiveSongs}
                onShareLive={shareLive}
                onToggleSongCollection={toggleSongCollection}
                onRequireAccount={openAccountBenefitsSheet}
              />
              <SearchHint query={query} count={filteredSongs.length} />
            </>
          )}
        </section>
      </div>

      {isCollectionAuthSheetOpen && !account?.authenticated ? (
        <div
          className="sheet-backdrop"
          onClick={(event) => {
            if (event.target === event.currentTarget) {
              setIsCollectionAuthSheetOpen(false);
            }
          }}
        >
          <section
            className="bottom-sheet auth-required-sheet"
            role="dialog"
            aria-modal="true"
            aria-labelledby="collection-auth-title"
          >
            <div className="sheet-header">
              <h2 id="collection-auth-title">Войдите, чтобы сохранить свой сборник</h2>
              <button
                className="sheet-close"
                onClick={() => setIsCollectionAuthSheetOpen(false)}
                aria-label="Закрыть"
              >
                Закрыть
              </button>
            </div>
            <p>
              Без входа доступен базовый каталог. Аккаунт нужен для личной работы со сборником на любом телефоне.
            </p>
            <ul className="auth-benefits-list">
              <li>Личные сборники сохраняются в аккаунте и не пропадают после перезахода.</li>
              <li>Можно подписываться на сборники других авторов по ссылке.</li>
              <li>Live-сборник и очередь служения доступны только после входа.</li>
            </ul>
            <div className="sheet-actions">
              <button type="button" className="sheet-secondary" onClick={() => setIsCollectionAuthSheetOpen(false)}>
                Только базовый сборник
              </button>
              <button type="button" className="sheet-primary" onClick={handleGoogleLogin} disabled={isAccountLoading}>
                {isAccountLoading ? 'Проверка...' : 'Войти через Google'}
              </button>
            </div>
          </section>
        </div>
      ) : null}

      {collectionSheet ? (
        <div
          className="sheet-backdrop"
          onClick={(event) => {
            if (event.target === event.currentTarget) {
              setCollectionSheet(null);
            }
          }}
        >
          <section className="bottom-sheet" role="dialog" aria-modal="true" aria-labelledby="collection-sheet-title">
            <div className="sheet-header">
              <h2 id="collection-sheet-title">
                {collectionSheet.kind === 'create' ? 'Новый сборник' : 'Добавить в сборник'}
              </h2>
              <button className="sheet-close" onClick={() => setCollectionSheet(null)} aria-label="Закрыть">
                Закрыть
              </button>
            </div>

            {collectionSheet.kind === 'create' ? (
              <form className="collection-form" onSubmit={createCollection}>
                <label className="sr-only" htmlFor="collection-name">
                  Название сборника
                </label>
                <input
                  id="collection-name"
                  className="collection-name-input"
                  value={collectionName}
                  onChange={(event) => setCollectionName(event.target.value)}
                  placeholder="Название"
                  autoFocus
                />
                <div className="sheet-actions">
                  <button type="button" className="sheet-secondary" onClick={() => setCollectionSheet(null)}>
                    Отмена
                  </button>
                  <button type="submit" className="sheet-primary" disabled={collectionName.trim().length === 0}>
                    Создать
                  </button>
                </div>
              </form>
            ) : (
              <div className="collection-choice-list">
                {ownedCollections(collections).map((collection) => {
                  const hasSong = collection.songIds.includes(collectionSheet.songId);

                  return (
                    <button
                      key={collection.id}
                      className={`collection-choice ${hasSong ? 'is-selected' : ''}`}
                      onClick={() => pickCollectionForSong(collectionSheet.songId, collection.id)}
                      aria-label={hasSong ? `Убрать из сборника ${collection.name}` : `Добавить в сборник ${collection.name}`}
                      aria-pressed={hasSong}
                    >
                      <span>
                        <strong>{collection.name}</strong>
                        <small>{collectionCounts[collection.id] ?? 0} песен</small>
                      </span>
                      <b aria-hidden="true">{hasSong ? '✓' : ''}</b>
                    </button>
                  );
                })}
                <button
                  className="collection-choice collection-choice-new"
                  onClick={() => {
                    setCollectionName('');
                    setCollectionSheet({ kind: 'create', songId: collectionSheet.songId });
                  }}
                >
                  <span>
                    <strong>Новый сборник</strong>
                    <small>Создать и сразу добавить песню</small>
                  </span>
                  <b aria-hidden="true">+</b>
                </button>
              </div>
            )}
          </section>
        </div>
      ) : null}

      {isSubmissionSheetOpen ? (
        <SongSubmissionSheet
          categories={categoryOptions.map((category) => category.name)}
          onClose={() => setIsSubmissionSheetOpen(false)}
          onSubmitted={(message) => {
            setIsSubmissionSheetOpen(false);
            setNotice(message);
            setError(null);
          }}
        />
      ) : null}
    </main>
  );
}

export default App;

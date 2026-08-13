import { FormEvent, useEffect, useMemo, useRef, useState } from 'react';
import { CatalogSnapshotMeta, Song, SongCollection, SongPlayback, SongPlaybackPosition, SongSettings } from './types/song';
import {
  defaultSettings,
  hydrateLegacyState,
  loadCatalogMeta,
  loadCollections,
  loadLiveCollectionId,
  loadLiveSongId,
  loadLiveSongIds,
  loadRecentSongs,
  loadPlaybackPosition,
  loadSettings,
  loadSongs,
  saveCatalogMeta,
  saveCollections,
  saveLiveCollectionId,
  saveLiveSongId,
  saveLiveSongIds,
  saveRecentSongs,
  savePlaybackPosition,
  saveSettings,
  saveSongs,
} from './lib/storage';
import { sampleCatalog } from './data/sampleCatalog';
import { songCategories } from './data/songCategories';
import {
  SongSubmission,
  SongSubmissionPayload,
  approveSongSubmission,
  fetchCatalogSnapshot,
  fetchPendingSongSubmissions,
  rejectSongSubmission,
  updateSongSubmission,
} from './lib/catalogApi';
import AdminSongCreateSheet from './components/AdminSongCreateSheet';
import AdminSubmissionsSheet from './components/AdminSubmissionsSheet';
import SongList from './components/SongList';
import SongSubmissionSheet from './components/SongSubmissionSheet';
import SongView from './components/SongView';
import SettingsPanel from './components/SettingsPanel';

type SongListMode = 'all' | 'recent' | 'collection' | 'live';
type CatalogSource = 'embedded' | 'local' | 'mysql';
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
  songIds: ['song-1', 'song-2'],
  createdAt: '2026-08-13T00:00:00.000Z',
  updatedAt: '2026-08-13T00:00:00.000Z',
};
const MIN_BPM = 40;
const MAX_BPM = 220;
const MIN_BEATS_PER_LINE = 1;
const MAX_BEATS_PER_LINE = 16;
const MAX_INTRO_BEATS = 64;
const DEFAULT_ADMIN_API_KEY = '123456';

const readSearchParam = (key: string) => {
  if (typeof window === 'undefined') return null;
  return new URLSearchParams(window.location.search).get(key);
};

const isAdminRoute = () => {
  if (typeof window === 'undefined') return false;
  const pathname = window.location.pathname.replace(/\/+$/, '') || '/';
  return pathname === '/admin';
};

const updateSongQuery = (songId: string | null) => {
  if (typeof window === 'undefined') return;

  const url = new URL(window.location.href);
  if (songId) {
    url.searchParams.set('song', songId);
    url.searchParams.delete('menu');
  } else {
    url.searchParams.delete('song');
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

    if (verses.length === 0) return null;
    return {
      id,
      number,
      title,
      category: normalizeCategory(song.category),
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
    playback: normalizeSongPlayback(song.playback),
    verses: song.verses ?? [],
  }));

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
  if (state === 'success' || source === 'mysql') return 'fresh';
  return 'stale';
};

const statusLabel = (tone: StatusTone, source: CatalogSource, meta: CatalogSnapshotMeta | null) => {
  if (tone === 'fresh') return `Online, каталог свежий${meta ? `, версия ${meta.version}` : ''}`;
  if (tone === 'syncing') return 'Online, обновление каталога';
  if (tone === 'offline') return 'Offline, используется локальный каталог';
  if (source === 'embedded') return 'Online, встроенный каталог';
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
  const [songs, setSongs] = useState<Song[]>(() => normalizeCatalog(sampleCatalog));
  const [recentSongIds, setRecentSongIds] = useState<string[]>([]);
  const [collections, setCollections] = useState<SongCollection[]>(() =>
    readSearchParam('livePreview') === '1' ? [LIVE_PREVIEW_COLLECTION] : [],
  );
  const [liveCollectionId, setLiveCollectionId] = useState<string | null>(() =>
    readSearchParam('livePreview') === '1' ? LIVE_PREVIEW_COLLECTION.id : null,
  );
  const [liveSongId, setLiveSongId] = useState<string | null>(() =>
    readSearchParam('livePreview') === '1' && readSearchParam('liveMode') === '1' ? 'song-1' : null,
  );
  const [liveSongIds, setLiveSongIds] = useState<string[]>(() =>
    readSearchParam('livePreview') === '1' && readSearchParam('liveMode') === '1' ? ['song-1'] : [],
  );
  const [playbackPosition, setPlaybackPosition] = useState<SongPlaybackPosition | null>(null);
  const [settings, setSettings] = useState<SongSettings>(defaultSettings());
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
  const [activeSongId, setActiveSongId] = useState<string | null>(() => readSearchParam('song'));
  const [error, setError] = useState<string | null>(null);
  const [notice, setNotice] = useState<string | null>(null);
  const [isOnline, setIsOnline] = useState(() => (typeof navigator === 'undefined' ? true : navigator.onLine));
  const [catalogSource, setCatalogSource] = useState<CatalogSource>('embedded');
  const [catalogMeta, setCatalogMeta] = useState<CatalogSnapshotMeta | null>(null);
  const [syncState, setSyncState] = useState<SyncState>('idle');
  const [installPrompt, setInstallPrompt] = useState<BeforeInstallPromptEvent | null>(null);
  const [isStandalone, setIsStandalone] = useState(() =>
    typeof window === 'undefined' ? false : window.matchMedia('(display-mode: standalone)').matches,
  );
  const pullStartY = useRef<number | null>(null);
  const appMenuRef = useRef<HTMLDetailsElement | null>(null);
  const adminStatusTapRef = useRef({ count: 0, lastAt: 0 });
  const [isAppMenuOpen, setIsAppMenuOpen] = useState(isMenuPreview);
  const [pullDistance, setPullDistance] = useState(0);
  const [isSubmissionSheetOpen, setIsSubmissionSheetOpen] = useState(false);
  const [isAdminSubmissionsOpen, setIsAdminSubmissionsOpen] = useState(false);
  const [isAdminSongCreateOpen, setIsAdminSongCreateOpen] = useState(false);
  const [pendingSubmissions, setPendingSubmissions] = useState<SongSubmission[]>([]);
  const [isPendingSubmissionsLoading, setIsPendingSubmissionsLoading] = useState(false);
  const [savingSubmissionId, setSavingSubmissionId] = useState<number | null>(null);
  const [approvingSubmissionId, setApprovingSubmissionId] = useState<number | null>(null);
  const [rejectingSubmissionId, setRejectingSubmissionId] = useState<number | null>(null);
  const [adminApiKey, setAdminApiKey] = useState(() => (isAdminMode ? DEFAULT_ADMIN_API_KEY : ''));
  const [isAdminAuthenticated, setIsAdminAuthenticated] = useState(false);
  const [isAdminLoginLoading, setIsAdminLoginLoading] = useState(false);

  const applyCatalogSnapshot = async (snapshot: Awaited<ReturnType<typeof fetchCatalogSnapshot>>) => {
    if (!snapshot || snapshot.songs.length === 0) return false;

    const normalizedSongs = normalizeCatalog(snapshot.songs);
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
    setIsAdminSubmissionsOpen(false);
    setNotice(null);
    setError(null);
  };

  useEffect(() => {
    let cancelled = false;

    const load = async () => {
      await hydrateLegacyState();
      const [
        loadedSongs,
        loadedRecentSongs,
        loadedCollections,
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
        loadLiveCollectionId(),
        loadLiveSongId(),
        loadLiveSongIds(),
        loadPlaybackPosition(),
        loadSettings(),
        loadCatalogMeta(),
      ]);
      const baseCatalog = normalizeCatalog(loadedSongs.length > 0 ? loadedSongs : sampleCatalog);
      const baseCollections = isLiveListPreview ? [LIVE_PREVIEW_COLLECTION] : loadedCollections;

      if (cancelled) return;
      setSongs(baseCatalog);
      setCatalogSource(loadedSongs.length > 0 ? 'local' : 'embedded');
      setCatalogMeta(loadedCatalogMeta);
      setRecentSongIds(loadedRecentSongs);
      setCollections(baseCollections);
      setLiveCollectionId(
        isLiveListPreview
          ? LIVE_PREVIEW_COLLECTION.id
          : loadedCollections.some((collection) => collection.id === loadedLiveCollectionId)
            ? loadedLiveCollectionId
            : null,
      );
      setLiveSongId(
        isLiveListPreview
          ? isLiveModePreview
            ? 'song-1'
            : null
          : baseCatalog.some((song) => song.id === loadedLiveSongId)
            ? loadedLiveSongId
            : null,
      );
      setLiveSongIds(isLiveListPreview ? (isLiveModePreview ? ['song-1'] : []) : loadedLiveSongIds);
      if (isLiveListPreview) {
        setListMode(isLiveModePreview ? 'live' : 'collection');
        setActiveCollectionId(isLiveModePreview ? null : LIVE_PREVIEW_COLLECTION.id);
      }
      setPlaybackPosition(loadedPlaybackPosition);
      setSettings(loadedSettings);
      if (activeSongId && !baseCatalog.some((song) => song.id === activeSongId)) {
        setActiveSongId(null);
        updateSongQuery(null);
      }

      if (typeof navigator !== 'undefined' && !navigator.onLine) return;

      setSyncState('syncing');
      const snapshot = await fetchCatalogSnapshot();
      if (cancelled) return;

      const applied = await applyCatalogSnapshot(snapshot);
      setSyncState(applied ? 'success' : 'failed');
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
    saveRecentSongs(recentSongIds);
  }, [recentSongIds]);

  useEffect(() => {
    if (isLiveListPreview) return;
    saveCollections(collections);
  }, [collections, isLiveListPreview]);

  useEffect(() => {
    if (isLiveListPreview) return;
    saveLiveCollectionId(liveCollectionId);
  }, [liveCollectionId, isLiveListPreview]);

  useEffect(() => {
    if (isLiveListPreview) return;
    saveLiveSongId(liveSongId);
  }, [liveSongId, isLiveListPreview]);

  useEffect(() => {
    if (isLiveListPreview) return;
    saveLiveSongIds(liveSongIds);
  }, [liveSongIds, isLiveListPreview]);

  useEffect(() => {
    if (isLiveListPreview) return;
    if (!liveCollectionId) {
      if (liveSongId) setLiveSongId(null);
      if (liveSongIds.length > 0) setLiveSongIds([]);
      return;
    }

    const liveCollection = collections.find((collection) => collection.id === liveCollectionId);
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
  }, [collections, isLiveListPreview, liveCollectionId, liveSongId, liveSongIds, songs]);

  useEffect(() => {
    savePlaybackPosition(playbackPosition);
  }, [playbackPosition]);

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

  const selectListMode = (mode: SongListMode) => {
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
    setListMode('collection');
    setActiveCollectionId(collectionId);
  };

  const openCreateCollection = (initialSongId?: string) => {
    setCollectionName('');
    setCollectionSheet({ kind: 'create', songId: initialSongId });
  };

  const createCollection = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    const normalizedName = collectionName.trim();
    if (!normalizedName) return;

    const now = new Date().toISOString();
    const collection: SongCollection = {
      id: `collection-${Date.now().toString(36)}-${Math.random().toString(36).slice(2, 7)}`,
      name: normalizedName,
      songIds: collectionSheet?.kind === 'create' && collectionSheet.songId ? [collectionSheet.songId] : [],
      createdAt: now,
      updatedAt: now,
    };

    setCollections((current) => [...current, collection]);
    setListMode('collection');
    setActiveCollectionId(collection.id);
    setCollectionName('');
    setCollectionSheet(null);
  };

  const toggleSongInCollection = (songId: string, targetCollectionId: string) => {
    const now = new Date().toISOString();
    setCollections((current) =>
      current.map((collection) => {
        if (collection.id !== targetCollectionId) return collection;
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
    if (collections.length === 0) {
      openCreateCollection(songId);
      return;
    }

    let targetCollectionId =
      listMode === 'collection' && activeCollectionId
        ? activeCollectionId
        : collections.length === 1
          ? collections[0].id
          : null;

    if (!targetCollectionId) {
      setCollectionSheet({ kind: 'pick', songId });
      return;
    }

    toggleSongInCollection(songId, targetCollectionId);
  };

  const pickCollectionForSong = (songId: string, collectionId: string) => {
    toggleSongInCollection(songId, collectionId);
    setCollectionSheet(null);
  };

  const recentSongs = useMemo(
    () => recentSongIds.flatMap((songId) => songs.find((song) => song.id === songId) ?? []),
    [recentSongIds, songs],
  );

  const activeCollection = useMemo(
    () => collections.find((collection) => collection.id === activeCollectionId) ?? null,
    [collections, activeCollectionId],
  );
  const liveCollection = useMemo(
    () => collections.find((collection) => collection.id === liveCollectionId) ?? null,
    [collections, liveCollectionId],
  );
  const liveSourceSongs = songs;

  const openLiveMode = () => {
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

  const addLiveSong = (songId: string) => {
    if (!liveSourceSongs.some((song) => song.id === songId)) return;
    if (liveSongIds.includes(songId)) return;

    setLiveSongIds([...liveSongIds, songId]);
    if (!liveSongId) {
      setLiveSongId(songId);
    }
  };

  const removeLiveSong = (songId: string) => {
    const nextLiveSongIds = liveSongIds.filter((item) => item !== songId);
    setLiveSongIds(nextLiveSongIds);
    setLiveSongId((current) => (current === songId ? nextLiveSongIds[0] ?? null : current));
  };

  const moveLiveSong = (songId: string, direction: -1 | 1) => {
    setLiveSongIds((current) => {
      const index = current.indexOf(songId);
      const nextIndex = index + direction;
      if (index < 0 || nextIndex < 0 || nextIndex >= current.length) return current;

      const next = [...current];
      [next[index], next[nextIndex]] = [next[nextIndex], next[index]];
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
        normalizeCategory(song.category),
        String(song.number),
        ...song.verses.flatMap((verse) => [...verse.rows, ...verse.chords.flat()]),
        ...(song.chorus ? [...song.chorus.rows, ...song.chorus.chords.flat()] : []),
        ...(song.bridge ? [...song.bridge.rows, ...song.bridge.chords.flat()] : []),
      ]
        .join(' ')
        .toLowerCase();

      return text.includes(normalized);
    });
  }, [songs, recentSongs, activeCollection, liveSongIds, listMode, activeCategory, query]);

  const activeSong = useMemo(() => songs.find((item) => item.id === activeSongId), [songs, activeSongId]);
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
    if (listMode === 'live') {
      setLiveSongId(songId);
    }

    setRecentSongIds((current) => [songId, ...current.filter((item) => item !== songId)].slice(0, RECENT_LIMIT));
    setActiveSongId(songId);
    updateSongQuery(songId);
  };

  const closeSong = () => {
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
  const songViewSettings = isSplitPreview ? { ...settings, splitSections: true } : settings;
  const canOpenLiveMode = !isAdminMode && !activeSong && listMode !== 'live';

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
              <p className="eyebrow">Admin</p>
              <h1 id="admin-login-title">Вход в админку</h1>
              <p className="admin-login-note">
                Панель доступна отдельно по адресу /admin. Если ADMIN_API_KEY на backend не задан, используется
                dev-ключ 123456.
              </p>
            </div>

            {error ? <div className="error">{error}</div> : null}
            {notice ? <div className="notice">{notice}</div> : null}

            <form className="admin-login-form" onSubmit={handleAdminLogin}>
              <label className="submission-field">
                <span>Admin key</span>
                <input
                  type="password"
                  value={adminApiKey}
                  onChange={(event) => setAdminApiKey(event.target.value)}
                  placeholder={DEFAULT_ADMIN_API_KEY}
                  autoComplete="off"
                  autoFocus
                />
              </label>
              <div className="admin-login-shortcuts">
                <button
                  type="button"
                  className="sheet-secondary"
                  onClick={() => setAdminApiKey(DEFAULT_ADMIN_API_KEY)}
                  disabled={adminApiKey.trim() === DEFAULT_ADMIN_API_KEY}
                >
                  Использовать 123456
                </button>
              </div>
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
            {canOpenLiveMode ? (
              <button className="top-live-button" type="button" onClick={openLiveMode}>
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
                <div className="menu-status">
                  <strong>{toneLabel}</strong>
                  <span>Последнее обновление: {formatDateTime(catalogMeta?.syncedAt)}</span>
                </div>

                <SettingsPanel settings={settings} onChange={onSettingsChange} />

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
                      <p className="admin-tools-note">Заявки и локальный импорт. Для обычных пользователей скрыто.</p>
                    </div>
                    <div className="toolbar">
                      <button
                        type="button"
                        className="toolbar-button"
                        onClick={() => {
                          setIsAppMenuOpen(false);
                          setIsAdminSongCreateOpen(true);
                        }}
                      >
                        Добавить песню
                      </button>
                      <button
                        type="button"
                        className="toolbar-button"
                        onClick={() => {
                          setIsAppMenuOpen(false);
                          setIsAdminSubmissionsOpen(true);
                          if (adminApiKey.trim()) void loadPendingSubmissions();
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
          {isAdminMode && !activeSong ? (
            <section className="admin-dashboard" aria-labelledby="admin-dashboard-title">
              <div>
                <p className="eyebrow">Admin panel</p>
                <h2 id="admin-dashboard-title">Управление каталогом</h2>
                <p>Каталог подтягивается из MySQL. Заявки можно проверить и добавить в текущую опубликованную версию.</p>
              </div>
              <div className="admin-dashboard-actions">
                <button type="button" className="sheet-primary" onClick={() => setIsAdminSongCreateOpen(true)}>
                  Добавить песню
                </button>
                <button
                  type="button"
                  className="sheet-primary"
                  onClick={() => {
                    setIsAdminSubmissionsOpen(true);
                    void loadPendingSubmissions();
                  }}
                >
                  Заявки
                </button>
                <button type="button" className="sheet-secondary" onClick={() => void refreshCatalog(true)}>
                  Обновить из БД
                </button>
                <button type="button" className="sheet-secondary" onClick={handleAdminLogout}>
                  Выйти
                </button>
              </div>
            </section>
          ) : null}

          {activeSong ? (
            <SongView
              song={activeSong}
              settings={songViewSettings}
              playbackPosition={previewPlaybackPosition}
              initialAutoPlay={isAutoPlaybackPreview}
              onBack={closeSong}
              onPlaybackPositionChange={setPlaybackPosition}
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
                collections={collections}
                activeCollectionId={activeCollectionId}
                liveCollectionId={liveCollectionId}
                activeLiveSongId={liveSongId}
                liveSongIds={liveSongIds}
                liveSourceSongs={liveSourceSongs}
                collectionCounts={collectionCounts}
                activeCollectionSongIds={listMode === 'collection' ? activeCollection?.songIds ?? [] : []}
                onCollectionSelect={selectCollection}
                onCreateCollection={() => openCreateCollection()}
                onOpenLiveMode={openLiveMode}
                onLiveCollectionChange={setLiveCollectionId}
                onLiveSongChange={setLiveSongId}
                onAddLiveSong={addLiveSong}
                onRemoveLiveSong={removeLiveSong}
                onMoveLiveSong={moveLiveSong}
                onToggleSongCollection={toggleSongCollection}
              />
              <SearchHint query={query} count={filteredSongs.length} />
            </>
          )}
        </section>
      </div>

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
                {collections.map((collection) => {
                  const hasSong = collection.songIds.includes(collectionSheet.songId);

                  return (
                    <button
                      key={collection.id}
                      className="collection-choice"
                      onClick={() => pickCollectionForSong(collectionSheet.songId, collection.id)}
                      aria-label={hasSong ? `Убрать из сборника ${collection.name}` : `Добавить в сборник ${collection.name}`}
                    >
                      <span>
                        <strong>{collection.name}</strong>
                        <small>{collectionCounts[collection.id] ?? 0} песен</small>
                      </span>
                      <b aria-hidden="true">{hasSong ? '-' : '+'}</b>
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

      {isAdminMode && isAdminSubmissionsOpen ? (
        <AdminSubmissionsSheet
          submissions={pendingSubmissions}
          isLoading={isPendingSubmissionsLoading}
          approvingId={approvingSubmissionId}
          rejectingId={rejectingSubmissionId}
          savingId={savingSubmissionId}
          onRefresh={() => void loadPendingSubmissions()}
          onSave={(submissionId, payload) => void handleSaveSubmission(submissionId, payload)}
          onApprove={(submissionId) => void handleApproveSubmission(submissionId)}
          onReject={(submissionId) => void handleRejectSubmission(submissionId)}
          onClose={() => setIsAdminSubmissionsOpen(false)}
        />
      ) : null}

      {isAdminMode && isAdminSongCreateOpen ? (
        <AdminSongCreateSheet
          adminKey={adminApiKey}
          categories={categoryOptions.map((category) => category.name)}
          onClose={() => setIsAdminSongCreateOpen(false)}
          onCreated={async (message) => {
            setIsAdminSongCreateOpen(false);
            setNotice(message);
            setError(null);
            await refreshCatalog(false);
          }}
        />
      ) : null}
    </main>
  );
}

export default App;

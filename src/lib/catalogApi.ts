import { Song, SongCollection, SongOrderedSection, SongPlayback, SongSection } from '../types/song';

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

export type SongSubmissionPayload = {
  title: string;
  category: string;
  authors: string[];
  defaultKey: string;
  leadSheet?: string;
  sheetMusicUrl?: string;
  lyrics?: string;
  chords?: string;
  bpm: number;
  beatsPerLine: number;
  introBeats: number;
  submitterName: string;
  submitterEmail: string;
  note: string;
};

export type SongSubmission = SongSubmissionPayload & {
  id: number;
  sourceSongId?: string;
  sourceTitle?: string;
  sourceAuthors?: string[];
  sourceLeadSheet?: string;
  status: string;
  createdAt: string;
};

export type SongSubmissionCreated = {
  id: number;
  status: string;
};

export type ApproveSongSubmissionResult = {
  songId: string;
  catalogVersion: string;
};

export type SheetMusicUploadResult = {
  url: string;
};

export type CreateAdminSongResult = {
  songId: string;
  catalogVersion: string;
};

export type AdminSongUpdatePayload = {
  title: string;
  category: string;
  authors: string[];
  defaultKey: string;
  leadSheet?: string;
  sheetMusicUrl?: string;
  bpm: number;
  beatsPerLine: number;
  introBeats: number;
  sections?: AdminSongSectionUpdatePayload[];
};

export type AdminSongSectionUpdatePayload = {
  sectionType: 'intro' | 'verse' | 'prechorus' | 'chorus' | 'bridge' | 'instrumental' | 'outro' | 'tag';
  title: string;
  lyrics: string;
  chords: string;
};

export type CurrentUser = {
  id: number;
  displayName: string;
  email?: string;
  avatarUrl?: string;
};

export type UserPreferences = {
  instrument: string;
  preferredKeys: string[];
  capoEnabled: boolean;
  maxCapo: number;
  pianoTransposeEnabled: boolean;
  showOriginalKey: boolean;
};

export type CurrentUserState = {
  authenticated: boolean;
  user?: CurrentUser;
  preferences?: UserPreferences;
};

export type UserLiveState = {
  collections: SongCollection[];
  collectionId?: string;
  songId?: string;
  songIds: string[];
};

export type UserCollectionsState = {
  collections: SongCollection[];
  collection?: SongCollection;
};

const API_TIMEOUT_MS = 3500;
const UPLOAD_TIMEOUT_MS = 30000;

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

const requestJSON = async <T>(path: string, init: RequestInit): Promise<T> => {
  const controller = new AbortController();
  const timeout = window.setTimeout(() => controller.abort(), API_TIMEOUT_MS);

  try {
    const response = await fetch(apiUrl(path), {
      ...init,
      headers: {
        Accept: 'application/json',
        'Content-Type': 'application/json',
        ...init.headers,
      },
      cache: 'no-store',
      signal: controller.signal,
    });
    if (!response.ok) {
      const payload = (await response.json().catch(() => null)) as { error?: string } | null;
      throw new Error(payload?.error || `API request failed: ${response.status}`);
    }

    return (await response.json()) as T;
  } finally {
    window.clearTimeout(timeout);
  }
};

const isStringList = (value: unknown): value is string[] =>
  Array.isArray(value) && value.every((item) => typeof item === 'string');

const isOptionalStringList = (value: unknown): value is string[] | undefined =>
  value === undefined || isStringList(value);

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

const isSongOrderedSection = (value: unknown): value is SongOrderedSection => {
  const section = value as SongOrderedSection;
  const knownSectionTypes = ['intro', 'verse', 'prechorus', 'chorus', 'bridge', 'instrumental', 'outro', 'tag'];
  return (
    isSongSection(value) &&
    typeof section.title === 'string' &&
    knownSectionTypes.includes(section.sectionType)
  );
};

const isOptionalSongOrderedSections = (value: unknown): value is SongOrderedSection[] | undefined =>
  value === undefined || (Array.isArray(value) && value.every(isSongOrderedSection));

const isOptionalString = (value: unknown): value is string | undefined =>
  value === undefined || typeof value === 'string';

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
    isOptionalStringList(song.authors) &&
    isOptionalString(song.defaultKey) &&
    isOptionalString(song.leadSheet) &&
    isOptionalString(song.sheetMusicUrl) &&
    isOptionalSongPlayback(song.playback) &&
    isOptionalSongOrderedSections(song.sections) &&
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

export const fetchCurrentUser = (): Promise<CurrentUserState> =>
  requestJSON<CurrentUserState>('/api/me', {
    method: 'GET',
    credentials: 'include',
  });

export const logoutCurrentUser = (): Promise<{ authenticated: false }> =>
  requestJSON<{ authenticated: false }>('/api/auth/logout', {
    method: 'POST',
    credentials: 'include',
  });

export const saveUserPreferences = (payload: UserPreferences): Promise<UserPreferences> =>
  requestJSON<UserPreferences>('/api/me/preferences', {
    method: 'PUT',
    credentials: 'include',
    body: JSON.stringify(payload),
  });

export const fetchUserLiveState = (): Promise<UserLiveState> =>
  requestJSON<UserLiveState>('/api/me/live-state', {
    method: 'GET',
    credentials: 'include',
  });

export const saveUserLiveState = (payload: UserLiveState): Promise<UserLiveState> =>
  requestJSON<UserLiveState>('/api/me/live-state', {
    method: 'PUT',
    credentials: 'include',
    body: JSON.stringify(payload),
  });

export const fetchUserCollections = (): Promise<UserCollectionsState> =>
  requestJSON<UserCollectionsState>('/api/me/collections', {
    method: 'GET',
    credentials: 'include',
  });

export const saveUserCollections = (collections: SongCollection[]): Promise<UserCollectionsState> =>
  requestJSON<UserCollectionsState>('/api/me/collections', {
    method: 'PUT',
    credentials: 'include',
    body: JSON.stringify({ collections }),
  });

export const fetchSharedCollection = (shareToken: string): Promise<UserCollectionsState> =>
  requestJSON<UserCollectionsState>(`/api/shared-collections/${encodeURIComponent(shareToken)}`, {
    method: 'GET',
    credentials: 'include',
  });

export const importSharedCollection = (shareToken: string): Promise<UserCollectionsState> =>
  requestJSON<UserCollectionsState>(`/api/shared-collections/${encodeURIComponent(shareToken)}/import`, {
    method: 'POST',
    credentials: 'include',
  });

export const googleAuthStartUrl = (redirectPath: string): string =>
  apiUrl(`/api/auth/google/start?redirect=${encodeURIComponent(redirectPath)}`);

export const submitSongSubmission = (payload: SongSubmissionPayload): Promise<SongSubmissionCreated> =>
  requestJSON<SongSubmissionCreated>('/api/song-submissions', {
    method: 'POST',
    body: JSON.stringify(payload),
  });

export const submitSongEditSubmission = (songId: string, payload: SongSubmissionPayload): Promise<SongSubmissionCreated> =>
  requestJSON<SongSubmissionCreated>(`/api/songs/${encodeURIComponent(songId)}/edit-submissions`, {
    method: 'POST',
    body: JSON.stringify(payload),
  });

export const fetchPendingSongSubmissions = (adminKey: string): Promise<SongSubmission[]> =>
  requestJSON<SongSubmission[]>('/api/admin/song-submissions', {
    method: 'GET',
    headers: {
      'X-Admin-Key': adminKey.trim(),
    },
  });

export const approveSongSubmission = (
  submissionId: number,
  adminKey: string,
): Promise<ApproveSongSubmissionResult> =>
  requestJSON<ApproveSongSubmissionResult>(`/api/admin/song-submissions/${submissionId}/approve`, {
    method: 'POST',
    headers: {
      'X-Admin-Key': adminKey.trim(),
    },
  });

export const rejectSongSubmission = (
  submissionId: number,
  reason: string,
  adminKey: string,
): Promise<SongSubmissionCreated> =>
  requestJSON<SongSubmissionCreated>(`/api/admin/song-submissions/${submissionId}/reject`, {
    method: 'POST',
    headers: {
      'X-Admin-Key': adminKey.trim(),
    },
    body: JSON.stringify({ reason }),
  });

export const updateSongSubmission = (
  submissionId: number,
  payload: SongSubmissionPayload,
  adminKey: string,
): Promise<SongSubmissionCreated> =>
  requestJSON<SongSubmissionCreated>(`/api/admin/song-submissions/${submissionId}`, {
    method: 'PUT',
    headers: {
      'X-Admin-Key': adminKey.trim(),
    },
    body: JSON.stringify(payload),
  });

export const createAdminSong = (
  payload: SongSubmissionPayload,
  adminKey: string,
): Promise<CreateAdminSongResult> =>
  requestJSON<CreateAdminSongResult>('/api/admin/songs', {
    method: 'POST',
    headers: {
      'X-Admin-Key': adminKey.trim(),
    },
    body: JSON.stringify(payload),
  });

export const updateAdminSong = (
  songId: string,
  payload: AdminSongUpdatePayload,
  adminKey: string,
): Promise<CreateAdminSongResult> =>
  requestJSON<CreateAdminSongResult>(`/api/admin/songs/${encodeURIComponent(songId)}`, {
    method: 'PUT',
    headers: {
      'X-Admin-Key': adminKey.trim(),
    },
    body: JSON.stringify(payload),
  });

export const deleteAdminSong = (
  songId: string,
  adminKey: string,
): Promise<CreateAdminSongResult> =>
  requestJSON<CreateAdminSongResult>(`/api/admin/songs/${encodeURIComponent(songId)}`, {
    method: 'DELETE',
    headers: {
      'X-Admin-Key': adminKey.trim(),
    },
  });

export const uploadSheetMusicFile = async (file: File, adminKey: string): Promise<SheetMusicUploadResult> => {
  const controller = new AbortController();
  const timeout = window.setTimeout(() => controller.abort(), UPLOAD_TIMEOUT_MS);
  const formData = new FormData();
  formData.append('file', file);

  try {
    const response = await fetch(apiUrl('/api/admin/uploads/sheet-music'), {
      method: 'POST',
      headers: {
        Accept: 'application/json',
        'X-Admin-Key': adminKey.trim(),
      },
      body: formData,
      cache: 'no-store',
      signal: controller.signal,
    });
    if (!response.ok) {
      const payload = (await response.json().catch(() => null)) as { error?: string } | null;
      throw new Error(payload?.error || `API request failed: ${response.status}`);
    }

    return (await response.json()) as SheetMusicUploadResult;
  } finally {
    window.clearTimeout(timeout);
  }
};

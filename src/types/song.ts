export type SongSection = {
  rows: string[];
  chords: string[][];
};

export type SongPlayback = {
  bpm: number;
  beatsPerLine: number;
  introBeats?: number;
};

export type Song = {
  id: string;
  number: number;
  title: string;
  category: string;
  defaultKey?: string;
  playback?: SongPlayback;
  verses: SongSection[];
  chorus?: SongSection;
  bridge?: SongSection;
};

export type SongCollection = {
  id: string;
  name: string;
  songIds: string[];
  createdAt: string;
  updatedAt: string;
};

export type ViewPreset = 'lead' | 'singer' | 'chords';

export type SongPlaybackPosition = {
  songId: string;
  sectionId: string;
  sectionTitle: string;
  lineIndex: number;
  updatedAt: string;
};

export type SongSettings = {
  viewPreset: ViewPreset;
  showChords: boolean;
  repeatChorus: boolean;
  splitSections: boolean;
  transposition: number;
  fontScale: 'normal' | 'large';
  darkTheme: boolean;
};

export type CatalogSnapshotMeta = {
  version: string;
  publishedAt: string;
  syncedAt: string;
};

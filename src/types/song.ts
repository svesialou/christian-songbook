export type SongSection = {
  rows: string[];
  chords: string[][];
};

export type SongOrderedSection = SongSection & {
  sectionType: 'intro' | 'verse' | 'prechorus' | 'chorus' | 'bridge' | 'instrumental' | 'outro' | 'tag';
  title: string;
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
  authors?: string[];
  defaultKey?: string;
  leadSheet?: string;
  sheetMusicUrl?: string;
  playback?: SongPlayback;
  sections?: SongOrderedSection[];
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
  shareToken?: string;
  authorName?: string;
  isOwner?: boolean;
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
  showPlaybackDock: boolean;
  fontScale: 'normal' | 'large';
  darkTheme: boolean;
};

export type CatalogSnapshotMeta = {
  version: string;
  publishedAt: string;
  syncedAt: string;
};

const CHORDS = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'H'];
const FLAT_TO_SHARP: Record<string, string> = {
  Db: 'C#',
  Eb: 'D#',
  Gb: 'F#',
  Ab: 'G#',
  Bb: 'A#',
  Hb: 'A#',
  B: 'H',
};

export const normalizeTransposition = (transposition: number): number => {
  const safe = ((transposition % 12) + 12) % 12;
  return safe > 6 ? safe - 12 : safe;
};

export type SongKey = {
  root: string;
  minor: boolean;
  label: string;
};

export type PreferredKeyTransposition = {
  originalKey: string;
  targetKey: string;
  shift: number;
};

const normalizeNote = (note: string): string => {
  const accidental = note[1] === '#' || note[1] === 'b' ? note[1] : '';
  const normalized = `${note[0]?.toUpperCase() ?? ''}${accidental}`;
  if (normalized.startsWith('B') && !normalized.startsWith('Bb')) return normalized === 'B' ? 'H' : normalized;

  return FLAT_TO_SHARP[normalized] || normalized;
};

export const parseSongKey = (rawKey?: string): SongKey | null => {
  const match = rawKey?.trim().match(/^([A-Ha-h][#b]?)(m?)/);
  if (!match) return null;

  const root = normalizeNote(match[1]);
  if (!CHORDS.includes(root)) return null;

  const minor = match[2]?.toLowerCase() === 'm';
  return {
    root,
    minor,
    label: `${root}${minor ? 'm' : ''}`,
  };
};

const shiftIndex = (root: string, shift: number): string => {
  const index = CHORDS.indexOf(root);
  if (index === -1) return root;
  const count = CHORDS.length;
  const normalized = ((index + shift) % count + count) % count;
  return CHORDS[normalized];
};

export const transposeKeyLabel = (rawKey: string | undefined, transposition: number): string | null => {
  const key = parseSongKey(rawKey);
  if (!key) return null;

  return `${shiftIndex(key.root, normalizeTransposition(transposition))}${key.minor ? 'm' : ''}`;
};

export const findPreferredKeyTransposition = (
  rawOriginalKey: string | undefined,
  preferredKeys: string[],
): PreferredKeyTransposition | null => {
  const originalKey = parseSongKey(rawOriginalKey);
  if (!originalKey) return null;

  const candidates = preferredKeys
    .map((rawKey, index) => {
      const key = parseSongKey(rawKey);
      if (!key) return null;

      return {
        key,
        index,
        shift: normalizeTransposition(CHORDS.indexOf(key.root) - CHORDS.indexOf(originalKey.root)),
      };
    })
    .filter((item): item is { key: SongKey; index: number; shift: number } => Boolean(item));
  if (candidates.length === 0) return null;

  const sameModeCandidates = candidates.filter((candidate) => candidate.key.minor === originalKey.minor);
  const pool = sameModeCandidates.length > 0 ? sameModeCandidates : candidates;
  const best = pool.reduce((currentBest, candidate) => {
    const currentDistance = Math.abs(currentBest.shift);
    const candidateDistance = Math.abs(candidate.shift);
    if (candidateDistance < currentDistance) return candidate;
    if (candidateDistance === currentDistance && candidate.index < currentBest.index) return candidate;
    return currentBest;
  }, pool[0]);

  return {
    originalKey: originalKey.label,
    targetKey: best.key.label,
    shift: best.shift,
  };
};

const splitChordToken = (token: string): [string, string, string | null] | null => {
  const match = token.match(/^([A-Ha-h][#b]?)([^/\s]*)(?:\/([A-Ha-h][#b]?))?$/);
  if (!match) {
    return null;
  }
  return [match[1], match[2] || '', match[3] || null];
};

const transposeRoot = (rootRaw: string, transposition: number): string => {
  const root = normalizeNote(rootRaw);
  return shiftIndex(root, transposition);
};

const transposeToken = (token: string, transposition: number): string => {
  if (transposition === 0) return token;
  const parsed = splitChordToken(token);
  if (!parsed) return token;

  const [rootRaw, suffix, bassRaw] = parsed;
  const root = transposeRoot(rootRaw, transposition);
  const bass = bassRaw ? `/${transposeRoot(bassRaw, transposition)}` : '';

  return `${root}${suffix}${bass}`;
};

export const transposeChordLine = (line: string, transposition: number): string => {
  if (transposition === 0) return line;
  const shift = normalizeTransposition(transposition);
  if (shift === 0) return line;

  return line
    .split(/(\s+)/)
    .map((token) => {
      if (token.trim() === '') return token;
      return transposeToken(token, shift);
    })
    .join('');
};

export const transposeSongRows = (rows: string[], transposition: number): string[] =>
  rows.map((line) => transposeChordLine(line, transposition));

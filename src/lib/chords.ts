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

const normalizeNote = (note: string): string => {
  const accidental = note[1] === '#' || note[1] === 'b' ? note[1] : '';
  const normalized = `${note[0]?.toUpperCase() ?? ''}${accidental}`;
  if (normalized.startsWith('B') && !normalized.startsWith('Bb')) return normalized === 'B' ? 'H' : normalized;

  return FLAT_TO_SHARP[normalized] || normalized;
};

const shiftIndex = (root: string, shift: number): string => {
  const index = CHORDS.indexOf(root);
  if (index === -1) return root;
  const count = CHORDS.length;
  const normalized = ((index + shift) % count + count) % count;
  return CHORDS[normalized];
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

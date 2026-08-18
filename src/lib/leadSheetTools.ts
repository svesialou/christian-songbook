import { SongOrderedSection } from '../types/song';

const headerPattern = /^\s*\[(.+)]\s*$|^\s*([^:[\]]+):\s*$/;
const chordPattern = /^[A-Ha-h][#b]?(m|maj|min|sus|dim|aug|add)?[0-9]*(\/[A-Ha-h][#b]?)?$/;

type LeadSheetSection = {
  title: string;
  sectionType: SongOrderedSection['sectionType'];
  hasHeader: boolean;
  lines: string[];
};

const sectionTypeFromTitle = (title: string): SongOrderedSection['sectionType'] => {
  const lower = title.trim().toLowerCase();
  const suffix = String.raw`(?:\s+(?:\d+|[xх]\d+))?`;
  if (new RegExp(String.raw`^(вступление|интро|intro)${suffix}$`).test(lower)) return 'intro';
  if (new RegExp(String.raw`^(куплет|запев|verse)${suffix}$`).test(lower)) return 'verse';
  if (new RegExp(String.raw`^(пред[\s-]*припев|предприпев|pre[\s-]*chorus|prechorus)${suffix}$`).test(lower)) return 'prechorus';
  if (new RegExp(String.raw`^(припев|chorus|refrain)${suffix}$`).test(lower)) return 'chorus';
  if (new RegExp(String.raw`^(бридж|мост|bridge)${suffix}$`).test(lower)) return 'bridge';
  if (new RegExp(String.raw`^(проигрыш|инструментал|instrumental|interlude)${suffix}$`).test(lower)) return 'instrumental';
  if (new RegExp(String.raw`^(концовка|окончание|аутро|outro|ending)${suffix}$`).test(lower)) return 'outro';
  if (new RegExp(String.raw`^(тэг|тег|tag)${suffix}$`).test(lower)) return 'tag';
  return 'verse';
};

const parseHeader = (line: string): Pick<LeadSheetSection, 'sectionType' | 'title'> | null => {
  const match = line.match(headerPattern);
  const title = (match?.[1] || match?.[2] || '').trim();
  if (!title) return null;
  return { title, sectionType: sectionTypeFromTitle(title) };
};

const isChordOnlyLine = (line: string): boolean => {
  const tokens = line.trim().split(/\s+/).filter(Boolean);
  if (tokens.length === 0) return false;
  const chordTokens = tokens.filter((token) => chordPattern.test(token.replace(/[|,;()[\]{}]/g, '')));
  return chordTokens.length > 0 && chordTokens.length / tokens.length >= 0.65;
};

const parseLeadSheet = (leadSheet: string): LeadSheetSection[] => {
  const sections: LeadSheetSection[] = [];
  const ensureSection = () => {
    if (sections.length === 0) {
      sections.push({ title: 'Куплет 1', sectionType: 'verse', hasHeader: false, lines: [] });
    }
    return sections[sections.length - 1];
  };

  leadSheet.split('\n').forEach((rawLine) => {
    const header = parseHeader(rawLine);
    if (header) {
      sections.push({ ...header, hasHeader: true, lines: [] });
      return;
    }
    ensureSection().lines.push(rawLine);
  });

  return sections;
};

const chordRowsByLyricIndex = (section: LeadSheetSection): string[] => {
  const rows: string[] = [];
  let pendingChord = '';
  section.lines.forEach((rawLine) => {
    const line = rawLine.trim();
    if (!line) {
      pendingChord = '';
      return;
    }
    if (isChordOnlyLine(line)) {
      pendingChord = rawLine.trim();
      return;
    }
    rows.push(pendingChord);
    pendingChord = '';
  });
  return rows;
};

const hasAnyChord = (rows: string[]): boolean => rows.some((row) => row.trim().length > 0);

const renderSectionWithFilledChords = (section: LeadSheetSection, template: string[]): string => {
  const lines: string[] = section.hasHeader ? [`[${section.title}]`] : [];
  let pendingChord = '';
  let lyricIndex = 0;

  section.lines.forEach((rawLine) => {
    const line = rawLine.trim();
    if (!line) {
      pendingChord = '';
      lines.push(rawLine);
      return;
    }
    if (isChordOnlyLine(line)) {
      pendingChord = rawLine.trim();
      lines.push(rawLine);
      return;
    }

    const fallbackChord = template[lyricIndex]?.trim();
    if (!pendingChord && fallbackChord) {
      lines.push(fallbackChord);
    }
    lines.push(rawLine);
    pendingChord = '';
    lyricIndex += 1;
  });

  return lines.join('\n').trimEnd();
};

export const fillMissingVerseChords = (leadSheet: string): string => {
  const sections = parseLeadSheet(leadSheet);
  const verseTemplates = sections
    .filter((section) => section.sectionType === 'verse')
    .map(chordRowsByLyricIndex);
  const template = verseTemplates.find(hasAnyChord);
  if (!template) return leadSheet;

  return sections
    .map((section) => {
      if (section.sectionType !== 'verse') {
        const lines = section.hasHeader ? [`[${section.title}]`, ...section.lines] : section.lines;
        return lines.join('\n').trimEnd();
      }
      const existing = chordRowsByLyricIndex(section);
      const needsFill = existing.some((row, index) => !row.trim() && !!template[index]?.trim());
      return needsFill ? renderSectionWithFilledChords(section, template) : [section.hasHeader ? `[${section.title}]` : '', ...section.lines].filter(Boolean).join('\n').trimEnd();
    })
    .join('\n\n')
    .trim();
};

export const fillMissingVerseSectionChords = (sections: SongOrderedSection[]): SongOrderedSection[] => {
  const template = sections.find(
    (section) => section.sectionType === 'verse' && section.chords.some((row) => row.length > 0),
  )?.chords;
  if (!template) return sections;

  return sections.map((section) => {
    if (section.sectionType !== 'verse') return section;
    return {
      ...section,
      chords: section.rows.map((_, index) =>
        section.chords[index]?.length ? section.chords[index] : template[index] || [],
      ),
    };
  });
};

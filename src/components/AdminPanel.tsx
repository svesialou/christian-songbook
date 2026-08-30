import { FormEvent, ReactNode, useEffect, useMemo, useRef, useState } from 'react';
import { AdminSongUpdatePayload, SongListItem, SongSubmission, SongSubmissionPayload, createAdminSong, uploadSheetMusicFile } from '../lib/catalogApi';
import { parseSongKey } from '../lib/chords';
import { fillMissingVerseChords } from '../lib/leadSheetTools';
import { buildSongSearchIndex, matchesSearchQuery, normalizeSearchText } from '../lib/search';
import { preferredScrollBehavior } from '../lib/scroll';
import { Song, SongOrderedSection } from '../types/song';
import ScrollReturnButton from './ScrollReturnButton';

export type AdminRoute =
  | { page: 'home' }
  | { page: 'songs' }
  | { page: 'song'; songId: string }
  | { page: 'new' }
  | { page: 'submissions' }
  | { page: 'submission'; submissionId: number };

type Props = {
  route: AdminRoute;
  songs: Song[];
  categories: string[];
  submissions: SongSubmission[];
  isSubmissionsLoading: boolean;
  savingSubmissionId: number | null;
  approvingSubmissionId: number | null;
  rejectingSubmissionId: number | null;
  savingSongId: string | null;
  deletingSongId: string | null;
  adminKey: string;
  onNavigate: (route: AdminRoute) => void;
  onRefreshCatalog: () => void;
  onSearchSongs: (query: string) => Promise<SongListItem[]>;
  onEnsureSongLoaded: (songId: string) => Promise<void>;
  onRefreshSubmissions: () => void;
  onCreateSong: (message: string) => void | Promise<void>;
  onSaveSong: (songId: string, payload: AdminSongUpdatePayload) => void;
  onDeleteSong: (song: Song) => void;
  onSaveSubmission: (submissionId: number, payload: SongSubmissionPayload) => void;
  onApproveSubmission: (submissionId: number) => void;
  onRejectSubmission: (submissionId: number) => void;
  onLogout: () => void;
};

type SongDraft = AdminSongUpdatePayload & { leadSheet: string };
type SubmissionDraft = SongSubmissionPayload & { leadSheet: string };
type MetaKey = 'title' | 'category' | 'authors' | 'defaultKey' | 'sheetMusicUrl' | 'bpm' | 'beatsPerLine' | 'introBeats';
type MetaValue = string | number | string[];
type MetaDraft = Pick<SongDraft, MetaKey>;
type SongListFilter = 'all' | 'missing-chords';
type AdminSongListItem = SongListItem & {
  song?: Song;
};

const DEFAULT_CATEGORY = 'Общее';
const DEFAULT_BPM = 72;
const DEFAULT_BEATS_PER_LINE = 4;
const DEFAULT_INTRO_BEATS = 4;
const AUTHORS_PLACEHOLDER = 'Hillsong, Bethel Music';
const ADMIN_SONG_PAGE_SIZE = 180;

const parseAuthorsInput = (value: string): string[] => {
  const seen = new Set<string>();
  return value.split(',').flatMap((item) => {
    const author = item.trim();
    const key = author.toLowerCase();
    if (!author || seen.has(key)) return [];
    seen.add(key);
    return [author];
  });
};

const formatAuthors = (authors: string[] | undefined): string => (authors ?? []).join(', ');

const emptySubmissionDraft = (): SubmissionDraft => ({
  title: '',
  category: DEFAULT_CATEGORY,
  authors: [],
  defaultKey: '',
  sheetMusicUrl: '',
  leadSheet: '',
  bpm: DEFAULT_BPM,
  beatsPerLine: DEFAULT_BEATS_PER_LINE,
  introBeats: DEFAULT_INTRO_BEATS,
  submitterName: '',
  submitterEmail: '',
  note: '',
});

const buildOrderedSections = (song: Song): SongOrderedSection[] => {
  if (song.sections?.length) return song.sections;
  return [
    ...song.verses.map((section, index) => ({ ...section, sectionType: 'verse' as const, title: `Куплет ${index + 1}` })),
    ...(song.chorus ? [{ ...song.chorus, sectionType: 'chorus' as const, title: 'Припев' }] : []),
    ...(song.bridge ? [{ ...song.bridge, sectionType: 'bridge' as const, title: 'Мост' }] : []),
  ];
};

const sectionsToLeadSheet = (sections: SongOrderedSection[]) =>
  sections
    .map((section) => {
      const rows = section.rows.flatMap((line, index) => {
        const chordLine = section.chords[index]?.join(' ').trim();
        return chordLine ? [chordLine, line] : [line];
      });
      return [`[${section.title}]`, ...rows].join('\n');
    })
    .join('\n\n');

const inferKeyFromLeadSheet = (leadSheet: string): string => {
  for (const rawToken of leadSheet.split(/\s+/)) {
    const token = rawToken.replace(/[|,;()[\]{}]/g, '');
    const key = parseSongKey(token);
    if (key) return key.label;
  }
  return '';
};

const songHasChords = (song: Song): boolean => {
  const source = song.leadSheet || sectionsToLeadSheet(buildOrderedSections(song));
  return !!inferKeyFromLeadSheet(source);
};

const buildSongDraft = (song: Song): SongDraft => {
  const leadSheet = song.leadSheet?.trim() || sectionsToLeadSheet(buildOrderedSections(song));
  return {
    title: song.title,
    category: song.category || DEFAULT_CATEGORY,
    authors: song.authors ?? [],
    defaultKey: song.defaultKey || inferKeyFromLeadSheet(leadSheet),
    sheetMusicUrl: song.sheetMusicUrl || '',
    leadSheet,
    bpm: song.playback?.bpm ?? DEFAULT_BPM,
    beatsPerLine: song.playback?.beatsPerLine ?? DEFAULT_BEATS_PER_LINE,
    introBeats: song.playback?.introBeats ?? DEFAULT_INTRO_BEATS,
  };
};

const parseHeader = (line: string): Pick<SongOrderedSection, 'sectionType' | 'title'> | null => {
  const value = line.trim().replace(/^\[(.*)\]$/, '$1').replace(/:$/, '').trim();
  if (!value) return null;
  const lower = value.toLowerCase();
  const suffix = String.raw`(?:\s+(?:\d+|[xх]\d+))?`;
  if (new RegExp(String.raw`^(вступление|интро|intro)${suffix}$`).test(lower)) return { sectionType: 'intro', title: value };
  if (new RegExp(String.raw`^(куплет|запев|verse)${suffix}$`).test(lower)) return { sectionType: 'verse', title: value };
  if (new RegExp(String.raw`^(пред[\s-]*припев|предприпев|pre[\s-]*chorus|prechorus)${suffix}$`).test(lower)) return { sectionType: 'prechorus', title: value };
  if (new RegExp(String.raw`^(припев|chorus|refrain)${suffix}$`).test(lower)) return { sectionType: 'chorus', title: value };
  if (new RegExp(String.raw`^(бридж|мост|bridge)${suffix}$`).test(lower)) return { sectionType: 'bridge', title: value };
  if (new RegExp(String.raw`^(проигрыш|инструментал|instrumental|interlude)${suffix}$`).test(lower)) return { sectionType: 'instrumental', title: value };
  if (new RegExp(String.raw`^(концовка|окончание|аутро|outro|ending)${suffix}$`).test(lower)) return { sectionType: 'outro', title: value };
  if (new RegExp(String.raw`^(тэг|тег|tag)${suffix}$`).test(lower)) return { sectionType: 'tag', title: value };
  return null;
};

const isChordLine = (line: string) => {
  const tokens = line.trim().split(/\s+/).filter(Boolean);
  if (tokens.length === 0) return false;
  const chordTokens = tokens.filter((token) =>
    /^[A-Ha-h][#b]?(m|maj|min|sus|dim|aug|add)?[0-9]*(\/[A-Ha-h][#b]?)?$/.test(token.replace(/[|,]/g, '')),
  );
  return chordTokens.length > 0 && chordTokens.length / tokens.length >= 0.65;
};

const parseLeadSheetPreview = (text: string): SongOrderedSection[] => {
  const sections: SongOrderedSection[] = [];
  let pendingChords: string[] = [];
  const ensureSection = (header?: Pick<SongOrderedSection, 'sectionType' | 'title'>) => {
    if (header || sections.length === 0) {
      const verseCount = sections.filter((section) => section.sectionType === 'verse').length + 1;
      sections.push({
        sectionType: header?.sectionType ?? 'verse',
        title: header?.title ?? `Куплет ${verseCount}`,
        rows: [],
        chords: [],
      });
    }
    return sections[sections.length - 1];
  };

  text.split('\n').forEach((rawLine) => {
    const line = rawLine.trim();
    const header = parseHeader(line);
    if (header) {
      pendingChords = [];
      ensureSection(header);
      return;
    }
    if (!line) {
      pendingChords = [];
      return;
    }
    if (isChordLine(line)) {
      pendingChords = line.split(/\s+/).map((token) => token.trim()).filter(Boolean);
      return;
    }
    const section = ensureSection();
    section.rows.push(line);
    section.chords.push(pendingChords);
    pendingChords = [];
  });

  return sections.filter((section) => section.rows.length > 0);
};

const formatSubmissionDate = (value: string) => {
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return 'дата неизвестна';
  return new Intl.DateTimeFormat('ru', { day: '2-digit', month: '2-digit', hour: '2-digit', minute: '2-digit' }).format(date);
};

type LeadSheetDiffRow = {
  type: 'same' | 'added' | 'removed';
  value: string;
};

const buildLeadSheetDiff = (before: string, after: string): LeadSheetDiffRow[] => {
  const oldLines = before.split('\n');
  const newLines = after.split('\n');
  const table = Array.from({ length: oldLines.length + 1 }, () => Array(newLines.length + 1).fill(0) as number[]);

  for (let oldIndex = oldLines.length - 1; oldIndex >= 0; oldIndex -= 1) {
    for (let newIndex = newLines.length - 1; newIndex >= 0; newIndex -= 1) {
      table[oldIndex][newIndex] =
        oldLines[oldIndex] === newLines[newIndex]
          ? table[oldIndex + 1][newIndex + 1] + 1
          : Math.max(table[oldIndex + 1][newIndex], table[oldIndex][newIndex + 1]);
    }
  }

  const rows: LeadSheetDiffRow[] = [];
  let oldIndex = 0;
  let newIndex = 0;
  while (oldIndex < oldLines.length && newIndex < newLines.length) {
    if (oldLines[oldIndex] === newLines[newIndex]) {
      rows.push({ type: 'same', value: oldLines[oldIndex] });
      oldIndex += 1;
      newIndex += 1;
    } else if (table[oldIndex + 1][newIndex] >= table[oldIndex][newIndex + 1]) {
      rows.push({ type: 'removed', value: oldLines[oldIndex] });
      oldIndex += 1;
    } else {
      rows.push({ type: 'added', value: newLines[newIndex] });
      newIndex += 1;
    }
  }
  while (oldIndex < oldLines.length) {
    rows.push({ type: 'removed', value: oldLines[oldIndex] });
    oldIndex += 1;
  }
  while (newIndex < newLines.length) {
    rows.push({ type: 'added', value: newLines[newIndex] });
    newIndex += 1;
  }

  return rows;
};

const AdminNav = ({ active, onNavigate }: { active: AdminRoute['page']; onNavigate: Props['onNavigate'] }) => (
  <nav className="admin-nav" aria-label="Админка">
    <button type="button" className={active === 'home' ? 'is-active' : ''} onClick={() => onNavigate({ page: 'home' })}>Обзор</button>
    <button type="button" className={active === 'songs' || active === 'song' ? 'is-active' : ''} onClick={() => onNavigate({ page: 'songs' })}>Песни</button>
    <button type="button" className={active === 'new' ? 'is-active' : ''} onClick={() => onNavigate({ page: 'new' })}>Добавить</button>
    <button type="button" className={active === 'submissions' || active === 'submission' ? 'is-active' : ''} onClick={() => onNavigate({ page: 'submissions' })}>Заявки</button>
  </nav>
);

const FieldBlock = ({ title, hint, children }: { title: string; hint?: string; children: ReactNode }) => (
  <section className="admin-form-block">
    <div className="admin-form-block-title">
      <h3>{title}</h3>
      {hint ? <p>{hint}</p> : null}
    </div>
    {children}
  </section>
);

const LeadSheetField = ({
  value,
  disabled,
  onChange,
}: {
  value: string;
  disabled: boolean;
  onChange: (value: string) => void;
}) => {
  const sections = useMemo(() => parseLeadSheetPreview(value), [value]);
  const chordCount = useMemo(() => sections.reduce((count, section) => count + section.chords.flat().length, 0), [sections]);
  const filledLeadSheet = useMemo(() => fillMissingVerseChords(value), [value]);
  const canFillChords = filledLeadSheet !== value;
  return (
    <FieldBlock title="Текст с аккордами" hint="Единый источник песни. Строка аккордов ставится над строкой текста; при просмотре аккорды можно скрыть.">
      <div className="admin-inline-actions">
        <button type="button" className="sheet-secondary" onClick={() => onChange(filledLeadSheet)} disabled={disabled || !canFillChords}>
          Дополнить аккорды из первого куплета
        </button>
      </div>
      <label className="submission-field">
        <span>Полный блок</span>
        <textarea
          className="admin-large-textarea"
          value={value}
          onChange={(event) => onChange(event.target.value)}
          disabled={disabled}
          placeholder={'[Куплет 1]\nG      D\nБог твой Царь...\n\n[Припев]\nEm     C\nСлава Тебе...'}
          rows={18}
        />
      </label>
      <div className="admin-lead-preview" aria-live="polite">
        <strong>Разбор: {sections.length} секц., {chordCount} аккорд.</strong>
        {sections.length > 0 ? (
          <div className="admin-lead-preview-grid">
            {sections.map((section, index) => (
              <span key={`${section.title}-${index}`}>{section.title}: {section.rows.length} строк</span>
            ))}
          </div>
        ) : (
          <p>Пока нет строк текста для предпросмотра.</p>
        )}
      </div>
    </FieldBlock>
  );
};

const SongMetaFields = ({ draft, categories, disabled, adminKey, onChange }: {
  draft: MetaDraft;
  categories: string[];
  disabled: boolean;
  adminKey: string;
  onChange: (key: MetaKey, value: MetaValue) => void;
}) => {
  const [isUploading, setIsUploading] = useState(false);
  const [uploadError, setUploadError] = useState<string | null>(null);
  const uploadSheetMusic = async (file: File | undefined) => {
    if (!file) return;
    if (!adminKey.trim()) {
      setUploadError('Admin key пустой. Войдите в админку заново.');
      return;
    }
    setIsUploading(true);
    setUploadError(null);
    try {
      const result = await uploadSheetMusicFile(file, adminKey);
      onChange('sheetMusicUrl', result.url);
    } catch (err) {
      setUploadError(err instanceof Error ? err.message : 'Не удалось загрузить ноты.');
    } finally {
      setIsUploading(false);
    }
  };

  return (
    <>
      <FieldBlock title="Основное">
        <label className="submission-field"><span>Название</span><input value={draft.title} onChange={(event) => onChange('title', event.target.value)} disabled={disabled} /></label>
        <label className="submission-field">
          <span>Автор / исполнители</span>
          <input
            value={formatAuthors(draft.authors)}
            onChange={(event) => onChange('authors', parseAuthorsInput(event.target.value))}
            disabled={disabled}
            placeholder={AUTHORS_PLACEHOLDER}
          />
        </label>
        <div className="submission-grid">
          <label className="submission-field"><span>Категория</span><select value={draft.category} onChange={(event) => onChange('category', event.target.value)} disabled={disabled}>{categories.map((category) => <option key={category} value={category}>{category}</option>)}</select></label>
          <label className="submission-field"><span>Тональность</span><input value={draft.defaultKey} onChange={(event) => onChange('defaultKey', event.target.value)} disabled={disabled} placeholder="G, Am..." /></label>
        </div>
        <label className="submission-field"><span>Ноты PDF/изображение</span><input type="url" value={draft.sheetMusicUrl || ''} onChange={(event) => onChange('sheetMusicUrl', event.target.value)} disabled={disabled || isUploading} placeholder="https://...pdf или https://...jpg" /></label>
        <div className="admin-upload-row">
          <label className={`sheet-secondary admin-upload-button ${disabled || isUploading ? 'is-disabled' : ''}`}>
            {isUploading ? 'Загрузка...' : 'Загрузить файл нот'}
            <input
              type="file"
              accept="application/pdf,image/jpeg,image/png,image/webp,image/gif"
              disabled={disabled || isUploading}
              onChange={(event) => {
                void uploadSheetMusic(event.target.files?.[0]);
                event.currentTarget.value = '';
              }}
            />
          </label>
          <span>PDF, JPG, PNG, WebP или GIF до 12 MB. После загрузки ссылка подставится выше.</span>
        </div>
        {uploadError ? <div className="error">{uploadError}</div> : null}
      </FieldBlock>
      <FieldBlock title="Ритм">
        <div className="submission-grid submission-grid-three">
          <label className="submission-field"><span>BPM</span><input type="number" min={40} max={220} value={draft.bpm} onChange={(event) => onChange('bpm', Number(event.target.value))} disabled={disabled} /></label>
          <label className="submission-field"><span>Долей на строку</span><input type="number" min={1} max={16} value={draft.beatsPerLine} onChange={(event) => onChange('beatsPerLine', Number(event.target.value))} disabled={disabled} /></label>
          <label className="submission-field"><span>Вступление</span><input type="number" min={0} max={64} value={draft.introBeats} onChange={(event) => onChange('introBeats', Number(event.target.value))} disabled={disabled} /></label>
        </div>
      </FieldBlock>
    </>
  );
};

const LeadSheetDiff = ({ sourceTitle, before, after }: { sourceTitle: string; before: string; after: string }) => {
  const rows = useMemo(() => buildLeadSheetDiff(before, after), [before, after]);
  const changedCount = rows.filter((row) => row.type !== 'same').length;

  return (
    <FieldBlock
      title="Изменения"
      hint={`Правка опубликованной песни${sourceTitle ? `: ${sourceTitle}` : ''}. Зеленое добавлено, красное удалено.`}
    >
      <div className="admin-diff-summary">
        <span>{changedCount > 0 ? `${changedCount} изменённых строк` : 'Изменений в тексте не найдено'}</span>
      </div>
      <pre className="admin-diff" aria-label="Diff заявки">
        {rows.map((row, index) => (
          <span key={`${row.type}-${index}`} className={`admin-diff-line is-${row.type}`}>
            <b>{row.type === 'added' ? '+' : row.type === 'removed' ? '-' : ' '}</b>
            {row.value || ' '}
          </span>
        ))}
      </pre>
    </FieldBlock>
  );
};

const AdminSongPage = ({ song, categories, savingId, deletingId, adminKey, onSave, onDelete, onBackToSongs }: {
  song: Song | undefined;
  categories: string[];
  savingId: string | null;
  deletingId: string | null;
  adminKey: string;
  onSave: Props['onSaveSong'];
  onDelete: Props['onDeleteSong'];
  onBackToSongs: () => void;
}) => {
  const [draft, setDraft] = useState<SongDraft | null>(() => (song ? buildSongDraft(song) : null));
  const [error, setError] = useState<string | null>(null);
  const isSaving = !!song && savingId === song.id;
  const isDeleting = !!song && deletingId === song.id;
  const isBusy = isSaving || isDeleting;

  if (!song || !draft) {
    return <section className="admin-page"><button type="button" className="sheet-secondary admin-back" onClick={onBackToSongs}>Назад к песням</button><p className="empty">Песня не найдена.</p></section>;
  }

  const updateDraft = (key: keyof SongDraft, value: MetaValue) => setDraft((current) => (current ? { ...current, [key]: value } : current));
  const updateLeadSheet = (leadSheet: string) => setDraft((current) => current ? { ...current, leadSheet, defaultKey: current.defaultKey || inferKeyFromLeadSheet(leadSheet) } : current);
  const inferDefaultKey = () => {
    const inferredKey = inferKeyFromLeadSheet(draft.leadSheet);
    if (inferredKey) updateDraft('defaultKey', inferredKey);
    else setError('Не удалось определить тональность: в блоке нет распознанных аккордов.');
  };
  const save = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    if (!draft.title.trim()) return setError('Название обязательно.');
    if (!draft.leadSheet.trim()) return setError('Нужен текст песни с аккордами или без них.');
    setError(null);
    onSave(song.id, draft);
  };

  return (
    <section className="admin-page">
      <button type="button" className="sheet-secondary admin-back" onClick={onBackToSongs}>Назад к песням</button>
      <div className="admin-page-header"><p className="eyebrow">Песня #{song.number}</p><h2>{song.title}</h2></div>
      {error ? <div className="error">{error}</div> : null}
      <form className="admin-editor-form" onSubmit={save}>
        <SongMetaFields draft={draft} categories={categories} disabled={isBusy} adminKey={adminKey} onChange={updateDraft} />
        <div className="admin-inline-actions"><button type="button" className="sheet-secondary" onClick={inferDefaultKey} disabled={isBusy}>Определить тональность по аккордам</button></div>
        <LeadSheetField value={draft.leadSheet} disabled={isBusy} onChange={updateLeadSheet} />
        <div className="admin-sticky-actions">
          <button type="button" className="sheet-secondary" onClick={onBackToSongs} disabled={isBusy}>Назад к списку</button>
          <button type="button" className="sheet-secondary admin-danger-action" onClick={() => onDelete(song)} disabled={isBusy}>{isDeleting ? 'Скрытие...' : 'Скрыть песню'}</button>
          <button type="submit" className="sheet-primary" disabled={isBusy}>{isSaving ? 'Сохранение...' : 'Сохранить песню'}</button>
        </div>
      </form>
    </section>
  );
};

const AdminNewSongPage = ({ adminKey, categories, onCreateSong }: { adminKey: string; categories: string[]; onCreateSong: Props['onCreateSong'] }) => {
  const [draft, setDraft] = useState<SubmissionDraft>(() => emptySubmissionDraft());
  const [error, setError] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const updateDraft = (key: keyof SubmissionDraft, value: MetaValue) => setDraft((current) => ({ ...current, [key]: value }));
  const updateLeadSheet = (leadSheet: string) => setDraft((current) => ({ ...current, leadSheet, defaultKey: current.defaultKey || inferKeyFromLeadSheet(leadSheet) }));
  const submit = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    if (!draft.title.trim() || !draft.leadSheet.trim()) return setError('Нужно заполнить название и текст песни.');
    if (!adminKey.trim()) return setError('Admin key пустой. Войдите в админку заново.');
    setIsSubmitting(true);
    setError(null);
    try {
      const result = await createAdminSong(draft, adminKey);
      await onCreateSong(`Песня добавлена в MySQL-каталог: ${result.songId}`);
      setDraft(emptySubmissionDraft());
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Не удалось добавить песню.');
    } finally {
      setIsSubmitting(false);
    }
  };
  return (
    <section className="admin-page">
      <div className="admin-page-header"><p className="eyebrow">Новая песня</p><h2>Добавить в каталог</h2></div>
      {error ? <div className="error">{error}</div> : null}
      <form className="admin-editor-form" onSubmit={submit}>
        <SongMetaFields draft={draft} categories={categories} disabled={isSubmitting} adminKey={adminKey} onChange={updateDraft} />
        <LeadSheetField value={draft.leadSheet} disabled={isSubmitting} onChange={updateLeadSheet} />
        <FieldBlock title="Комментарий"><label className="submission-field"><span>Комментарий</span><textarea value={draft.note} onChange={(event) => updateDraft('note', event.target.value)} rows={3} /></label></FieldBlock>
        <div className="admin-sticky-actions"><button type="submit" className="sheet-primary" disabled={isSubmitting}>{isSubmitting ? 'Сохранение...' : 'Добавить песню'}</button></div>
      </form>
    </section>
  );
};

const AdminSubmissionsPage = ({ submissions, isLoading, busyIds, onNavigate, onRefresh, onApprove, onReject }: {
  submissions: SongSubmission[];
  isLoading: boolean;
  busyIds: Array<number | null>;
  onNavigate: Props['onNavigate'];
  onRefresh: Props['onRefreshSubmissions'];
  onApprove: Props['onApproveSubmission'];
  onReject: Props['onRejectSubmission'];
}) => (
  <section className="admin-page">
    <div className="admin-page-header"><p className="eyebrow">Pending</p><h2>Заявки</h2></div>
    <div className="admin-inline-actions"><button type="button" className="sheet-secondary" onClick={onRefresh} disabled={isLoading}>{isLoading ? 'Загрузка...' : 'Обновить'}</button></div>
    <div className="admin-list">
      {submissions.length === 0 ? <p className="empty">Нет pending заявок.</p> : null}
      {submissions.map((submission) => {
        const isBusy = busyIds.includes(submission.id);
        return (
          <article key={submission.id} className="admin-list-card">
            <button type="button" className="admin-list-main" onClick={() => onNavigate({ page: 'submission', submissionId: submission.id })}>
              <strong>{submission.title}</strong>
              <small>
                #{submission.id} · {submission.sourceSongId ? 'правка песни' : 'новая песня'} · {submission.category} · {formatSubmissionDate(submission.createdAt)}
              </small>
            </button>
            <div className="admin-list-actions">
              <button type="button" className="sheet-primary" onClick={() => onApprove(submission.id)} disabled={isBusy}>Апрувить</button>
              <button type="button" className="sheet-secondary" onClick={() => onReject(submission.id)} disabled={isBusy}>Отклонить</button>
            </div>
          </article>
        );
      })}
    </div>
  </section>
);

const AdminSubmissionPage = ({ submission, categories, savingId, approvingId, rejectingId, adminKey, onSave, onApprove, onReject, onNavigate }: {
  submission: SongSubmission | undefined;
  categories: string[];
  savingId: number | null;
  approvingId: number | null;
  rejectingId: number | null;
  adminKey: string;
  onSave: Props['onSaveSubmission'];
  onApprove: Props['onApproveSubmission'];
  onReject: Props['onRejectSubmission'];
  onNavigate: Props['onNavigate'];
}) => {
  const [draft, setDraft] = useState<SubmissionDraft | null>(() =>
    submission ? { ...submission, authors: submission.authors ?? [], sheetMusicUrl: submission.sheetMusicUrl || '', leadSheet: submission.leadSheet || submission.lyrics || '' } : null,
  );
  const [error, setError] = useState<string | null>(null);
  const isBusy = !!submission && (savingId === submission.id || approvingId === submission.id || rejectingId === submission.id);
  if (!submission || !draft) return <section className="admin-page"><button type="button" className="sheet-secondary admin-back" onClick={() => onNavigate({ page: 'submissions' })}>Назад к заявкам</button><p className="empty">Заявка не найдена.</p></section>;
  const updateDraft = (key: keyof SubmissionDraft, value: MetaValue) => setDraft((current) => (current ? { ...current, [key]: value } : current));
  const updateLeadSheet = (leadSheet: string) => setDraft((current) => current ? { ...current, leadSheet, defaultKey: current.defaultKey || inferKeyFromLeadSheet(leadSheet) } : current);
  const save = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    if (!draft.title.trim() || !draft.leadSheet.trim()) return setError('Название и текст обязательны.');
    setError(null);
    onSave(submission.id, draft);
  };
  return (
    <section className="admin-page">
      <button type="button" className="sheet-secondary admin-back" onClick={() => onNavigate({ page: 'submissions' })}>Назад к заявкам</button>
      <div className="admin-page-header"><p className="eyebrow">Заявка #{submission.id}</p><h2>{submission.title}</h2></div>
      {error ? <div className="error">{error}</div> : null}
      <form className="admin-editor-form" onSubmit={save}>
        <SongMetaFields draft={draft} categories={categories} disabled={isBusy} adminKey={adminKey} onChange={updateDraft} />
        <LeadSheetField value={draft.leadSheet} disabled={isBusy} onChange={updateLeadSheet} />
        {submission.sourceSongId && formatAuthors(submission.sourceAuthors) !== formatAuthors(draft.authors) ? (
          <FieldBlock title="Изменение авторов">
            <div className="admin-diff-summary">
              <span>Было: {formatAuthors(submission.sourceAuthors) || 'без автора'}</span>
              <span>Стало: {formatAuthors(draft.authors) || 'без автора'}</span>
            </div>
          </FieldBlock>
        ) : null}
        {submission.sourceSongId && submission.sourceLeadSheet ? (
          <LeadSheetDiff
            sourceTitle={submission.sourceTitle || submission.sourceSongId}
            before={submission.sourceLeadSheet}
            after={draft.leadSheet}
          />
        ) : null}
        <FieldBlock title="Отправитель">
          <div className="submission-grid">
            <label className="submission-field"><span>Имя</span><input value={draft.submitterName} onChange={(event) => updateDraft('submitterName', event.target.value)} disabled={isBusy} /></label>
            <label className="submission-field"><span>Email</span><input type="email" value={draft.submitterEmail} onChange={(event) => updateDraft('submitterEmail', event.target.value)} disabled={isBusy} /></label>
          </div>
          <label className="submission-field"><span>Комментарий</span><textarea value={draft.note} onChange={(event) => updateDraft('note', event.target.value)} rows={3} /></label>
        </FieldBlock>
        <div className="admin-sticky-actions admin-sticky-actions-three">
          <button type="submit" className="sheet-secondary" disabled={isBusy}>{savingId === submission.id ? 'Сохранение...' : 'Сохранить'}</button>
          <button type="button" className="sheet-primary" onClick={() => onApprove(submission.id)} disabled={isBusy}>{approvingId === submission.id ? 'Апрув...' : 'Апрувить'}</button>
          <button type="button" className="sheet-secondary" onClick={() => onReject(submission.id)} disabled={isBusy}>{rejectingId === submission.id ? 'Отклонение...' : 'Отклонить'}</button>
        </div>
      </form>
    </section>
  );
};

const AdminPanel = ({
  route,
  songs,
  categories,
  submissions,
  isSubmissionsLoading,
  savingSubmissionId,
  approvingSubmissionId,
  rejectingSubmissionId,
  savingSongId,
  deletingSongId,
  adminKey,
  onNavigate,
  onRefreshCatalog,
  onSearchSongs,
  onEnsureSongLoaded,
  onRefreshSubmissions,
  onCreateSong,
  onSaveSong,
  onDeleteSong,
  onSaveSubmission,
  onApproveSubmission,
  onRejectSubmission,
  onLogout,
}: Props) => {
  const [query, setQuery] = useState('');
  const [songListFilter, setSongListFilter] = useState<SongListFilter>('all');
  const [backendSongs, setBackendSongs] = useState<SongListItem[]>([]);
  const [isBackendSearchLoading, setIsBackendSearchLoading] = useState(false);
  const [backendSearchError, setBackendSearchError] = useState<string | null>(null);
  const [visibleSongCount, setVisibleSongCount] = useState(ADMIN_SONG_PAGE_SIZE);
  const [scrollY, setScrollY] = useState(0);
  const [scrollReturnY, setScrollReturnY] = useState<number | null>(null);
  const songListScrollY = useRef(0);
  const page = route.page;
  const categoryOptions = useMemo(() => Array.from(new Set([DEFAULT_CATEGORY, ...categories.filter((category) => category.trim().length > 0)])), [categories]);
  const filteredSongs = useMemo(() => {
    const normalized = normalizeSearchText(query);
    return songs.filter((song) => {
      if (songListFilter === 'missing-chords' && songHasChords(song)) return false;
      if (!normalized) return true;
      return matchesSearchQuery(
        [buildSongSearchIndex(song), song.category, ...(song.authors ?? []), song.defaultKey ?? '', String(song.number)].join(' '),
        normalized,
      );
    });
  }, [query, songListFilter, songs]);
  const songListItems = useMemo<AdminSongListItem[]>(() => {
    const seen = new Set<string>();
    const localItems = filteredSongs.map((song) => {
      seen.add(song.id);
      return {
        id: song.id,
        number: song.number,
        title: song.title,
        category: song.category,
        authors: song.authors,
        song,
      };
    });
    if (!query.trim() || songListFilter === 'missing-chords') return localItems;

    const remoteItems = backendSongs.flatMap((song) => {
      if (seen.has(song.id)) return [];
      seen.add(song.id);
      return [song];
    });
    return [...localItems, ...remoteItems];
  }, [backendSongs, filteredSongs, query, songListFilter]);
  const visibleSongItems = useMemo(() => songListItems.slice(0, visibleSongCount), [songListItems, visibleSongCount]);
  const hasMoreSongItems = visibleSongItems.length < songListItems.length;
  const missingChordCount = useMemo(() => songs.filter((song) => !songHasChords(song)).length, [songs]);
  useEffect(() => {
    setVisibleSongCount(ADMIN_SONG_PAGE_SIZE);
  }, [query, songListFilter]);
  useEffect(() => {
    const normalized = query.trim();
    if (!normalized) {
      setBackendSongs([]);
      setBackendSearchError(null);
      setIsBackendSearchLoading(false);
      return undefined;
    }

    let cancelled = false;
    setIsBackendSearchLoading(true);
    const timeout = window.setTimeout(() => {
      onSearchSongs(normalized)
        .then((items) => {
          if (cancelled) return;
          setBackendSongs(items);
          setBackendSearchError(null);
        })
        .catch((err) => {
          if (cancelled) return;
          setBackendSongs([]);
          setBackendSearchError(err instanceof Error ? err.message : 'Не удалось найти песни в БД.');
        })
        .finally(() => {
          if (!cancelled) setIsBackendSearchLoading(false);
        });
    }, 300);

    return () => {
      cancelled = true;
      window.clearTimeout(timeout);
    };
  }, [onSearchSongs, query]);
  useEffect(() => {
    if (page !== 'songs' || !hasMoreSongItems) return undefined;

    const loadMoreNearBottom = () => {
      const root = document.documentElement;
      const remaining = root.scrollHeight - window.scrollY - window.innerHeight;
      if (remaining > 520) return;
      setVisibleSongCount((current) => Math.min(current + ADMIN_SONG_PAGE_SIZE, songListItems.length));
    };

    loadMoreNearBottom();
    window.addEventListener('scroll', loadMoreNearBottom, { passive: true });
    return () => window.removeEventListener('scroll', loadMoreNearBottom);
  }, [hasMoreSongItems, page, songListItems.length]);
  useEffect(() => {
    if (page !== 'songs') {
      setScrollReturnY(null);
      return undefined;
    }
    if (typeof window === 'undefined') return undefined;

    let frameId = 0;
    const syncScrollY = () => {
      if (frameId) return;
      frameId = window.requestAnimationFrame(() => {
        frameId = 0;
        setScrollY(window.scrollY);
      });
    };

    syncScrollY();
    window.addEventListener('scroll', syncScrollY, { passive: true });
    return () => {
      if (frameId) window.cancelAnimationFrame(frameId);
      window.removeEventListener('scroll', syncScrollY);
    };
  }, [page]);
  const toggleSongListScroll = () => {
    if (typeof window === 'undefined') return;
    if (scrollReturnY !== null) {
      const targetY = scrollReturnY;
      setScrollReturnY(null);
      window.scrollTo({ top: targetY, left: 0, behavior: preferredScrollBehavior() });
      return;
    }

    setScrollReturnY(window.scrollY);
    window.scrollTo({ top: 0, left: 0, behavior: preferredScrollBehavior() });
  };
  const openSongEditor = async (songId: string) => {
    songListScrollY.current = typeof window === 'undefined' ? 0 : window.scrollY;
    try {
      await onEnsureSongLoaded(songId);
      setBackendSearchError(null);
      onNavigate({ page: 'song', songId });
    } catch (err) {
      setBackendSearchError(err instanceof Error ? err.message : 'Не удалось загрузить песню из БД.');
    }
  };
  const backToSongs = () => {
    onNavigate({ page: 'songs' });
    if (typeof window !== 'undefined') window.requestAnimationFrame(() => window.scrollTo({ top: songListScrollY.current, left: 0, behavior: 'auto' }));
  };
  const activeSong = page === 'song' ? songs.find((song) => song.id === route.songId) : undefined;
  const activeSubmission = page === 'submission' ? submissions.find((submission) => submission.id === route.submissionId) : undefined;
  const canShowScrollReturnButton = page === 'songs' && (scrollY > 420 || scrollReturnY !== null);

  return (
    <div className="admin-shell">
      <AdminNav active={page} onNavigate={onNavigate} />
      {page === 'home' ? <section className="admin-page"><div className="admin-page-header"><p className="eyebrow">Admin</p><h2>Управление каталогом</h2><p>Разделы вынесены на отдельные страницы. Песни редактируются одним блоком текста с аккордами.</p></div><div className="admin-card-grid"><button type="button" className="admin-action-card" onClick={() => onNavigate({ page: 'songs' })}><strong>Песни</strong><span>{songs.length} в каталоге</span></button><button type="button" className="admin-action-card" onClick={() => onNavigate({ page: 'new' })}><strong>Добавить песню</strong><span>Один блок как на Holychords</span></button><button type="button" className="admin-action-card" onClick={() => onNavigate({ page: 'submissions' })}><strong>Заявки</strong><span>{submissions.length} pending</span></button></div><div className="admin-inline-actions"><button type="button" className="sheet-secondary" onClick={onRefreshCatalog}>Обновить из БД</button><button type="button" className="sheet-secondary" onClick={onLogout}>Выйти</button></div></section> : null}
      {page === 'songs' ? (
        <section className="admin-page">
          <div className="admin-page-header">
            <p className="eyebrow">Каталог</p>
            <h2>Песни</h2>
          </div>
          <div className="admin-search-sticky">
            <label className="submission-field admin-search-field">
              <span>Поиск</span>
              <div className="search-field">
                <input
                  value={query}
                  onChange={(event) => setQuery(event.target.value)}
                  placeholder="Название, текст, автор, категория, номер"
                  className="search"
                  aria-label="Поиск песни в админке"
                />
                {query.trim().length > 0 ? (
                  <button type="button" className="search-clear" onClick={() => setQuery('')} aria-label="Очистить поиск">
                    ×
                  </button>
                ) : null}
              </div>
            </label>
            {isBackendSearchLoading ? <p className="submission-help">Ищу в БД...</p> : null}
            {backendSearchError ? <div className="error">{backendSearchError}</div> : null}
            <div className="admin-filter-row" role="group" aria-label="Фильтр песен">
              <button
                type="button"
                className={songListFilter === 'all' ? 'is-active' : ''}
                onClick={() => setSongListFilter('all')}
                aria-pressed={songListFilter === 'all'}
              >
                Все песни <span>{songs.length}</span>
              </button>
              <button
                type="button"
                className={songListFilter === 'missing-chords' ? 'is-active' : ''}
                onClick={() => setSongListFilter('missing-chords')}
                aria-pressed={songListFilter === 'missing-chords'}
              >
                Без аккордов <span>{missingChordCount}</span>
              </button>
            </div>
          </div>
          <div className="admin-inline-actions">
            <button type="button" className="sheet-secondary" onClick={onRefreshCatalog}>Обновить из БД</button>
            <button type="button" className="sheet-primary" onClick={() => onNavigate({ page: 'new' })}>Добавить песню</button>
          </div>
          <div className="admin-list">
            {songListItems.length === 0 && !isBackendSearchLoading ? <p className="empty">По текущему фильтру песен нет.</p> : null}
            {visibleSongItems.map((item) => {
              const song = item.song;
              return (
                <article key={item.id} className="admin-list-card">
                  <button type="button" className="admin-list-main" onClick={() => void openSongEditor(item.id)}>
                    <strong>{item.title}</strong>
                    <small>
                      №{item.number} · {item.category}
                      {item.authors?.length ? ` · ${formatAuthors(item.authors)}` : ''}
                      {song?.playback ? ` · ${song.playback.bpm} BPM` : ''}
                      {' · '}
                      {song ? (songHasChords(song) ? 'есть аккорды' : 'нет аккордов') : 'из БД'}
                    </small>
                  </button>
                  <b className="admin-key-badge">{song?.defaultKey || '-'}</b>
                </article>
              );
            })}
            {hasMoreSongItems ? <p className="submission-help">Прокрутите ниже, чтобы загрузить ещё песни.</p> : null}
          </div>
          {canShowScrollReturnButton ? (
            <ScrollReturnButton isReturning={scrollReturnY !== null} onClick={toggleSongListScroll} />
          ) : null}
        </section>
      ) : null}
      {page === 'song' ? <AdminSongPage song={activeSong} categories={categoryOptions} savingId={savingSongId} deletingId={deletingSongId} adminKey={adminKey} onSave={onSaveSong} onDelete={onDeleteSong} onBackToSongs={backToSongs} /> : null}
      {page === 'new' ? <AdminNewSongPage adminKey={adminKey} categories={categoryOptions} onCreateSong={onCreateSong} /> : null}
      {page === 'submissions' ? <AdminSubmissionsPage submissions={submissions} isLoading={isSubmissionsLoading} busyIds={[savingSubmissionId, approvingSubmissionId, rejectingSubmissionId]} onNavigate={onNavigate} onRefresh={onRefreshSubmissions} onApprove={onApproveSubmission} onReject={onRejectSubmission} /> : null}
      {page === 'submission' ? <AdminSubmissionPage submission={activeSubmission} categories={categoryOptions} savingId={savingSubmissionId} approvingId={approvingSubmissionId} rejectingId={rejectingSubmissionId} adminKey={adminKey} onSave={onSaveSubmission} onApprove={onApproveSubmission} onReject={onRejectSubmission} onNavigate={onNavigate} /> : null}
    </div>
  );
};

export default AdminPanel;

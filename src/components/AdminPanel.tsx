import { FormEvent, ReactNode, useEffect, useMemo, useRef, useState } from 'react';
import {
  AdminSongSectionUpdatePayload,
  AdminSongUpdatePayload,
  SongSubmission,
  SongSubmissionPayload,
  createAdminSong,
} from '../lib/catalogApi';
import { parseSongKey } from '../lib/chords';
import { Song, SongSection } from '../types/song';

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
  adminKey: string;
  onNavigate: (route: AdminRoute) => void;
  onRefreshCatalog: () => void;
  onRefreshSubmissions: () => void;
  onCreateSong: (message: string) => void | Promise<void>;
  onSaveSong: (songId: string, payload: AdminSongUpdatePayload) => void;
  onSaveSubmission: (submissionId: number, payload: SongSubmissionPayload) => void;
  onApproveSubmission: (submissionId: number) => void;
  onRejectSubmission: (submissionId: number) => void;
  onLogout: () => void;
};

type SongDraft = AdminSongUpdatePayload;
type SubmissionDraft = SongSubmissionPayload;
type MetaKey = 'title' | 'category' | 'defaultKey' | 'bpm' | 'beatsPerLine' | 'introBeats';
type MetaDraft = Pick<SongDraft, MetaKey>;
type SongListFilter = 'all' | 'missing-chords';

const DEFAULT_CATEGORY = 'Общее';
const DEFAULT_BPM = 72;
const DEFAULT_BEATS_PER_LINE = 4;
const DEFAULT_INTRO_BEATS = 4;

const emptySubmissionDraft = (): SubmissionDraft => ({
  title: '',
  category: DEFAULT_CATEGORY,
  defaultKey: '',
  lyrics: '',
  chords: '',
  bpm: DEFAULT_BPM,
  beatsPerLine: DEFAULT_BEATS_PER_LINE,
  introBeats: DEFAULT_INTRO_BEATS,
  submitterName: '',
  submitterEmail: '',
  note: '',
});

const sectionText = (section: SongSection) => section.rows.join('\n');

const sectionChords = (section: SongSection) =>
  section.chords.map((line) => line.join(' ')).join('\n');

const inferKeyFromSections = (sections: AdminSongSectionUpdatePayload[]): string => {
  for (const section of sections) {
    for (const line of section.chords.split('\n')) {
      for (const token of line.trim().split(/\s+/)) {
        const key = parseSongKey(token.replace(/[|,]/g, ''));
        if (key) return key.label;
      }
    }
  }

  return '';
};

const songHasChords = (song: Song): boolean => {
  const sections = [...song.verses, song.chorus, song.bridge].filter(Boolean) as SongSection[];
  return sections.some((section) => section.chords.some((line) => line.some((chord) => chord.trim().length > 0)));
};

const buildSongSections = (song: Song): AdminSongSectionUpdatePayload[] => [
  ...song.verses.map((section, index) => ({
    sectionType: 'verse' as const,
    title: `Куплет ${index + 1}`,
    lyrics: sectionText(section),
    chords: sectionChords(section),
  })),
  ...(song.chorus
    ? [
        {
          sectionType: 'chorus' as const,
          title: 'Припев',
          lyrics: sectionText(song.chorus),
          chords: sectionChords(song.chorus),
        },
      ]
    : []),
  ...(song.bridge
    ? [
        {
          sectionType: 'bridge' as const,
          title: 'Бридж',
          lyrics: sectionText(song.bridge),
          chords: sectionChords(song.bridge),
        },
      ]
    : []),
];

const buildSongDraft = (song: Song): SongDraft => {
  const sections = buildSongSections(song);
  return {
    title: song.title,
    category: song.category || DEFAULT_CATEGORY,
    defaultKey: song.defaultKey || inferKeyFromSections(sections),
    bpm: song.playback?.bpm ?? DEFAULT_BPM,
    beatsPerLine: song.playback?.beatsPerLine ?? DEFAULT_BEATS_PER_LINE,
    introBeats: song.playback?.introBeats ?? DEFAULT_INTRO_BEATS,
    sections,
  };
};

const sectionLabel = (section: AdminSongSectionUpdatePayload) => {
  if (section.title.trim()) return section.title.trim();
  if (section.sectionType === 'chorus') return 'Припев';
  if (section.sectionType === 'bridge') return 'Бридж';
  return 'Куплет';
};

const parseHeader = (line: string): Pick<AdminSongSectionUpdatePayload, 'sectionType' | 'title'> | null => {
  const value = line.trim().replace(/^\[(.*)\]$/, '$1').trim();
  if (!value) return null;
  const lower = value.toLowerCase();
  if (/^(куплет|verse)(\s+\d+)?$/.test(lower)) return { sectionType: 'verse', title: value };
  if (/^(припев|chorus)$/.test(lower)) return { sectionType: 'chorus', title: value };
  if (/^(бридж|мост|bridge)$/.test(lower)) return { sectionType: 'bridge', title: value };
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

const parseLeadSheet = (text: string): AdminSongSectionUpdatePayload[] => {
  const sections: Array<AdminSongSectionUpdatePayload & { lyricLines: string[]; chordLines: string[] }> = [];
  let pendingChord = '';

  const ensureSection = (header?: Pick<AdminSongSectionUpdatePayload, 'sectionType' | 'title'>) => {
    if (header || sections.length === 0) {
      const verseCount = sections.filter((section) => section.sectionType === 'verse').length + 1;
      sections.push({
        sectionType: header?.sectionType ?? 'verse',
        title: header?.title ?? `Куплет ${verseCount}`,
        lyrics: '',
        chords: '',
        lyricLines: [],
        chordLines: [],
      });
    }
    return sections[sections.length - 1];
  };

  text.split('\n').forEach((rawLine) => {
    const line = rawLine.trimEnd();
    const header = parseHeader(line);
    if (header) {
      pendingChord = '';
      ensureSection(header);
      return;
    }
    if (!line.trim()) return;
    if (isChordLine(line)) {
      pendingChord = line.trim();
      return;
    }

    const section = ensureSection();
    section.lyricLines.push(line);
    section.chordLines.push(pendingChord);
    pendingChord = '';
  });

  return sections
    .map(({ lyricLines, chordLines, ...section }) => ({
      ...section,
      lyrics: lyricLines.join('\n'),
      chords: chordLines.join('\n'),
    }))
    .filter((section) => section.lyrics.trim().length > 0);
};

const sectionsToFlatPayload = (sections: AdminSongSectionUpdatePayload[]) => ({
  lyrics: sections.map((section) => `[${sectionLabel(section)}]\n${section.lyrics}`).join('\n\n'),
  chords: sections.map((section) => `[${sectionLabel(section)}]\n${section.chords}`).join('\n\n'),
});

const sectionsToLeadSheet = (sections: AdminSongSectionUpdatePayload[]) =>
  sections
    .map((section) => {
      const lyricLines = section.lyrics.split('\n');
      const chordLines = section.chords.split('\n');
      const rows = lyricLines.flatMap((line, index) => {
        const chordLine = chordLines[index]?.trim();
        return chordLine ? [chordLine, line] : [line];
      });
      return [`[${sectionLabel(section)}]`, ...rows].join('\n');
    })
    .join('\n\n');

const formatSubmissionDate = (value: string) => {
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return 'дата неизвестна';
  return new Intl.DateTimeFormat('ru', {
    day: '2-digit',
    month: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
  }).format(date);
};

const AdminNav = ({ active, onNavigate }: { active: AdminRoute['page']; onNavigate: Props['onNavigate'] }) => (
  <nav className="admin-nav" aria-label="Админка">
    <button type="button" className={active === 'home' ? 'is-active' : ''} onClick={() => onNavigate({ page: 'home' })}>
      Обзор
    </button>
    <button type="button" className={active === 'songs' || active === 'song' ? 'is-active' : ''} onClick={() => onNavigate({ page: 'songs' })}>
      Песни
    </button>
    <button type="button" className={active === 'new' ? 'is-active' : ''} onClick={() => onNavigate({ page: 'new' })}>
      Добавить
    </button>
    <button type="button" className={active === 'submissions' || active === 'submission' ? 'is-active' : ''} onClick={() => onNavigate({ page: 'submissions' })}>
      Заявки
    </button>
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

const QuickPaste = ({ onApply }: { onApply: (sections: AdminSongSectionUpdatePayload[]) => void }) => {
  const [text, setText] = useState('');
  const [error, setError] = useState<string | null>(null);

  const apply = () => {
    const parsed = parseLeadSheet(text);
    if (parsed.length === 0) {
      setError('Не удалось найти строки текста. Добавьте слова песни и, если нужно, строки аккордов над ними.');
      return;
    }
    setError(null);
    onApply(parsed);
  };

  return (
    <FieldBlock
      title="Быстрая вставка"
      hint="Можно вставить песню сразу с аккордами. Заголовки: [Куплет 1], [Припев], [Бридж]. Строка аккордов ставится над строкой текста."
    >
      {error ? <div className="error">{error}</div> : null}
      <label className="submission-field">
        <span>Текст с аккордами</span>
        <textarea
          className="admin-large-textarea"
          value={text}
          onChange={(event) => setText(event.target.value)}
          placeholder={'[Куплет 1]\nG      D\nБог твой Царь...\n\n[Припев]\nEm     C\nСлава Тебе...'}
          rows={10}
        />
      </label>
      <div className="admin-inline-actions">
        <button type="button" className="sheet-secondary" onClick={apply}>
          Разобрать в секции
        </button>
        <button type="button" className="sheet-secondary" onClick={() => setText('')}>
          Очистить вставку
        </button>
      </div>
    </FieldBlock>
  );
};

const LeadSheetEditor = ({
  sections,
  disabled,
  onApply,
}: {
  sections: AdminSongSectionUpdatePayload[];
  disabled: boolean;
  onApply: (sections: AdminSongSectionUpdatePayload[]) => void;
}) => {
  const [text, setText] = useState(() => sectionsToLeadSheet(sections));
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    setText(sectionsToLeadSheet(sections));
  }, [sections]);

  const apply = () => {
    const parsed = parseLeadSheet(text);
    if (parsed.length === 0) {
      setError('Не удалось разобрать блок. Проверьте заголовки секций и строки текста.');
      return;
    }
    setError(null);
    onApply(parsed);
  };

  return (
    <FieldBlock
      title="Единый блок Holychords"
      hint="Основной рабочий формат: заголовки секций, строка аккордов над строкой текста. После применения ниже обновятся секции."
    >
      {error ? <div className="error">{error}</div> : null}
      <label className="submission-field">
        <span>Полный текст с аккордами</span>
        <textarea
          className="admin-large-textarea"
          value={text}
          onChange={(event) => setText(event.target.value)}
          disabled={disabled}
          rows={16}
        />
      </label>
      <div className="admin-inline-actions">
        <button type="button" className="sheet-primary" onClick={apply} disabled={disabled}>
          Применить к секциям
        </button>
      </div>
    </FieldBlock>
  );
};

const SongSectionsEditor = ({
  sections,
  disabled,
  onChange,
}: {
  sections: AdminSongSectionUpdatePayload[];
  disabled: boolean;
  onChange: (sections: AdminSongSectionUpdatePayload[]) => void;
}) => {
  const updateSection = (index: number, key: keyof AdminSongSectionUpdatePayload, value: string) => {
    onChange(sections.map((section, sectionIndex) => (sectionIndex === index ? { ...section, [key]: value } : section)));
  };

  const addSection = (sectionType: AdminSongSectionUpdatePayload['sectionType']) => {
    const verseNumber = sections.filter((section) => section.sectionType === 'verse').length + 1;
    const title = sectionType === 'verse' ? `Куплет ${verseNumber}` : sectionType === 'chorus' ? 'Припев' : 'Бридж';
    onChange([...sections, { sectionType, title, lyrics: '', chords: '' }]);
  };

  const moveSection = (index: number, direction: -1 | 1) => {
    const nextIndex = index + direction;
    if (nextIndex < 0 || nextIndex >= sections.length) return;
    const nextSections = [...sections];
    [nextSections[index], nextSections[nextIndex]] = [nextSections[nextIndex], nextSections[index]];
    onChange(nextSections);
  };

  return (
    <FieldBlock title="Секции" hint="Порядок секций здесь соответствует порядку отображения в песне. Аккорды можно редактировать отдельно после быстрой вставки.">
      <div className="admin-section-stack">
        {sections.map((section, index) => (
          <article key={`${section.sectionType}-${index}`} className="admin-section-card">
            <div className="submission-grid">
              <label className="submission-field">
                <span>Тип</span>
                <select
                  value={section.sectionType}
                  onChange={(event) =>
                    updateSection(index, 'sectionType', event.target.value as AdminSongSectionUpdatePayload['sectionType'])
                  }
                >
                  <option value="verse">Куплет</option>
                  <option value="chorus">Припев</option>
                  <option value="bridge">Бридж</option>
                </select>
              </label>
              <label className="submission-field">
                <span>Название</span>
                <input value={section.title} onChange={(event) => updateSection(index, 'title', event.target.value)} />
              </label>
            </div>
            <label className="submission-field">
              <span>Слова</span>
              <textarea value={section.lyrics} onChange={(event) => updateSection(index, 'lyrics', event.target.value)} rows={7} />
            </label>
            <label className="submission-field">
              <span>Аккорды</span>
              <textarea value={section.chords} onChange={(event) => updateSection(index, 'chords', event.target.value)} rows={4} />
            </label>
            <div className="admin-inline-actions">
              <button type="button" className="sheet-secondary" onClick={() => moveSection(index, -1)} disabled={disabled || index === 0}>
                Выше
              </button>
              <button type="button" className="sheet-secondary" onClick={() => moveSection(index, 1)} disabled={disabled || index === sections.length - 1}>
                Ниже
              </button>
              <button
                type="button"
                className="sheet-secondary"
                onClick={() => onChange(sections.filter((_, sectionIndex) => sectionIndex !== index))}
                disabled={disabled || sections.length <= 1}
              >
                Удалить
              </button>
            </div>
          </article>
        ))}
      </div>
      <div className="admin-inline-actions">
        <button type="button" className="sheet-secondary" onClick={() => addSection('verse')} disabled={disabled}>
          Добавить куплет
        </button>
        <button type="button" className="sheet-secondary" onClick={() => addSection('chorus')} disabled={disabled}>
          Добавить припев
        </button>
        <button type="button" className="sheet-secondary" onClick={() => addSection('bridge')} disabled={disabled}>
          Добавить бридж
        </button>
      </div>
    </FieldBlock>
  );
};

const SongMetaFields = ({
  draft,
  categories,
  disabled,
  onChange,
}: {
  draft: MetaDraft;
  categories: string[];
  disabled: boolean;
  onChange: (key: MetaKey, value: string | number) => void;
}) => (
  <>
    <FieldBlock title="Основное">
      <label className="submission-field">
        <span>Название</span>
        <input value={draft.title} onChange={(event) => onChange('title', event.target.value)} disabled={disabled} />
      </label>
      <div className="submission-grid">
        <label className="submission-field">
          <span>Категория</span>
          <select value={draft.category} onChange={(event) => onChange('category', event.target.value)} disabled={disabled}>
            {categories.map((category) => (
              <option key={category} value={category}>
                {category}
              </option>
            ))}
          </select>
        </label>
        <label className="submission-field">
          <span>Тональность</span>
          <input value={draft.defaultKey} onChange={(event) => onChange('defaultKey', event.target.value)} disabled={disabled} placeholder="G, Am..." />
        </label>
      </div>
    </FieldBlock>
    <FieldBlock title="Ритм">
      <div className="submission-grid submission-grid-three">
        <label className="submission-field">
          <span>BPM</span>
          <input type="number" min={40} max={220} value={draft.bpm} onChange={(event) => onChange('bpm', Number(event.target.value))} disabled={disabled} />
        </label>
        <label className="submission-field">
          <span>Долей на строку</span>
          <input type="number" min={1} max={16} value={draft.beatsPerLine} onChange={(event) => onChange('beatsPerLine', Number(event.target.value))} disabled={disabled} />
        </label>
        <label className="submission-field">
          <span>Вступление</span>
          <input type="number" min={0} max={64} value={draft.introBeats} onChange={(event) => onChange('introBeats', Number(event.target.value))} disabled={disabled} />
        </label>
      </div>
    </FieldBlock>
  </>
);

const AdminSongPage = ({ song, categories, savingId, onSave, onBackToSongs }: {
  song: Song | undefined;
  categories: string[];
  savingId: string | null;
  onSave: Props['onSaveSong'];
  onBackToSongs: () => void;
}) => {
  const [draft, setDraft] = useState<SongDraft | null>(() => (song ? buildSongDraft(song) : null));
  const [error, setError] = useState<string | null>(null);
  const isSaving = !!song && savingId === song.id;

  if (!song || !draft) {
    return (
      <section className="admin-page">
        <button type="button" className="sheet-secondary admin-back" onClick={onBackToSongs}>
          Назад к песням
        </button>
        <p className="empty">Песня не найдена.</p>
      </section>
    );
  }

  const updateDraft = (key: keyof SongDraft, value: string | number) => {
    setDraft((current) => (current ? { ...current, [key]: value } : current));
  };
  const updateSections = (sections: AdminSongSectionUpdatePayload[]) => {
    setDraft((current) => {
      if (!current) return current;
      const inferredKey = inferKeyFromSections(sections);
      return {
        ...current,
        sections,
        defaultKey: current.defaultKey || inferredKey,
      };
    });
  };
  const inferDefaultKey = () => {
    const inferredKey = inferKeyFromSections(draft.sections ?? []);
    if (inferredKey) {
      updateDraft('defaultKey', inferredKey);
      return;
    }
    setError('Не удалось определить тональность: в секциях нет распознанных аккордов.');
  };

  const save = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    if (!draft.title.trim()) {
      setError('Название обязательно.');
      return;
    }
    if (!draft.sections?.some((section) => section.lyrics.trim())) {
      setError('Нужна хотя бы одна секция со словами.');
      return;
    }
    setError(null);
    onSave(song.id, draft);
  };

  return (
    <section className="admin-page">
      <button type="button" className="sheet-secondary admin-back" onClick={onBackToSongs}>
        Назад к песням
      </button>
      <div className="admin-page-header">
        <p className="eyebrow">Песня #{song.number}</p>
        <h2>{song.title}</h2>
      </div>
      {error ? <div className="error">{error}</div> : null}
      <form className="admin-editor-form" onSubmit={save}>
        <SongMetaFields draft={draft} categories={categories} disabled={isSaving} onChange={updateDraft} />
        <div className="admin-inline-actions">
          <button type="button" className="sheet-secondary" onClick={inferDefaultKey} disabled={isSaving}>
            Определить тональность по аккордам
          </button>
        </div>
        <LeadSheetEditor sections={draft.sections ?? []} disabled={isSaving} onApply={updateSections} />
        <SongSectionsEditor
          sections={draft.sections ?? []}
          disabled={isSaving}
          onChange={updateSections}
        />
        <div className="admin-sticky-actions">
          <button type="submit" className="sheet-primary" disabled={isSaving}>
            {isSaving ? 'Сохранение...' : 'Сохранить песню'}
          </button>
        </div>
      </form>
    </section>
  );
};

const AdminNewSongPage = ({ adminKey, categories, onCreateSong }: {
  adminKey: string;
  categories: string[];
  onCreateSong: Props['onCreateSong'];
}) => {
  const [draft, setDraft] = useState<SubmissionDraft>(() => emptySubmissionDraft());
  const [error, setError] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const updateDraft = (key: keyof SubmissionDraft, value: string | number) => {
    setDraft((current) => ({ ...current, [key]: value }));
  };

  const submit = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    if (!draft.title.trim() || !draft.lyrics.trim()) {
      setError('Нужно заполнить название и текст песни.');
      return;
    }
    if (!adminKey.trim()) {
      setError('Admin key пустой. Войдите в админку заново.');
      return;
    }

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
      <div className="admin-page-header">
        <p className="eyebrow">Новая песня</p>
        <h2>Добавить в каталог</h2>
      </div>
      {error ? <div className="error">{error}</div> : null}
      <form className="admin-editor-form" onSubmit={submit}>
        <SongMetaFields draft={draft} categories={categories} disabled={isSubmitting} onChange={updateDraft} />
        <QuickPaste
          onApply={(sections) => {
            const flat = sectionsToFlatPayload(sections);
            setDraft((current) => ({ ...current, ...flat }));
          }}
        />
        <FieldBlock title="Текст и аккорды" hint="Можно заполнить вручную или после быстрой вставки поправить результат.">
          <label className="submission-field">
            <span>Текст</span>
            <textarea value={draft.lyrics} onChange={(event) => updateDraft('lyrics', event.target.value)} rows={10} />
          </label>
          <label className="submission-field">
            <span>Аккорды</span>
            <textarea value={draft.chords} onChange={(event) => updateDraft('chords', event.target.value)} rows={6} />
          </label>
        </FieldBlock>
        <FieldBlock title="Комментарий">
          <label className="submission-field">
            <span>Комментарий</span>
            <textarea value={draft.note} onChange={(event) => updateDraft('note', event.target.value)} rows={3} />
          </label>
        </FieldBlock>
        <div className="admin-sticky-actions">
          <button type="submit" className="sheet-primary" disabled={isSubmitting}>
            {isSubmitting ? 'Сохранение...' : 'Добавить песню'}
          </button>
        </div>
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
    <div className="admin-page-header">
      <p className="eyebrow">Pending</p>
      <h2>Заявки</h2>
    </div>
    <div className="admin-inline-actions">
      <button type="button" className="sheet-secondary" onClick={onRefresh} disabled={isLoading}>
        {isLoading ? 'Загрузка...' : 'Обновить'}
      </button>
    </div>
    <div className="admin-list">
      {submissions.length === 0 ? <p className="empty">Нет pending заявок.</p> : null}
      {submissions.map((submission) => {
        const isBusy = busyIds.includes(submission.id);
        return (
          <article key={submission.id} className="admin-list-card">
            <button type="button" className="admin-list-main" onClick={() => onNavigate({ page: 'submission', submissionId: submission.id })}>
              <strong>{submission.title}</strong>
              <small>
                #{submission.id} · {submission.category} · {formatSubmissionDate(submission.createdAt)}
              </small>
            </button>
            <div className="admin-list-actions">
              <button type="button" className="sheet-primary" onClick={() => onApprove(submission.id)} disabled={isBusy}>
                Апрувить
              </button>
              <button type="button" className="sheet-secondary" onClick={() => onReject(submission.id)} disabled={isBusy}>
                Отклонить
              </button>
            </div>
          </article>
        );
      })}
    </div>
  </section>
);

const AdminSubmissionPage = ({ submission, categories, savingId, approvingId, rejectingId, onSave, onApprove, onReject, onNavigate }: {
  submission: SongSubmission | undefined;
  categories: string[];
  savingId: number | null;
  approvingId: number | null;
  rejectingId: number | null;
  onSave: Props['onSaveSubmission'];
  onApprove: Props['onApproveSubmission'];
  onReject: Props['onRejectSubmission'];
  onNavigate: Props['onNavigate'];
}) => {
  const [draft, setDraft] = useState<SubmissionDraft | null>(() => (submission ? { ...submission } : null));
  const [error, setError] = useState<string | null>(null);
  const isBusy = !!submission && (savingId === submission.id || approvingId === submission.id || rejectingId === submission.id);

  if (!submission || !draft) {
    return (
      <section className="admin-page">
        <button type="button" className="sheet-secondary admin-back" onClick={() => onNavigate({ page: 'submissions' })}>
          Назад к заявкам
        </button>
        <p className="empty">Заявка не найдена.</p>
      </section>
    );
  }

  const updateDraft = (key: keyof SubmissionDraft, value: string | number) => {
    setDraft((current) => (current ? { ...current, [key]: value } : current));
  };

  const save = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    if (!draft.title.trim() || !draft.lyrics.trim()) {
      setError('Название и текст обязательны.');
      return;
    }
    setError(null);
    onSave(submission.id, draft);
  };

  return (
    <section className="admin-page">
      <button type="button" className="sheet-secondary admin-back" onClick={() => onNavigate({ page: 'submissions' })}>
        Назад к заявкам
      </button>
      <div className="admin-page-header">
        <p className="eyebrow">Заявка #{submission.id}</p>
        <h2>{submission.title}</h2>
      </div>
      {error ? <div className="error">{error}</div> : null}
      <form className="admin-editor-form" onSubmit={save}>
        <SongMetaFields draft={draft} categories={categories} disabled={isBusy} onChange={updateDraft} />
        <QuickPaste
          onApply={(sections) => {
            const flat = sectionsToFlatPayload(sections);
            setDraft((current) => (current ? { ...current, ...flat } : current));
          }}
        />
        <FieldBlock title="Текст и аккорды">
          <label className="submission-field">
            <span>Текст</span>
            <textarea value={draft.lyrics} onChange={(event) => updateDraft('lyrics', event.target.value)} rows={10} />
          </label>
          <label className="submission-field">
            <span>Аккорды</span>
            <textarea value={draft.chords} onChange={(event) => updateDraft('chords', event.target.value)} rows={6} />
          </label>
        </FieldBlock>
        <FieldBlock title="Отправитель">
          <div className="submission-grid">
            <label className="submission-field">
              <span>Имя</span>
              <input value={draft.submitterName} onChange={(event) => updateDraft('submitterName', event.target.value)} disabled={isBusy} />
            </label>
            <label className="submission-field">
              <span>Email</span>
              <input type="email" value={draft.submitterEmail} onChange={(event) => updateDraft('submitterEmail', event.target.value)} disabled={isBusy} />
            </label>
          </div>
          <label className="submission-field">
            <span>Комментарий</span>
            <textarea value={draft.note} onChange={(event) => updateDraft('note', event.target.value)} rows={3} />
          </label>
        </FieldBlock>
        <div className="admin-sticky-actions admin-sticky-actions-three">
          <button type="submit" className="sheet-secondary" disabled={isBusy}>
            {savingId === submission.id ? 'Сохранение...' : 'Сохранить'}
          </button>
          <button type="button" className="sheet-primary" onClick={() => onApprove(submission.id)} disabled={isBusy}>
            {approvingId === submission.id ? 'Апрув...' : 'Апрувить'}
          </button>
          <button type="button" className="sheet-secondary" onClick={() => onReject(submission.id)} disabled={isBusy}>
            {rejectingId === submission.id ? 'Отклонение...' : 'Отклонить'}
          </button>
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
  adminKey,
  onNavigate,
  onRefreshCatalog,
  onRefreshSubmissions,
  onCreateSong,
  onSaveSong,
  onSaveSubmission,
  onApproveSubmission,
  onRejectSubmission,
  onLogout,
}: Props) => {
  const [query, setQuery] = useState('');
  const [songListFilter, setSongListFilter] = useState<SongListFilter>('all');
  const songListScrollY = useRef(0);
  const categoryOptions = useMemo(() => {
    const unique = new Set([DEFAULT_CATEGORY, ...categories.filter((category) => category.trim().length > 0)]);
    return Array.from(unique);
  }, [categories]);
  const filteredSongs = useMemo(() => {
    const normalized = query.trim().toLowerCase();
    return songs.filter((song) => {
      if (songListFilter === 'missing-chords' && songHasChords(song)) return false;
      if (!normalized) return true;
      return [song.title, song.category, song.defaultKey ?? '', String(song.number)].join(' ').toLowerCase().includes(normalized);
    });
  }, [query, songListFilter, songs]);
  const missingChordCount = useMemo(() => songs.filter((song) => !songHasChords(song)).length, [songs]);
  const openSongEditor = (songId: string) => {
    songListScrollY.current = typeof window === 'undefined' ? 0 : window.scrollY;
    onNavigate({ page: 'song', songId });
  };
  const backToSongs = () => {
    onNavigate({ page: 'songs' });
    if (typeof window !== 'undefined') {
      window.requestAnimationFrame(() => window.scrollTo({ top: songListScrollY.current, left: 0, behavior: 'auto' }));
    }
  };

  const page = route.page;
  const activeSong = page === 'song' ? songs.find((song) => song.id === route.songId) : undefined;
  const activeSubmission = page === 'submission' ? submissions.find((submission) => submission.id === route.submissionId) : undefined;

  return (
    <div className="admin-shell">
      <AdminNav active={page} onNavigate={onNavigate} />

      {page === 'home' ? (
        <section className="admin-page">
          <div className="admin-page-header">
            <p className="eyebrow">Admin</p>
            <h2>Управление каталогом</h2>
            <p>Разделы вынесены на отдельные страницы. Обычный сборник здесь не отображается.</p>
          </div>
          <div className="admin-card-grid">
            <button type="button" className="admin-action-card" onClick={() => onNavigate({ page: 'songs' })}>
              <strong>Песни</strong>
              <span>{songs.length} в каталоге</span>
            </button>
            <button type="button" className="admin-action-card" onClick={() => onNavigate({ page: 'new' })}>
              <strong>Добавить песню</strong>
              <span>Отдельная страница с быстрой вставкой</span>
            </button>
            <button type="button" className="admin-action-card" onClick={() => onNavigate({ page: 'submissions' })}>
              <strong>Заявки</strong>
              <span>{submissions.length} pending</span>
            </button>
          </div>
          <div className="admin-inline-actions">
            <button type="button" className="sheet-secondary" onClick={onRefreshCatalog}>
              Обновить из БД
            </button>
            <button type="button" className="sheet-secondary" onClick={onLogout}>
              Выйти
            </button>
          </div>
        </section>
      ) : null}

      {page === 'songs' ? (
        <section className="admin-page">
          <div className="admin-page-header">
            <p className="eyebrow">Каталог</p>
            <h2>Песни</h2>
          </div>
          <label className="submission-field">
            <span>Поиск</span>
            <input value={query} onChange={(event) => setQuery(event.target.value)} placeholder="Название, категория, номер" />
          </label>
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
          <div className="admin-inline-actions">
            <button type="button" className="sheet-secondary" onClick={onRefreshCatalog}>
              Обновить из БД
            </button>
            <button type="button" className="sheet-primary" onClick={() => onNavigate({ page: 'new' })}>
              Добавить песню
            </button>
          </div>
          <div className="admin-list">
            {filteredSongs.length === 0 ? <p className="empty">По текущему фильтру песен нет.</p> : null}
            {filteredSongs.slice(0, 180).map((song) => (
              <article key={song.id} className="admin-list-card">
                <button type="button" className="admin-list-main" onClick={() => openSongEditor(song.id)}>
                  <strong>{song.title}</strong>
                  <small>
                    №{song.number} · {song.category}
                    {song.playback ? ` · ${song.playback.bpm} BPM` : ''} · {songHasChords(song) ? 'есть аккорды' : 'нет аккордов'}
                  </small>
                </button>
                <b className="admin-key-badge">{song.defaultKey || '-'}</b>
              </article>
            ))}
          </div>
        </section>
      ) : null}

      {page === 'song' ? (
        <AdminSongPage song={activeSong} categories={categoryOptions} savingId={savingSongId} onSave={onSaveSong} onBackToSongs={backToSongs} />
      ) : null}

      {page === 'new' ? <AdminNewSongPage adminKey={adminKey} categories={categoryOptions} onCreateSong={onCreateSong} /> : null}

      {page === 'submissions' ? (
        <AdminSubmissionsPage
          submissions={submissions}
          isLoading={isSubmissionsLoading}
          busyIds={[savingSubmissionId, approvingSubmissionId, rejectingSubmissionId]}
          onNavigate={onNavigate}
          onRefresh={onRefreshSubmissions}
          onApprove={onApproveSubmission}
          onReject={onRejectSubmission}
        />
      ) : null}

      {page === 'submission' ? (
        <AdminSubmissionPage
          submission={activeSubmission}
          categories={categoryOptions}
          savingId={savingSubmissionId}
          approvingId={approvingSubmissionId}
          rejectingId={rejectingSubmissionId}
          onSave={onSaveSubmission}
          onApprove={onApproveSubmission}
          onReject={onRejectSubmission}
          onNavigate={onNavigate}
        />
      ) : null}
    </div>
  );
};

export default AdminPanel;

import { FormEvent, useMemo, useState } from 'react';
import { AdminSongSectionUpdatePayload, AdminSongUpdatePayload } from '../lib/catalogApi';
import { Song, SongSection } from '../types/song';

type Props = {
  songs: Song[];
  categories: string[];
  savingId: string | null;
  onRefresh: () => void;
  onSave: (songId: string, payload: AdminSongUpdatePayload) => void;
  onClose: () => void;
};

const DEFAULT_CATEGORY = 'Общее';
const DEFAULT_BPM = 72;
const DEFAULT_BEATS_PER_LINE = 4;
const DEFAULT_INTRO_BEATS = 4;
type DraftMetaKey = Exclude<keyof AdminSongUpdatePayload, 'sections'>;

const sectionText = (section: SongSection) => section.rows.join('\n');

const sectionChords = (section: SongSection) =>
  section.chords.map((line) => line.join(' ')).join('\n');

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

const AdminCatalogSheet = ({ songs, categories, savingId, onRefresh, onSave, onClose }: Props) => {
  const [query, setQuery] = useState('');
  const [editingId, setEditingId] = useState<string | null>(null);
  const [draft, setDraft] = useState<AdminSongUpdatePayload | null>(null);
  const [error, setError] = useState<string | null>(null);
  const categoryOptions = useMemo(() => {
    const unique = new Set([DEFAULT_CATEGORY, ...categories.filter((category) => category.trim().length > 0)]);
    return Array.from(unique);
  }, [categories]);
  const filteredSongs = useMemo(() => {
    const normalized = query.trim().toLowerCase();
    if (!normalized) return songs;
    return songs.filter((song) =>
      [song.title, song.category, song.defaultKey ?? '', String(song.number)].join(' ').toLowerCase().includes(normalized),
    );
  }, [query, songs]);

  const startEdit = (song: Song) => {
    setEditingId(song.id);
    setDraft({
      title: song.title,
      category: song.category || DEFAULT_CATEGORY,
      defaultKey: song.defaultKey ?? '',
      bpm: song.playback?.bpm ?? DEFAULT_BPM,
      beatsPerLine: song.playback?.beatsPerLine ?? DEFAULT_BEATS_PER_LINE,
      introBeats: song.playback?.introBeats ?? DEFAULT_INTRO_BEATS,
      sections: buildSongSections(song),
    });
    setError(null);
  };

  const updateDraft = (key: DraftMetaKey, value: string | number) => {
    setDraft((current) => (current ? { ...current, [key]: value } : current));
  };

  const updateSection = (index: number, key: keyof AdminSongSectionUpdatePayload, value: string) => {
    setDraft((current) => {
      if (!current?.sections) return current;
      return {
        ...current,
        sections: current.sections.map((section, sectionIndex) =>
          sectionIndex === index ? { ...section, [key]: value } : section,
        ),
      };
    });
  };

  const addSection = (sectionType: AdminSongSectionUpdatePayload['sectionType']) => {
    setDraft((current) => {
      if (!current) return current;
      const nextSections = current.sections ?? [];
      const verseNumber = nextSections.filter((section) => section.sectionType === 'verse').length + 1;
      const title = sectionType === 'verse' ? `Куплет ${verseNumber}` : sectionType === 'chorus' ? 'Припев' : 'Бридж';
      return {
        ...current,
        sections: [...nextSections, { sectionType, title, lyrics: '', chords: '' }],
      };
    });
  };

  const removeSection = (index: number) => {
    setDraft((current) => {
      if (!current?.sections || current.sections.length <= 1) return current;
      return {
        ...current,
        sections: current.sections.filter((_, sectionIndex) => sectionIndex !== index),
      };
    });
  };

  const moveSection = (index: number, direction: -1 | 1) => {
    setDraft((current) => {
      if (!current?.sections) return current;
      const nextIndex = index + direction;
      if (nextIndex < 0 || nextIndex >= current.sections.length) return current;

      const sections = [...current.sections];
      [sections[index], sections[nextIndex]] = [sections[nextIndex], sections[index]];
      return { ...current, sections };
    });
  };

  const cancelEdit = () => {
    setEditingId(null);
    setDraft(null);
    setError(null);
  };

  const saveDraft = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    if (!draft || !editingId) return;
    if (!draft.title.trim()) {
      setError('Название обязательно.');
      return;
    }
    if (!draft.sections?.some((section) => section.lyrics.trim())) {
      setError('Нужна хотя бы одна секция со словами.');
      return;
    }

    setError(null);
    onSave(editingId, draft);
  };

  return (
    <div
      className="sheet-backdrop"
      onClick={(event) => {
        if (event.target === event.currentTarget) onClose();
      }}
    >
      <section className="bottom-sheet submission-sheet" role="dialog" aria-modal="true" aria-labelledby="admin-catalog-title">
        <div className="sheet-header">
          <h2 id="admin-catalog-title">Каталог песен</h2>
          <button type="button" className="sheet-close" onClick={onClose} aria-label="Закрыть">
            Закрыть
          </button>
        </div>

        {error ? <div className="error">{error}</div> : null}

        <label className="submission-field">
          <span>Поиск</span>
          <input value={query} onChange={(event) => setQuery(event.target.value)} placeholder="Название, категория, номер" />
        </label>

        <div className="sheet-actions">
          <button type="button" className="sheet-secondary" onClick={onClose}>
            Закрыть
          </button>
          <button type="button" className="sheet-primary" onClick={onRefresh}>
            Обновить
          </button>
        </div>

        <div className="submission-list">
          {filteredSongs.length === 0 ? <p className="empty">Песни не найдены.</p> : null}
          {filteredSongs.slice(0, 120).map((song) => {
            const isEditing = editingId === song.id && draft;
            const isSaving = savingId === song.id;

            return (
              <article key={song.id} className="submission-card">
                <div className="submission-card-header">
                  <span>
                    <strong>{song.title}</strong>
                    <small>
                      №{song.number} · {song.category}
                      {song.playback ? ` · ${song.playback.bpm} BPM` : ''}
                    </small>
                  </span>
                  <b>{song.defaultKey || '-'}</b>
                </div>

                {isEditing ? (
                  <form className="submission-edit-form" onSubmit={saveDraft}>
                    <label className="submission-field">
                      <span>Название</span>
                      <input value={draft.title} onChange={(event) => updateDraft('title', event.target.value)} />
                    </label>
                    <div className="submission-grid">
                      <label className="submission-field">
                        <span>Категория</span>
                        <select value={draft.category} onChange={(event) => updateDraft('category', event.target.value)}>
                          {categoryOptions.map((item) => (
                            <option key={item} value={item}>
                              {item}
                            </option>
                          ))}
                        </select>
                      </label>
                      <label className="submission-field">
                        <span>Тональность</span>
                        <input value={draft.defaultKey} onChange={(event) => updateDraft('defaultKey', event.target.value)} />
                      </label>
                    </div>
                    <div className="submission-grid submission-grid-three">
                      <label className="submission-field">
                        <span>BPM</span>
                        <input
                          type="number"
                          min={40}
                          max={220}
                          value={draft.bpm}
                          onChange={(event) => updateDraft('bpm', Number(event.target.value))}
                        />
                      </label>
                      <label className="submission-field">
                        <span>Долей на строку</span>
                        <input
                          type="number"
                          min={1}
                          max={16}
                          value={draft.beatsPerLine}
                          onChange={(event) => updateDraft('beatsPerLine', Number(event.target.value))}
                        />
                      </label>
                      <label className="submission-field">
                        <span>Вступление</span>
                        <input
                          type="number"
                          min={0}
                          max={64}
                          value={draft.introBeats}
                          onChange={(event) => updateDraft('introBeats', Number(event.target.value))}
                        />
                      </label>
                    </div>
                    <div className="submission-section-list">
                      <div className="submission-card-header">
                        <span>
                          <strong>Секции песни</strong>
                          <small>Слова и аккорды сохраняются в БД после подтверждения</small>
                        </span>
                      </div>
                      {draft.sections?.map((section, index) => (
                        <div key={`${section.sectionType}-${index}`} className="submission-section-card">
                          <div className="submission-grid">
                            <label className="submission-field">
                              <span>Тип секции</span>
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
                              <span>Название секции</span>
                              <input value={section.title} onChange={(event) => updateSection(index, 'title', event.target.value)} />
                            </label>
                          </div>
                          <label className="submission-field">
                            <span>Слова</span>
                            <textarea value={section.lyrics} onChange={(event) => updateSection(index, 'lyrics', event.target.value)} rows={8} />
                          </label>
                          <label className="submission-field">
                            <span>Аккорды</span>
                            <textarea value={section.chords} onChange={(event) => updateSection(index, 'chords', event.target.value)} rows={5} />
                          </label>
                          <div className="submission-card-actions">
                            <button type="button" className="sheet-secondary" onClick={() => moveSection(index, -1)} disabled={isSaving || index === 0}>
                              Выше
                            </button>
                            <button
                              type="button"
                              className="sheet-secondary"
                              onClick={() => moveSection(index, 1)}
                              disabled={isSaving || index === (draft.sections?.length ?? 0) - 1}
                            >
                              Ниже
                            </button>
                            <button type="button" className="sheet-secondary" onClick={() => removeSection(index)} disabled={isSaving || (draft.sections?.length ?? 0) <= 1}>
                              Удалить секцию
                            </button>
                          </div>
                        </div>
                      ))}
                      <div className="submission-card-actions">
                        <button type="button" className="sheet-secondary" onClick={() => addSection('verse')} disabled={isSaving}>
                          Добавить куплет
                        </button>
                        <button type="button" className="sheet-secondary" onClick={() => addSection('chorus')} disabled={isSaving}>
                          Добавить припев
                        </button>
                        <button type="button" className="sheet-secondary" onClick={() => addSection('bridge')} disabled={isSaving}>
                          Добавить бридж
                        </button>
                      </div>
                    </div>
                    <div className="submission-card-actions">
                      <button type="button" className="sheet-secondary" onClick={cancelEdit} disabled={isSaving}>
                        Отмена
                      </button>
                      <button type="submit" className="sheet-primary" disabled={isSaving}>
                        {isSaving ? 'Сохранение...' : 'Сохранить'}
                      </button>
                    </div>
                  </form>
                ) : (
                  <div className="submission-card-actions">
                    <button type="button" className="sheet-primary" onClick={() => startEdit(song)} disabled={isSaving}>
                      Редактировать
                    </button>
                  </div>
                )}
              </article>
            );
          })}
        </div>
      </section>
    </div>
  );
};

export default AdminCatalogSheet;

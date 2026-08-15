import { FormEvent, useMemo, useState } from 'react';
import { submitSongSubmission } from '../lib/catalogApi';
import { fillMissingVerseChords } from '../lib/leadSheetTools';

type Props = {
  categories: string[];
  onClose: () => void;
  onSubmitted: (message: string) => void;
};

const DEFAULT_CATEGORY = 'Общее';
const DEFAULT_BPM = 72;
const DEFAULT_BEATS_PER_LINE = 4;
const DEFAULT_INTRO_BEATS = 4;

const SongSubmissionSheet = ({ categories, onClose, onSubmitted }: Props) => {
  const categoryOptions = useMemo(() => {
    const unique = new Set([DEFAULT_CATEGORY, ...categories.filter((category) => category.trim().length > 0)]);
    return Array.from(unique);
  }, [categories]);
  const [title, setTitle] = useState('');
  const [category, setCategory] = useState(DEFAULT_CATEGORY);
  const [defaultKey, setDefaultKey] = useState('');
  const [leadSheet, setLeadSheet] = useState('');
  const [bpm, setBpm] = useState(DEFAULT_BPM);
  const [beatsPerLine, setBeatsPerLine] = useState(DEFAULT_BEATS_PER_LINE);
  const [introBeats, setIntroBeats] = useState(DEFAULT_INTRO_BEATS);
  const [submitterName, setSubmitterName] = useState('');
  const [submitterEmail, setSubmitterEmail] = useState('');
  const [note, setNote] = useState('');
  const [error, setError] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleSubmit = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    if (!title.trim() || !leadSheet.trim()) {
      setError('Нужно заполнить название и текст песни.');
      return;
    }

    setIsSubmitting(true);
    setError(null);
    try {
      await submitSongSubmission({
        title,
        category,
        defaultKey,
        leadSheet,
        bpm,
        beatsPerLine,
        introBeats,
        submitterName,
        submitterEmail,
        note,
      });
      onSubmitted('Песня отправлена на апрув.');
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Не удалось отправить песню.');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div
      className="sheet-backdrop"
      onClick={(event) => {
        if (event.target === event.currentTarget) onClose();
      }}
    >
      <section className="bottom-sheet submission-sheet" role="dialog" aria-modal="true" aria-labelledby="submission-title">
        <div className="sheet-header">
          <h2 id="submission-title">Предложить песню</h2>
          <button type="button" className="sheet-close" onClick={onClose} aria-label="Закрыть">
            Закрыть
          </button>
        </div>

        {error ? <div className="error">{error}</div> : null}

        <form className="submission-form" onSubmit={handleSubmit}>
          <label className="submission-field">
            <span>Название</span>
            <input value={title} onChange={(event) => setTitle(event.target.value)} autoFocus />
          </label>

          <div className="submission-grid">
            <label className="submission-field">
              <span>Категория</span>
              <select value={category} onChange={(event) => setCategory(event.target.value)}>
                {categoryOptions.map((item) => (
                  <option key={item} value={item}>
                    {item}
                  </option>
                ))}
              </select>
            </label>
            <label className="submission-field">
              <span>Тональность</span>
              <input value={defaultKey} onChange={(event) => setDefaultKey(event.target.value)} placeholder="G, Am..." />
            </label>
          </div>

          <label className="submission-field">
            <span>Текст с аккордами</span>
            <textarea
              value={leadSheet}
              onChange={(event) => setLeadSheet(event.target.value)}
              placeholder={'[Куплет 1]\nG      D\nБог твой Царь...\n\n[Припев]\nEm     C\nСлава Тебе...'}
              rows={12}
            />
          </label>
          <div className="admin-inline-actions">
            <button type="button" className="sheet-secondary" onClick={() => setLeadSheet(fillMissingVerseChords(leadSheet))}>
              Дополнить аккорды из первого куплета
            </button>
          </div>
          <p className="submission-help">
            Вставляй песню как на Holychords: заголовок секции, строка аккордов над строкой текста. Аккорды можно скрыть в просмотре.
          </p>

          <div className="submission-grid submission-grid-three">
            <label className="submission-field">
              <span>BPM</span>
              <input type="number" min={40} max={220} value={bpm} onChange={(event) => setBpm(Number(event.target.value))} />
            </label>
            <label className="submission-field">
              <span>Долей на строку</span>
              <input
                type="number"
                min={1}
                max={16}
                value={beatsPerLine}
                onChange={(event) => setBeatsPerLine(Number(event.target.value))}
              />
            </label>
            <label className="submission-field">
              <span>Вступление</span>
              <input
                type="number"
                min={0}
                max={64}
                value={introBeats}
                onChange={(event) => setIntroBeats(Number(event.target.value))}
              />
            </label>
          </div>

          <div className="submission-grid">
            <label className="submission-field">
              <span>Имя</span>
              <input value={submitterName} onChange={(event) => setSubmitterName(event.target.value)} />
            </label>
            <label className="submission-field">
              <span>Email</span>
              <input type="email" value={submitterEmail} onChange={(event) => setSubmitterEmail(event.target.value)} />
            </label>
          </div>

          <label className="submission-field">
            <span>Комментарий</span>
            <textarea value={note} onChange={(event) => setNote(event.target.value)} rows={3} />
          </label>

          <p className="submission-help">Песня попадёт в общий каталог только после проверки в админке.</p>

          <div className="sheet-actions">
            <button type="button" className="sheet-secondary" onClick={onClose}>
              Отмена
            </button>
            <button type="submit" className="sheet-primary" disabled={isSubmitting}>
              {isSubmitting ? 'Отправка...' : 'Отправить'}
            </button>
          </div>
        </form>
      </section>
    </div>
  );
};

export default SongSubmissionSheet;

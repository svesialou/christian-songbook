import { FormEvent, useMemo, useState } from 'react';
import { createAdminSong } from '../lib/catalogApi';

type Props = {
  adminKey: string;
  categories: string[];
  onClose: () => void;
  onCreated: (message: string) => void | Promise<void>;
};

const DEFAULT_CATEGORY = 'Общее';

const AdminSongCreateSheet = ({ adminKey, categories, onClose, onCreated }: Props) => {
  const categoryOptions = useMemo(() => {
    const unique = new Set([DEFAULT_CATEGORY, ...categories.filter((category) => category.trim().length > 0)]);
    return Array.from(unique);
  }, [categories]);
  const [title, setTitle] = useState('');
  const [category, setCategory] = useState(DEFAULT_CATEGORY);
  const [defaultKey, setDefaultKey] = useState('');
  const [lyrics, setLyrics] = useState('');
  const [chords, setChords] = useState('');
  const [note, setNote] = useState('');
  const [error, setError] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleSubmit = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    if (!title.trim() || !lyrics.trim()) {
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
      const result = await createAdminSong(
        {
          title,
          category,
          defaultKey,
          lyrics,
          chords,
          submitterName: '',
          submitterEmail: '',
          note,
        },
        adminKey,
      );
      await onCreated(`Песня добавлена в MySQL-каталог: ${result.songId}`);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Не удалось добавить песню.');
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
      <section className="bottom-sheet submission-sheet" role="dialog" aria-modal="true" aria-labelledby="admin-song-create-title">
        <div className="sheet-header">
          <h2 id="admin-song-create-title">Добавить песню</h2>
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
            <span>Текст</span>
            <textarea
              value={lyrics}
              onChange={(event) => setLyrics(event.target.value)}
              placeholder="Каждая строка песни с новой строки"
              rows={8}
            />
          </label>

          <label className="submission-field">
            <span>Аккорды</span>
            <textarea
              value={chords}
              onChange={(event) => setChords(event.target.value)}
              placeholder="Опционально: строки аккордов в том же порядке"
              rows={5}
            />
          </label>

          <label className="submission-field">
            <span>Комментарий</span>
            <textarea value={note} onChange={(event) => setNote(event.target.value)} rows={3} />
          </label>

          <p className="submission-help">Песня будет сразу опубликована в текущей MySQL-версии каталога.</p>

          <div className="sheet-actions">
            <button type="button" className="sheet-secondary" onClick={onClose}>
              Отмена
            </button>
            <button type="submit" className="sheet-primary" disabled={isSubmitting}>
              {isSubmitting ? 'Сохранение...' : 'Добавить в каталог'}
            </button>
          </div>
        </form>
      </section>
    </div>
  );
};

export default AdminSongCreateSheet;

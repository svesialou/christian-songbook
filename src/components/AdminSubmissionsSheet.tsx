import { FormEvent, useState } from 'react';
import { SongSubmission, SongSubmissionPayload } from '../lib/catalogApi';

type Props = {
  submissions: SongSubmission[];
  isLoading: boolean;
  approvingId: number | null;
  rejectingId: number | null;
  savingId: number | null;
  onRefresh: () => void;
  onSave: (submissionId: number, payload: SongSubmissionPayload) => void;
  onApprove: (submissionId: number) => void;
  onReject: (submissionId: number) => void;
  onClose: () => void;
};

type Draft = SongSubmissionPayload;
const DEFAULT_BPM = 72;
const DEFAULT_BEATS_PER_LINE = 4;
const DEFAULT_INTRO_BEATS = 4;

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

const AdminSubmissionsSheet = ({
  submissions,
  isLoading,
  approvingId,
  rejectingId,
  savingId,
  onRefresh,
  onSave,
  onApprove,
  onReject,
  onClose,
}: Props) => {
  const [editingId, setEditingId] = useState<number | null>(null);
  const [draft, setDraft] = useState<Draft | null>(null);
  const [error, setError] = useState<string | null>(null);

  const startEdit = (submission: SongSubmission) => {
    setEditingId(submission.id);
    setDraft({
      title: submission.title,
      category: submission.category,
      authors: submission.authors ?? [],
      defaultKey: submission.defaultKey,
      leadSheet: submission.leadSheet || submission.lyrics || '',
      lyrics: submission.lyrics || '',
      chords: submission.chords || '', 
      bpm: submission.bpm ?? DEFAULT_BPM,
      beatsPerLine: submission.beatsPerLine ?? DEFAULT_BEATS_PER_LINE,
      introBeats: submission.introBeats ?? DEFAULT_INTRO_BEATS,
      submitterName: submission.submitterName,
      submitterEmail: submission.submitterEmail,
      note: submission.note,
    });
    setError(null);
  };

  const updateDraft = (key: keyof Draft, value: string | number) => {
    setDraft((current) => (current ? { ...current, [key]: value } : current));
  };

  const cancelEdit = () => {
    setEditingId(null);
    setDraft(null);
    setError(null);
  };

  const saveDraft = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    if (!draft || editingId === null) return;
    if (!draft.title.trim() || !(draft.leadSheet || draft.lyrics || '').trim()) {
      setError('Название и текст обязательны перед сохранением.');
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
      <section className="bottom-sheet submission-sheet" role="dialog" aria-modal="true" aria-labelledby="admin-submissions-title">
        <div className="sheet-header">
          <h2 id="admin-submissions-title">Заявки песен</h2>
          <button type="button" className="sheet-close" onClick={onClose} aria-label="Закрыть">
            Закрыть
          </button>
        </div>

        {error ? <div className="error">{error}</div> : null}

        <div className="sheet-actions">
          <button type="button" className="sheet-secondary" onClick={onClose}>
            Закрыть
          </button>
          <button type="button" className="sheet-primary" onClick={onRefresh} disabled={isLoading}>
            {isLoading ? 'Загрузка...' : 'Обновить'}
          </button>
        </div>

        <div className="submission-list">
          {submissions.length === 0 ? (
            <p className="empty">Нет pending заявок.</p>
          ) : (
            submissions.map((submission) => {
              const isEditing = editingId === submission.id && draft;
              const isBusy = approvingId === submission.id || rejectingId === submission.id || savingId === submission.id;

              return (
                <article key={submission.id} className="submission-card">
                  <div className="submission-card-header">
                    <span>
                      <strong>{submission.title}</strong>
                      <small>
                        {submission.category} · {formatSubmissionDate(submission.createdAt)}
                      </small>
                    </span>
                    <b>#{submission.id}</b>
                  </div>
                  <p className="submission-meta">
                    {submission.submitterName || 'Без имени'}
                    {submission.submitterEmail ? ` · ${submission.submitterEmail}` : ''}
                  </p>
                  {submission.note ? <p className="submission-meta">{submission.note}</p> : null}

                  {isEditing ? (
                    <form className="submission-edit-form" onSubmit={saveDraft}>
                      <label className="submission-field">
                        <span>Название</span>
                        <input value={draft.title} onChange={(event) => updateDraft('title', event.target.value)} />
                      </label>
                      <div className="submission-grid">
                        <label className="submission-field">
                          <span>Категория</span>
                          <input value={draft.category} onChange={(event) => updateDraft('category', event.target.value)} />
                        </label>
                        <label className="submission-field">
                          <span>Тональность</span>
                          <input value={draft.defaultKey} onChange={(event) => updateDraft('defaultKey', event.target.value)} />
                        </label>
                      </div>
                      <label className="submission-field">
                        <span>Текст</span>
                        <textarea value={draft.lyrics} onChange={(event) => updateDraft('lyrics', event.target.value)} rows={8} />
                      </label>
                      <label className="submission-field">
                        <span>Аккорды</span>
                        <textarea value={draft.chords} onChange={(event) => updateDraft('chords', event.target.value)} rows={5} />
                      </label>
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
                      <label className="submission-field">
                        <span>Комментарий</span>
                        <textarea value={draft.note} onChange={(event) => updateDraft('note', event.target.value)} rows={3} />
                      </label>
                      <div className="submission-card-actions">
                        <button type="button" className="sheet-secondary" onClick={cancelEdit} disabled={savingId === submission.id}>
                          Отмена
                        </button>
                        <button type="submit" className="sheet-primary" disabled={savingId === submission.id}>
                          {savingId === submission.id ? 'Сохранение...' : 'Сохранить'}
                        </button>
                      </div>
                    </form>
                  ) : (
                    <>
                      <pre className="submission-preview">{(submission.leadSheet || submission.lyrics || '').split('\n').slice(0, 5).join('\n')}</pre>
                      <div className="submission-card-actions">
                        <button type="button" className="sheet-secondary" onClick={() => startEdit(submission)} disabled={isBusy}>
                          Редактировать
                        </button>
                        <button type="button" className="sheet-primary" onClick={() => onApprove(submission.id)} disabled={isBusy}>
                          {approvingId === submission.id ? 'Апрув...' : 'Апрувить'}
                        </button>
                        <button type="button" className="sheet-secondary" onClick={() => onReject(submission.id)} disabled={isBusy}>
                          {rejectingId === submission.id ? 'Отклонение...' : 'Отклонить'}
                        </button>
                      </div>
                    </>
                  )}
                </article>
              );
            })
          )}
        </div>
      </section>
    </div>
  );
};

export default AdminSubmissionsSheet;

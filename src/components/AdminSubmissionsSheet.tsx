import { SongSubmission } from '../lib/catalogApi';

type Props = {
  adminKey: string;
  submissions: SongSubmission[];
  isLoading: boolean;
  approvingId: number | null;
  onAdminKeyChange: (value: string) => void;
  onRefresh: () => void;
  onApprove: (submissionId: number) => void;
  onClose: () => void;
};

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
  adminKey,
  submissions,
  isLoading,
  approvingId,
  onAdminKeyChange,
  onRefresh,
  onApprove,
  onClose,
}: Props) => (
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

      <label className="submission-field">
        <span>Admin key</span>
        <input
          type="password"
          value={adminKey}
          onChange={(event) => onAdminKeyChange(event.target.value)}
          placeholder="ADMIN_API_KEY"
        />
      </label>

      <div className="sheet-actions">
        <button type="button" className="sheet-secondary" onClick={onClose}>
          Закрыть
        </button>
        <button type="button" className="sheet-primary" onClick={onRefresh} disabled={isLoading || !adminKey.trim()}>
          {isLoading ? 'Загрузка...' : 'Обновить'}
        </button>
      </div>

      <div className="submission-list">
        {submissions.length === 0 ? (
          <p className="empty">{adminKey.trim() ? 'Нет pending заявок.' : 'Введите admin key и обновите список.'}</p>
        ) : (
          submissions.map((submission) => (
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
              <pre className="submission-preview">{submission.lyrics.split('\n').slice(0, 5).join('\n')}</pre>
              <button
                type="button"
                className="sheet-primary"
                onClick={() => onApprove(submission.id)}
                disabled={approvingId === submission.id}
              >
                {approvingId === submission.id ? 'Апрув...' : 'Апрувить в каталог'}
              </button>
            </article>
          ))
        )}
      </div>
    </section>
  </div>
);

export default AdminSubmissionsSheet;

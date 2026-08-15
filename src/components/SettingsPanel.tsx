import { FormEvent, useEffect, useState } from 'react';
import { SongSettings } from '../types/song';
import { CurrentUserState, UserPreferences } from '../lib/catalogApi';

type SettingsPanelProps = {
  settings: SongSettings;
  account: CurrentUserState | null;
  isAccountLoading: boolean;
  onChange: (settings: SongSettings) => void;
  onGoogleLogin: () => void;
  onLogout: () => void;
  onSavePreferences: (preferences: UserPreferences) => Promise<void>;
};

const presetSettings: Record<SongSettings['viewPreset'], Partial<SongSettings>> = {
  lead: { showChords: true, fontScale: 'normal' },
  singer: { showChords: false, fontScale: 'large' },
  chords: { showChords: true, fontScale: 'normal' },
};

const presetLabels: Record<SongSettings['viewPreset'], { title: string; description: string }> = {
  lead: { title: 'Lead', description: 'Текст и аккорды' },
  singer: { title: 'Singer', description: 'Крупный текст' },
  chords: { title: 'Chords', description: 'Аккорды в фокусе' },
};

const defaultUserPreferences = (): UserPreferences => ({
  instrument: 'guitar',
  preferredKeys: ['G', 'D', 'A'],
  capoEnabled: true,
  maxCapo: 5,
  pianoTransposeEnabled: true,
  showOriginalKey: true,
});

const SettingsPanel = ({
  settings,
  account,
  isAccountLoading,
  onChange,
  onGoogleLogin,
  onLogout,
  onSavePreferences,
}: SettingsPanelProps) => {
  const [personalDraft, setPersonalDraft] = useState<UserPreferences>(() => defaultUserPreferences());
  const [preferredKeysText, setPreferredKeysText] = useState(() => defaultUserPreferences().preferredKeys.join(', '));
  const [isSavingPreferences, setIsSavingPreferences] = useState(false);
  const change = <K extends keyof SongSettings>(key: K, value: SongSettings[K]) =>
    onChange({ ...settings, [key]: value });
  const applyPreset = (viewPreset: SongSettings['viewPreset']) =>
    onChange({ ...settings, ...presetSettings[viewPreset], viewPreset });
  const changePersonal = <K extends keyof UserPreferences>(key: K, value: UserPreferences[K]) =>
    setPersonalDraft((current) => ({ ...current, [key]: value }));
  const savePersonalPreferences = async (event: FormEvent) => {
    event.preventDefault();
    setIsSavingPreferences(true);
    try {
      await onSavePreferences({
        ...personalDraft,
        preferredKeys: preferredKeysText
          .split(',')
          .map((key) => key.trim())
          .filter(Boolean),
      });
    } finally {
      setIsSavingPreferences(false);
    }
  };

  useEffect(() => {
    const nextPreferences = account?.preferences || defaultUserPreferences();
    setPersonalDraft(nextPreferences);
    setPreferredKeysText(nextPreferences.preferredKeys.join(', '));
  }, [account?.preferences]);

  return (
    <section className="settings" aria-label="Настройки отображения">
      <div className="settings-header">
        <strong>Настройки</strong>
        <span>{presetLabels[settings.viewPreset].title}</span>
      </div>

      <div className="account-card">
        <div>
          <strong>{account?.authenticated ? account.user?.displayName || 'Аккаунт' : 'Аккаунт не обязателен'}</strong>
          <span>
            {isAccountLoading
              ? 'Проверяем вход...'
              : account?.authenticated
                ? account.user?.email || 'Персональные настройки включены'
                : 'Сборник работает без входа. Вход нужен только для персональных настроек.'}
          </span>
        </div>
        {account?.authenticated ? (
          <button type="button" className="toolbar-button account-button" onClick={onLogout}>
            Выйти
          </button>
        ) : (
          <button type="button" className="toolbar-button account-button" onClick={onGoogleLogin} disabled={isAccountLoading}>
            Войти через Google
          </button>
        )}
      </div>

      {account?.authenticated ? (
        <form className="personal-settings-card" onSubmit={savePersonalPreferences}>
          <label className="select-row">
            <span>Инструмент</span>
            <select
              value={personalDraft.instrument}
              onChange={(event) => changePersonal('instrument', event.target.value)}
            >
              <option value="guitar">Гитара</option>
              <option value="piano">Клавиши</option>
              <option value="vocal">Вокал</option>
              <option value="other">Другое</option>
            </select>
          </label>

          <label className="submission-field">
            <span>Удобные тональности</span>
            <input
              type="text"
              value={preferredKeysText}
              onChange={(event) => setPreferredKeysText(event.target.value)}
              placeholder="G, D, A, E"
            />
          </label>

          <label className="select-row">
            <span>Макс. capo</span>
            <input
              type="number"
              min="0"
              max="12"
              value={personalDraft.maxCapo}
              onChange={(event) => changePersonal('maxCapo', Number(event.target.value))}
            />
          </label>

          <label className="toggle-row">
            <input
              type="checkbox"
              checked={personalDraft.capoEnabled}
              onChange={(event) => changePersonal('capoEnabled', event.target.checked)}
            />
            <span>Подсказывать capo</span>
          </label>

          <label className="toggle-row">
            <input
              type="checkbox"
              checked={personalDraft.pianoTransposeEnabled}
              onChange={(event) => changePersonal('pianoTransposeEnabled', event.target.checked)}
            />
            <span>Подсказка transpose для клавиш</span>
          </label>

          <label className="toggle-row">
            <input
              type="checkbox"
              checked={personalDraft.showOriginalKey}
              onChange={(event) => changePersonal('showOriginalKey', event.target.checked)}
            />
            <span>Показывать оригинальную тональность</span>
          </label>

          <button type="submit" className="toolbar-button account-button" disabled={isSavingPreferences}>
            {isSavingPreferences ? 'Сохраняем...' : 'Сохранить персональные'}
          </button>
        </form>
      ) : null}

      <div className="settings-grid">
        <fieldset className="preset-fieldset">
          <legend>Режим</legend>
          <div className="preset-grid" role="group" aria-label="Режим участника">
            {(Object.keys(presetLabels) as SongSettings['viewPreset'][]).map((preset) => (
              <button
                key={preset}
                className={`preset-button ${settings.viewPreset === preset ? 'is-selected' : ''}`}
                type="button"
                onClick={() => applyPreset(preset)}
                aria-pressed={settings.viewPreset === preset}
              >
                <strong>{presetLabels[preset].title}</strong>
                <span>{presetLabels[preset].description}</span>
              </button>
            ))}
          </div>
        </fieldset>

        <label className="toggle-row">
          <input
            type="checkbox"
            checked={settings.showChords}
            onChange={(event) => change('showChords', event.target.checked)}
          />
          <span>Аккорды</span>
        </label>

        <label className="toggle-row">
          <input
            type="checkbox"
            checked={settings.repeatChorus}
            onChange={(event) => change('repeatChorus', event.target.checked)}
          />
          <span>Повтор припева</span>
        </label>

        <label className="toggle-row">
          <input
            type="checkbox"
            checked={settings.splitSections}
            onChange={(event) => change('splitSections', event.target.checked)}
          />
          <span>Две колонки</span>
        </label>

        <label className="toggle-row">
          <input
            type="checkbox"
            checked={settings.showPlaybackDock}
            onChange={(event) => change('showPlaybackDock', event.target.checked)}
          />
          <span>BPM-панель</span>
        </label>

        <label className="toggle-row">
          <input
            type="checkbox"
            checked={settings.darkTheme}
            onChange={(event) => change('darkTheme', event.target.checked)}
          />
          <span>Тёмная тема</span>
        </label>

        <label className="select-row">
          <span>Шрифт</span>
          <select
            value={settings.fontScale}
            onChange={(event) => change('fontScale', event.target.value as SongSettings['fontScale'])}
          >
            <option value="normal">Обычный</option>
            <option value="large">Крупный</option>
          </select>
        </label>

      </div>
    </section>
  );
};

export default SettingsPanel;

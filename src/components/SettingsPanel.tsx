import { SongSettings } from '../types/song';

type SettingsPanelProps = {
  settings: SongSettings;
  onChange: (settings: SongSettings) => void;
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

const SettingsPanel = ({ settings, onChange }: SettingsPanelProps) => {
  const change = <K extends keyof SongSettings>(key: K, value: SongSettings[K]) =>
    onChange({ ...settings, [key]: value });
  const applyPreset = (viewPreset: SongSettings['viewPreset']) =>
    onChange({ ...settings, ...presetSettings[viewPreset], viewPreset });

  return (
    <section className="settings" aria-label="Настройки отображения">
      <div className="settings-header">
        <strong>Настройки</strong>
        <span>{presetLabels[settings.viewPreset].title}</span>
      </div>

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

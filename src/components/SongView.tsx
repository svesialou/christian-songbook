import { type CSSProperties, type TouchEvent, useEffect, useMemo, useRef, useState } from 'react';
import { Song } from '../types/song';
import { normalizeTransposition, transposeSongRows } from '../lib/chords';
import { SongPlaybackPosition, SongSettings } from '../types/song';

type SongViewProps = {
  song: Song;
  settings: SongSettings;
  playbackPosition: SongPlaybackPosition | null;
  initialAutoPlay?: boolean;
  onBack: () => void;
  onTranspositionChange: (songId: string, transposition: number) => void;
  onPlaybackPositionChange: (position: SongPlaybackPosition | null) => void;
};

type PlaybackLine = {
  sequenceIndex: number;
  songId: string;
  sectionId: string;
  sectionTitle: string;
  lineIndex: number;
};

const DEFAULT_PLAYBACK = {
  bpm: 72,
  beatsPerLine: 4,
  introBeats: 4,
};
const MIN_BPM = 40;
const MAX_BPM = 220;

const lineKey = (sectionId: string, lineIndex: number) => `${sectionId}:${lineIndex}`;

const playbackLineToPosition = (line: PlaybackLine): SongPlaybackPosition => ({
  songId: line.songId,
  sectionId: line.sectionId,
  sectionTitle: line.sectionTitle,
  lineIndex: line.lineIndex,
  updatedAt: new Date().toISOString(),
});

const buildPlaybackLines = (song: Song, repeatChorus: boolean): PlaybackLine[] => {
  const lines: PlaybackLine[] = [];
  const pushSection = (sectionId: string, sectionTitle: string, rows: string[]) => {
    rows.forEach((_, lineIndex) => {
      lines.push({
        sequenceIndex: lines.length,
        songId: song.id,
        sectionId,
        sectionTitle,
        lineIndex,
      });
    });
  };

  song.verses.forEach((verse, index) => {
    pushSection(`verse-${index}`, index === 0 ? 'Куплет 1' : `Куплет ${index + 1}`, verse.rows);
  });

  if (song.chorus) {
    pushSection('chorus', 'Припев', song.chorus.rows);
  }

  if (repeatChorus && song.chorus) {
    song.verses.slice(1).forEach((_, index) => {
      pushSection(`repeat-chorus-${index}`, 'Припев', song.chorus!.rows);
    });
  }

  if (song.bridge) {
    pushSection('bridge', 'Мост', song.bridge.rows);
  }

  return lines;
};

const viewPresetLabels: Record<SongSettings['viewPreset'], string> = {
  lead: 'Lead: текст и аккорды',
  singer: 'Singer: крупный текст',
  chords: 'Chords: аккорды в фокусе',
};

const Section = ({
  title,
  sectionId,
  songId,
  rows,
  chords,
  settings,
  playbackPosition,
  registerLine,
  onPlaybackPositionChange,
}: {
  title: string;
  sectionId: string;
  songId: string;
  rows: string[];
  chords: string[][];
  settings: SongSettings;
  playbackPosition: SongPlaybackPosition | null;
  registerLine: (key: string, element: HTMLButtonElement | null) => void;
  onPlaybackPositionChange: (position: SongPlaybackPosition | null) => void;
}) => {
  const rendered = rows.map((row, index) => {
    const chordRow = chords[index] || [];
    const chordText = settings.showChords ? chordRow.join('   ') : '';
    const text = row;
    const isActive = playbackPosition?.sectionId === sectionId && playbackPosition.lineIndex === index;

    return (
      <li
        key={`${title}-${index}`}
        className={`song-line-block ${settings.viewPreset === 'chords' ? 'is-chords-focus' : ''} ${
          isActive ? 'is-active' : ''
        }`}
      >
        <button
          type="button"
          className="song-line-button"
          ref={(element) => registerLine(lineKey(sectionId, index), element)}
          onClick={() => {
            onPlaybackPositionChange(
              isActive
                ? null
                : {
                    songId,
                    sectionId,
                    sectionTitle: title,
                    lineIndex: index,
                    updatedAt: new Date().toISOString(),
                  },
            );
          }}
          aria-pressed={isActive}
          aria-current={isActive ? 'true' : undefined}
          aria-label={`${isActive ? 'Снять фокус со строки' : 'Отметить текущую строку'}: ${title}, строка ${index + 1}`}
        >
          {chordText ? (
            <span className="chords">{transposeSongRows([chordText], settings.transposition)[0]}</span>
          ) : null}
          <span className="line">{text}</span>
        </button>
      </li>
    );
  });

  return (
    <section className="section">
      <h2 className="section-title">{title}</h2>
      <ul>{rendered}</ul>
    </section>
  );
};

const SongView = ({
  song,
  settings,
  playbackPosition,
  initialAutoPlay = false,
  onBack,
  onTranspositionChange,
  onPlaybackPositionChange,
}: SongViewProps) => {
  const [isAutoPlaying, setIsAutoPlaying] = useState(initialAutoPlay);
  const [isIntroActive, setIsIntroActive] = useState(initialAutoPlay);
  const [playbackTick, setPlaybackTick] = useState(() => Date.now());
  const [playbackBpm, setPlaybackBpm] = useState(() => song.playback?.bpm ?? DEFAULT_PLAYBACK.bpm);
  const [bpmInputValue, setBpmInputValue] = useState(() => String(song.playback?.bpm ?? DEFAULT_PLAYBACK.bpm));
  const lineElements = useRef<Record<string, HTMLButtonElement | null>>({});
  const swipeStart = useRef<{ x: number; y: number } | null>(null);
  const tapTempoTimes = useRef<number[]>([]);
  const introStartedAt = useRef<number | null>(initialAutoPlay ? Date.now() : null);
  const lineStartedAt = useRef<number | null>(null);
  const activePosition = playbackPosition?.songId === song.id ? playbackPosition : null;
  const playback = { ...DEFAULT_PLAYBACK, ...song.playback, bpm: playbackBpm };
  const beatDurationMs = 60000 / playback.bpm;
  const lineDurationMs = Math.max(1200, Math.round((60000 / playback.bpm) * playback.beatsPerLine));
  const introBeats = playback.introBeats ?? DEFAULT_PLAYBACK.introBeats;
  const introDurationMs = Math.max(0, Math.round((60000 / playback.bpm) * introBeats));
  const playbackLines = useMemo(
    () => buildPlaybackLines(song, settings.repeatChorus),
    [song, settings.repeatChorus],
  );
  const activeLineIndex = activePosition
    ? playbackLines.findIndex(
        (line) => line.sectionId === activePosition.sectionId && line.lineIndex === activePosition.lineIndex,
      )
    : -1;
  const activePlaybackLine = activeLineIndex >= 0 ? playbackLines[activeLineIndex] : null;
  const isPlaybackAtEnd = activeLineIndex >= playbackLines.length - 1;
  const introElapsedMs =
    isIntroActive && introStartedAt.current ? Math.max(0, playbackTick - introStartedAt.current) : 0;
  const introRemainingBeats =
    isIntroActive && introDurationMs > 0
      ? Math.max(1, Math.ceil((introDurationMs - introElapsedMs) / beatDurationMs))
      : 0;
  const introProgress = introDurationMs > 0 ? Math.min(100, (introElapsedMs / introDurationMs) * 100) : 100;
  const lineElapsedMs =
    isAutoPlaying && !isIntroActive && activeLineIndex >= 0 && lineStartedAt.current
      ? Math.max(0, playbackTick - lineStartedAt.current)
      : 0;
  const lineProgress = lineDurationMs > 0 ? Math.min(100, (lineElapsedMs / lineDurationMs) * 100) : 0;
  const playbackProgress = isAutoPlaying ? (isIntroActive ? introProgress : lineProgress) : 0;
  const playbackProgressStyle = { '--playback-progress': `${playbackProgress}%` } as CSSProperties;
  const playbackStatus = isIntroActive
    ? `Вступление: ${introBeats} долей`
    : isAutoPlaying
      ? 'Автопереход включён'
      : 'Автопереход выключен';
  const playbackTimingLabel = isIntroActive
    ? `Вступление: ${introRemainingBeats}`
    : activePlaybackLine
      ? `${activePlaybackLine.sectionTitle} · ${activeLineIndex + 1}/${playbackLines.length}`
      : `${playback.bpm} BPM · ${playback.beatsPerLine} доли`;

  useEffect(() => {
    const nextBpm = song.playback?.bpm ?? DEFAULT_PLAYBACK.bpm;
    setPlaybackBpm(nextBpm);
    setBpmInputValue(String(nextBpm));
    setIsAutoPlaying(initialAutoPlay);
    setIsIntroActive(initialAutoPlay);
    introStartedAt.current = initialAutoPlay ? Date.now() : null;
    lineStartedAt.current = null;
    setPlaybackTick(Date.now());
  }, [initialAutoPlay, song.id, song.playback?.bpm]);

  const registerLine = (key: string, element: HTMLButtonElement | null) => {
    lineElements.current[key] = element;
  };

  const scrollToActiveLine = () => {
    if (!activePosition) return;
    const element = lineElements.current[lineKey(activePosition.sectionId, activePosition.lineIndex)];
    if (!element) return;

    window.requestAnimationFrame(() => {
      element.scrollIntoView({
        behavior: window.matchMedia('(prefers-reduced-motion: reduce)').matches ? 'auto' : 'smooth',
        block: 'center',
        inline: 'nearest',
      });
    });
  };

  useEffect(() => {
    if (!activePosition) return;

    if (!isIntroActive) {
      lineStartedAt.current = Date.now();
      setPlaybackTick(Date.now());
    }

    scrollToActiveLine();
  }, [activePosition?.sectionId, activePosition?.lineIndex, isIntroActive]);

  useEffect(() => {
    if (!isAutoPlaying) return undefined;

    setPlaybackTick(Date.now());
    const interval = window.setInterval(() => {
      setPlaybackTick(Date.now());
    }, 250);

    return () => window.clearInterval(interval);
  }, [isAutoPlaying]);

  useEffect(() => {
    if (!isAutoPlaying || isIntroActive || playbackLines.length === 0 || activeLineIndex >= 0) return;
    onPlaybackPositionChange(playbackLineToPosition(playbackLines[0]));
  }, [activeLineIndex, isAutoPlaying, isIntroActive, onPlaybackPositionChange, playbackLines]);

  useEffect(() => {
    if (!isAutoPlaying || !isIntroActive) return undefined;
    if (introDurationMs <= 0) {
      introStartedAt.current = null;
      setIsIntroActive(false);
      return undefined;
    }

    const timeout = window.setTimeout(() => {
      introStartedAt.current = null;
      setIsIntroActive(false);
    }, introDurationMs);

    return () => window.clearTimeout(timeout);
  }, [introDurationMs, isAutoPlaying, isIntroActive]);

  useEffect(() => {
    if (!isAutoPlaying || isIntroActive || playbackLines.length === 0 || activeLineIndex < 0) return undefined;
    if (activeLineIndex >= playbackLines.length - 1) {
      setIsAutoPlaying(false);
      return undefined;
    }

    const timeout = window.setTimeout(() => {
      onPlaybackPositionChange(playbackLineToPosition(playbackLines[activeLineIndex + 1]));
    }, lineDurationMs);

    return () => window.clearTimeout(timeout);
  }, [activeLineIndex, isAutoPlaying, isIntroActive, lineDurationMs, onPlaybackPositionChange, playbackLines]);

  const toggleAutoPlayback = () => {
    if (isAutoPlaying) {
      setIsAutoPlaying(false);
      setIsIntroActive(false);
      introStartedAt.current = null;
      lineStartedAt.current = null;
      return;
    }

    if (playbackLines.length === 0) return;

    if (introDurationMs > 0 && (activeLineIndex < 0 || isPlaybackAtEnd)) {
      introStartedAt.current = Date.now();
      lineStartedAt.current = null;
      setPlaybackTick(Date.now());
      setIsIntroActive(true);
    } else if (activeLineIndex < 0 || isPlaybackAtEnd) {
      onPlaybackPositionChange(playbackLineToPosition(playbackLines[0]));
    } else {
      lineStartedAt.current = Date.now();
      setPlaybackTick(Date.now());
    }

    setIsAutoPlaying(true);
  };

  const clampBpm = (nextBpm: number) => Math.min(MAX_BPM, Math.max(MIN_BPM, Math.round(nextBpm)));
  const setBpm = (nextBpm: number) => {
    const clampedBpm = clampBpm(nextBpm);
    setPlaybackBpm(clampedBpm);
    setBpmInputValue(String(clampedBpm));
    if (isAutoPlaying && !isIntroActive) {
      lineStartedAt.current = Date.now();
      setPlaybackTick(Date.now());
    }
  };
  const changeBpmInput = (value: string) => {
    setBpmInputValue(value);
    if (!value.trim()) return;

    const nextBpm = Number(value);
    if (Number.isFinite(nextBpm) && nextBpm >= MIN_BPM && nextBpm <= MAX_BPM) {
      setBpm(nextBpm);
    }
  };
  const commitBpmInput = () => {
    if (!bpmInputValue.trim()) {
      setBpmInputValue(String(playbackBpm));
      return;
    }

    const nextBpm = Number(bpmInputValue);
    if (Number.isFinite(nextBpm)) {
      setBpm(nextBpm);
      return;
    }

    setBpmInputValue(String(playbackBpm));
  };
  const tapBpm = () => {
    const now = Date.now();
    const recentTaps = [...tapTempoTimes.current.filter((time) => now - time <= 3000), now].slice(-5);
    tapTempoTimes.current = recentTaps;
    if (recentTaps.length < 2) return;

    const intervals = recentTaps
      .slice(1)
      .map((time, index) => time - recentTaps[index])
      .filter((interval) => interval >= 250 && interval <= 2000);
    if (intervals.length === 0) return;

    const averageInterval = intervals.reduce((total, interval) => total + interval, 0) / intervals.length;
    setBpm(60000 / averageInterval);
  };
  const setTransposition = (nextTransposition: number) =>
    onTranspositionChange(song.id, normalizeTransposition(nextTransposition));

  const advancePlaybackLine = () => {
    if (playbackLines.length === 0) return;
    const nextLine =
      activeLineIndex >= 0 && activeLineIndex < playbackLines.length - 1
        ? playbackLines[activeLineIndex + 1]
        : playbackLines[0];
    setIsIntroActive(false);
    introStartedAt.current = null;
    lineStartedAt.current = Date.now();
    setPlaybackTick(Date.now());
    onPlaybackPositionChange(playbackLineToPosition(nextLine));
  };

  const handleTouchStart = (event: TouchEvent<HTMLElement>) => {
    const touch = event.touches[0];
    if (!touch) return;
    swipeStart.current = { x: touch.clientX, y: touch.clientY };
  };

  const handleTouchEnd = (event: TouchEvent<HTMLElement>) => {
    const start = swipeStart.current;
    swipeStart.current = null;
    if (!start) return;

    const touch = event.changedTouches[0];
    if (!touch) return;

    const deltaX = touch.clientX - start.x;
    const deltaY = touch.clientY - start.y;
    const horizontalDistance = Math.abs(deltaX);
    const verticalDistance = Math.abs(deltaY);

    if (horizontalDistance < 88 || horizontalDistance < verticalDistance * 1.45) return;
    onBack();
  };

  return (
    <section
      className={`song-view preset-${settings.viewPreset} ${settings.splitSections ? 'split-sections' : ''}`}
      onTouchStart={handleTouchStart}
      onTouchEnd={handleTouchEnd}
      onTouchCancel={() => {
        swipeStart.current = null;
      }}
    >
      <div className="song-header">
        <button onClick={onBack} className="toolbar-button">Назад к списку</button>
        <div>
          <p className="eyebrow">Песня №{song.number}</p>
          <h1>{song.title}</h1>
          <div className="song-meta-row">
            <p className="view-preset-chip">{viewPresetLabels[settings.viewPreset]}</p>
            <div className="song-transpose-control" aria-label="Транспонирование этой песни">
              <button
                type="button"
                onClick={() => setTransposition(settings.transposition - 1)}
                aria-label="Понизить тональность этой песни"
              >
                -
              </button>
              <span>{settings.transposition > 0 ? `+${settings.transposition}` : settings.transposition}</span>
              <button
                type="button"
                onClick={() => setTransposition(settings.transposition + 1)}
                aria-label="Повысить тональность этой песни"
              >
                +
              </button>
              <button
                type="button"
                onClick={() => setTransposition(0)}
                disabled={settings.transposition === 0}
                aria-label="Сбросить тональность этой песни"
              >
                0
              </button>
            </div>
            <div
              className={`playback-control ${isAutoPlaying ? 'is-running' : ''}`}
              style={playbackProgressStyle}
              aria-label="Автоматический переход строк"
            >
              <button
                type="button"
                className={`playback-toggle ${isAutoPlaying ? 'is-active' : ''}`}
                onClick={toggleAutoPlayback}
                aria-pressed={isAutoPlaying}
                disabled={playbackLines.length === 0}
              >
                {isAutoPlaying ? 'Пауза' : 'Авто'}
              </button>
              <span title={playbackStatus}>
                {playbackTimingLabel}
              </span>
              {activePlaybackLine ? (
                <button
                  type="button"
                  className="playback-jump"
                  onClick={scrollToActiveLine}
                  aria-label={`Вернуться к текущей строке: ${activePlaybackLine.sectionTitle}, строка ${
                    activePlaybackLine.lineIndex + 1
                  }`}
                >
                  К строке
                </button>
              ) : null}
            </div>
          </div>
        </div>
      </div>

      <div className="song-sections">
        {song.verses.map((verse, index) => (
          <Section
            key={`verse-${index}`}
            sectionId={`verse-${index}`}
            songId={song.id}
            title={index === 0 ? 'Куплет 1' : `Куплет ${index + 1}`}
            rows={verse.rows}
            chords={verse.chords}
            settings={settings}
            playbackPosition={activePosition}
            registerLine={registerLine}
            onPlaybackPositionChange={onPlaybackPositionChange}
          />
        ))}

        {song.chorus ? (
          <Section
            sectionId="chorus"
            songId={song.id}
            title="Припев"
            rows={song.chorus.rows}
            chords={song.chorus.chords}
            settings={settings}
            playbackPosition={activePosition}
            registerLine={registerLine}
            onPlaybackPositionChange={onPlaybackPositionChange}
          />
        ) : null}
        {settings.repeatChorus && song.chorus
          ? song.verses.slice(1).map((verse, index) => (
              <Section
                key={`repeat-${index}-${verse.rows[0]}`}
                sectionId={`repeat-chorus-${index}`}
                songId={song.id}
                title="Припев"
                rows={song.chorus!.rows}
                chords={song.chorus!.chords}
                settings={settings}
                playbackPosition={activePosition}
                registerLine={registerLine}
                onPlaybackPositionChange={onPlaybackPositionChange}
              />
            ))
          : null}

        {song.bridge ? (
          <Section
            sectionId="bridge"
            songId={song.id}
            title="Мост"
            rows={song.bridge.rows}
            chords={song.bridge.chords}
            settings={settings}
            playbackPosition={activePosition}
            registerLine={registerLine}
            onPlaybackPositionChange={onPlaybackPositionChange}
          />
        ) : null}
      </div>

      {settings.showPlaybackDock ? (
        <div className={`song-playback-dock ${isAutoPlaying ? 'is-running' : ''}`} style={playbackProgressStyle}>
          <div className="song-playback-dock-main">
            <strong>{playbackTimingLabel}</strong>
            <span>{isAutoPlaying ? 'Автолистание включено' : 'Ручное управление строкой'}</span>
          </div>
          <div className="song-playback-dock-actions">
            <button
              type="button"
              className={`playback-dock-button ${isAutoPlaying ? 'is-active' : ''}`}
              onClick={toggleAutoPlayback}
              aria-pressed={isAutoPlaying}
              disabled={playbackLines.length === 0}
            >
              {isAutoPlaying ? 'Стоп' : 'Пуск'}
            </button>
            <button type="button" className="playback-dock-button" onClick={advancePlaybackLine} disabled={playbackLines.length === 0}>
              Далее
            </button>
            <button type="button" className="playback-dock-button" onClick={tapBpm}>
              Tap
            </button>
            <div className="playback-bpm-control" aria-label="Скорость автолистания">
              <button type="button" onClick={() => setBpm(playback.bpm - 2)} disabled={playback.bpm <= MIN_BPM}>
                -
              </button>
              <label>
                <span>BPM</span>
                <input
                  type="number"
                  inputMode="numeric"
                  min={MIN_BPM}
                  max={MAX_BPM}
                  value={bpmInputValue}
                  onChange={(event) => changeBpmInput(event.target.value)}
                  onBlur={commitBpmInput}
                  onKeyDown={(event) => {
                    if (event.key === 'Enter') {
                      event.currentTarget.blur();
                    }
                  }}
                  aria-label="BPM песни"
                />
              </label>
              <button type="button" onClick={() => setBpm(playback.bpm + 2)} disabled={playback.bpm >= MAX_BPM}>
                +
              </button>
            </div>
          </div>
        </div>
      ) : null}
    </section>
  );
};

export default SongView;

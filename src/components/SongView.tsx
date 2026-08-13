import { type CSSProperties, useEffect, useMemo, useRef, useState } from 'react';
import { Song } from '../types/song';
import { transposeSongRows } from '../lib/chords';
import { SongPlaybackPosition, SongSettings } from '../types/song';

type SongViewProps = {
  song: Song;
  settings: SongSettings;
  playbackPosition: SongPlaybackPosition | null;
  initialAutoPlay?: boolean;
  onBack: () => void;
  onPlaybackPositionChange: (position: SongPlaybackPosition) => void;
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
  onPlaybackPositionChange: (position: SongPlaybackPosition) => void;
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
          onClick={() =>
            onPlaybackPositionChange({
              songId,
              sectionId,
              sectionTitle: title,
              lineIndex: index,
              updatedAt: new Date().toISOString(),
            })
          }
          aria-pressed={isActive}
          aria-current={isActive ? 'true' : undefined}
          aria-label={`Отметить текущую строку: ${title}, строка ${index + 1}`}
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
  onPlaybackPositionChange,
}: SongViewProps) => {
  const [isAutoPlaying, setIsAutoPlaying] = useState(initialAutoPlay);
  const [isIntroActive, setIsIntroActive] = useState(initialAutoPlay);
  const [playbackTick, setPlaybackTick] = useState(() => Date.now());
  const lineElements = useRef<Record<string, HTMLButtonElement | null>>({});
  const introStartedAt = useRef<number | null>(initialAutoPlay ? Date.now() : null);
  const lineStartedAt = useRef<number | null>(null);
  const activePosition = playbackPosition?.songId === song.id ? playbackPosition : null;
  const playback = song.playback ?? DEFAULT_PLAYBACK;
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

  return (
    <section className={`song-view preset-${settings.viewPreset} ${settings.splitSections ? 'split-sections' : ''}`}>
      <div className="song-header">
        <button onClick={onBack} className="toolbar-button">Назад к списку</button>
        <div>
          <p className="eyebrow">Песня №{song.number}</p>
          <h1>{song.title}</h1>
          <div className="song-meta-row">
            <p className="view-preset-chip">{viewPresetLabels[settings.viewPreset]}</p>
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
    </section>
  );
};

export default SongView;

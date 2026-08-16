import { type CSSProperties, type FormEvent, type TouchEvent, useEffect, useMemo, useRef, useState } from 'react';
import { Song, SongOrderedSection } from '../types/song';
import {
  findPreferredKeyTransposition,
  normalizeTransposition,
  parseSongKey,
  transposeKeyLabel,
  transposeSongRows,
} from '../lib/chords';
import { SongSubmissionPayload, UserPreferences } from '../lib/catalogApi';
import { fillMissingVerseChords, fillMissingVerseSectionChords } from '../lib/leadSheetTools';
import { SongPlaybackPosition, SongSettings } from '../types/song';

type SongViewProps = {
  song: Song;
  settings: SongSettings;
  playbackPosition: SongPlaybackPosition | null;
  preferences?: UserPreferences;
  initialAutoPlay?: boolean;
  onBack: () => void;
  onShare: (song: Song) => void;
  onTranspositionChange: (songId: string, transposition: number) => void;
  onPlaybackPositionChange: (position: SongPlaybackPosition | null) => void;
  onSubmitEdit: (song: Song, payload: SongSubmissionPayload) => Promise<void>;
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

type SongEditDraft = SongSubmissionPayload & {
  leadSheet: string;
};

const lineKey = (sectionId: string, lineIndex: number) => `${sectionId}:${lineIndex}`;

const playbackLineToPosition = (line: PlaybackLine): SongPlaybackPosition => ({
  songId: line.songId,
  sectionId: line.sectionId,
  sectionTitle: line.sectionTitle,
  lineIndex: line.lineIndex,
  updatedAt: new Date().toISOString(),
});

const getRenderableSections = (song: Song, repeatChorus: boolean): SongOrderedSection[] => {
  if (song.sections?.length) return fillMissingVerseSectionChords(song.sections);
  const sections: SongOrderedSection[] = [];
  song.verses.forEach((verse, index) => {
    sections.push({ ...verse, sectionType: 'verse', title: index === 0 ? 'Куплет 1' : `Куплет ${index + 1}` });
    if (song.chorus && (index === 0 || repeatChorus)) {
      sections.push({ ...song.chorus, sectionType: 'chorus', title: 'Припев' });
    }
  });
  if (song.bridge) sections.push({ ...song.bridge, sectionType: 'bridge', title: 'Мост' });
  return fillMissingVerseSectionChords(sections);
};

const sectionsToLeadSheet = (song: Song): string =>
  getRenderableSections(song, false)
    .map((section) => {
      const rows = section.rows.flatMap((line, index) => {
        const chordLine = section.chords[index]?.join(' ').trim();
        return chordLine ? [chordLine, line] : [line];
      });
      return [`[${section.title}]`, ...rows].join('\n');
    })
    .join('\n\n');

const buildEditDraft = (song: Song): SongEditDraft => ({
  title: song.title,
  category: song.category,
  defaultKey: song.defaultKey || '',
  leadSheet: song.leadSheet || sectionsToLeadSheet(song),
  sheetMusicUrl: song.sheetMusicUrl || '',
  bpm: song.playback?.bpm ?? DEFAULT_PLAYBACK.bpm,
  beatsPerLine: song.playback?.beatsPerLine ?? DEFAULT_PLAYBACK.beatsPerLine,
  introBeats: song.playback?.introBeats ?? DEFAULT_PLAYBACK.introBeats,
  submitterName: '',
  submitterEmail: '',
  note: '',
});

const sectionStableId = (section: SongOrderedSection, index: number) => `${section.sectionType}-${index}`;

const buildPlaybackLines = (song: Song, repeatChorus: boolean): PlaybackLine[] => {
  const lines: PlaybackLine[] = [];
  getRenderableSections(song, repeatChorus).forEach((section, sectionIndex) => {
    const sectionId = sectionStableId(section, sectionIndex);
    section.rows.forEach((_, lineIndex) => {
      lines.push({
        sequenceIndex: lines.length,
        songId: song.id,
        sectionId,
        sectionTitle: section.title,
        lineIndex,
      });
    });
  });
  return lines;
};

const viewPresetLabels: Record<SongSettings['viewPreset'], string> = {
  lead: 'Lead: текст и аккорды',
  singer: 'Singer: крупный текст',
  chords: 'Chords: только аккорды',
};

const inferKeyFromChords = (song: Song): string | undefined => {
  const sections = getRenderableSections(song, false);
  for (const section of sections) {
    for (const row of section.chords) {
      for (const chord of row) {
        const key = parseSongKey(chord);
        if (key) return key.label;
      }
    }
  }

  return undefined;
};

const isImageSheetMusic = (value: string) => /\.(png|jpe?g|webp|gif|svg)(\?|#|$)/i.test(value);

const Section = ({
  title,
  sectionId,
  songId,
  rows,
  chords,
  settings,
  playbackPosition,
  effectiveTransposition,
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
  effectiveTransposition: number;
  registerLine: (key: string, element: HTMLButtonElement | null) => void;
  onPlaybackPositionChange: (position: SongPlaybackPosition | null) => void;
}) => {
  const isChordsOnly = settings.viewPreset === 'chords';
  const rendered = rows.flatMap((row, index) => {
    const chordRow = chords[index] || [];
    const chordText = settings.showChords ? chordRow.join('   ') : '';
    const text = row;
    const isActive = playbackPosition?.sectionId === sectionId && playbackPosition.lineIndex === index;
    if (isChordsOnly && !chordText) return [];

    return [(
      <li
        key={`${title}-${index}`}
        className={`song-line-block ${isChordsOnly ? 'is-chords-only' : ''} ${isActive ? 'is-active' : ''}`}
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
          aria-label={`${isActive ? 'Снять фокус со строки' : 'Отметить текущую строку'}: ${title}, строка ${
            index + 1
          }${isChordsOnly ? `, аккорды ${transposeSongRows([chordText], effectiveTransposition)[0]}` : ''}`}
        >
          {chordText ? (
            <span className="chords">{transposeSongRows([chordText], effectiveTransposition)[0]}</span>
          ) : null}
          {!isChordsOnly ? <span className="line">{text}</span> : null}
        </button>
      </li>
    )];
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
  preferences,
  initialAutoPlay = false,
  onBack,
  onShare,
  onTranspositionChange,
  onPlaybackPositionChange,
  onSubmitEdit,
}: SongViewProps) => {
  const [isAutoPlaying, setIsAutoPlaying] = useState(initialAutoPlay);
  const [isIntroActive, setIsIntroActive] = useState(initialAutoPlay);
  const [playbackTick, setPlaybackTick] = useState(() => Date.now());
  const [playbackBpm, setPlaybackBpm] = useState(() => song.playback?.bpm ?? DEFAULT_PLAYBACK.bpm);
  const [bpmInputValue, setBpmInputValue] = useState(() => String(song.playback?.bpm ?? DEFAULT_PLAYBACK.bpm));
  const [contentMode, setContentMode] = useState<'song' | 'sheet'>('song');
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [editDraft, setEditDraft] = useState<SongEditDraft>(() => buildEditDraft(song));
  const [editError, setEditError] = useState<string | null>(null);
  const [isEditSubmitting, setIsEditSubmitting] = useState(false);
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
  const inferredKey = useMemo(() => inferKeyFromChords(song), [song]);
  const sourceKey = song.defaultKey || inferredKey;
  const preferredTransposition = useMemo(
    () =>
      preferences?.preferredKeys?.length
        ? findPreferredKeyTransposition(sourceKey, preferences.preferredKeys)
        : null,
    [preferences?.preferredKeys, sourceKey],
  );
  const personalTransposition = preferredTransposition?.shift ?? 0;
  const effectiveTransposition = normalizeTransposition(personalTransposition + settings.transposition);
  const renderedKey = transposeKeyLabel(sourceKey, effectiveTransposition);
  const inverseTransposition = normalizeTransposition(-effectiveTransposition);
  const capoValue =
    preferences?.capoEnabled && effectiveTransposition < 0 && Math.abs(effectiveTransposition) <= preferences.maxCapo
      ? Math.abs(effectiveTransposition)
      : null;
  const personalKeyAdvice = preferredTransposition
    ? [
        preferences?.showOriginalKey ? `Оригинал: ${preferredTransposition.originalKey}` : null,
        !song.defaultKey && inferredKey ? `Определено по аккордам: ${inferredKey}` : null,
        renderedKey ? `Сейчас: ${renderedKey}` : `Удобно: ${preferredTransposition.targetKey}`,
        `Сдвиг: ${effectiveTransposition > 0 ? `+${effectiveTransposition}` : effectiveTransposition}`,
        capoValue !== null ? `Capo ${capoValue} для оригинальной высоты` : null,
        preferences?.pianoTransposeEnabled && effectiveTransposition !== 0
          ? `Клавиши transpose ${inverseTransposition > 0 ? `+${inverseTransposition}` : inverseTransposition}`
          : null,
      ]
        .filter(Boolean)
        .join(' · ')
    : sourceKey
      ? [`Тональность: ${sourceKey}`, !song.defaultKey && inferredKey ? 'определена по аккордам' : null]
          .filter(Boolean)
          .join(' · ')
      : null;
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
  const hasSheetMusic = Boolean(song.sheetMusicUrl);
  const isSheetMode = hasSheetMusic && contentMode === 'sheet';

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

  useEffect(() => {
    setContentMode('song');
    setIsEditOpen(false);
    setEditDraft(buildEditDraft(song));
    setEditError(null);
  }, [song.id]);

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

  const updateEditDraft = (key: keyof SongEditDraft, value: string | number) => {
    setEditDraft((current) => ({ ...current, [key]: value }));
  };

  const fillEditDraftChords = () => {
    const nextLeadSheet = fillMissingVerseChords(editDraft.leadSheet);
    setEditDraft((current) => ({ ...current, leadSheet: nextLeadSheet }));
  };

  const submitEdit = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    if (!editDraft.title.trim() || !editDraft.leadSheet.trim()) {
      setEditError('Название и текст обязательны.');
      return;
    }

    setIsEditSubmitting(true);
    setEditError(null);
    try {
      await onSubmitEdit(song, {
        ...editDraft,
        title: editDraft.title.trim(),
        category: editDraft.category.trim() || song.category,
        defaultKey: editDraft.defaultKey.trim(),
        leadSheet: editDraft.leadSheet.trim(),
        sheetMusicUrl: editDraft.sheetMusicUrl?.trim(),
        submitterName: editDraft.submitterName.trim(),
        submitterEmail: editDraft.submitterEmail.trim(),
        note: editDraft.note.trim(),
      });
      setIsEditOpen(false);
    } catch (err) {
      setEditError(err instanceof Error ? err.message : 'Не удалось отправить правку.');
    } finally {
      setIsEditSubmitting(false);
    }
  };

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
        <div className="song-header-actions">
          <button type="button" onClick={() => onShare(song)} className="toolbar-button">Поделиться</button>
          <button type="button" onClick={() => setIsEditOpen(true)} className="toolbar-button">Править</button>
        </div>
        <div>
          <p className="eyebrow">Песня №{song.number}</p>
          <h1>{song.title}</h1>
          <div className="song-meta-row">
            <p className="view-preset-chip">{viewPresetLabels[settings.viewPreset]}</p>
            {hasSheetMusic ? (
              <div className="song-mode-toggle" aria-label="Режим отображения песни">
                <button type="button" className={!isSheetMode ? 'is-active' : ''} onClick={() => setContentMode('song')} aria-pressed={!isSheetMode}>Текст</button>
                <button type="button" className={isSheetMode ? 'is-active' : ''} onClick={() => setContentMode('sheet')} aria-pressed={isSheetMode}>Ноты</button>
              </div>
            ) : null}
            <div className="song-transpose-control" aria-label="Транспонирование этой песни">
              <button
                type="button"
                onClick={() => setTransposition(settings.transposition - 1)}
                aria-label="Понизить тональность этой песни"
              >
                -
              </button>
              <span>{effectiveTransposition > 0 ? `+${effectiveTransposition}` : effectiveTransposition}</span>
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
          {personalKeyAdvice ? <p className="personal-key-advice">{personalKeyAdvice}</p> : null}
        </div>
      </div>

      {isSheetMode && song.sheetMusicUrl ? (
        <div className="song-sheet-music">
          <div className="song-sheet-frame">
            {isImageSheetMusic(song.sheetMusicUrl) ? (
              <img src={song.sheetMusicUrl} alt={`Ноты: ${song.title}`} loading="lazy" />
            ) : (
              <iframe src={song.sheetMusicUrl} title={`Ноты: ${song.title}`} loading="lazy" />
            )}
          </div>
          <a className="song-sheet-link" href={song.sheetMusicUrl} target="_blank" rel="noreferrer">Открыть ноты отдельно</a>
        </div>
      ) : (
        <div className="song-sections">
          {getRenderableSections(song, settings.repeatChorus).map((section, index) => (
            <Section
              key={`${section.title}-${index}`}
              sectionId={sectionStableId(section, index)}
              songId={song.id}
              title={section.title}
              rows={section.rows}
              chords={section.chords}
              settings={settings}
              playbackPosition={activePosition}
              effectiveTransposition={effectiveTransposition}
              registerLine={registerLine}
              onPlaybackPositionChange={onPlaybackPositionChange}
            />
          ))}
        </div>
      )}

      {isEditOpen ? (
        <div
          className="sheet-backdrop"
          onClick={(event) => {
            if (event.target === event.currentTarget && !isEditSubmitting) setIsEditOpen(false);
          }}
        >
          <section className="bottom-sheet submission-sheet song-edit-sheet" role="dialog" aria-modal="true" aria-labelledby="song-edit-title">
            <div className="sheet-header">
              <h2 id="song-edit-title">Предложить правку</h2>
              <button type="button" className="sheet-close" onClick={() => setIsEditOpen(false)} disabled={isEditSubmitting}>
                Закрыть
              </button>
            </div>
            {editError ? <div className="error">{editError}</div> : null}
            <form className="submission-form" onSubmit={submitEdit}>
              <label className="submission-field">
                <span>Название</span>
                <input value={editDraft.title} onChange={(event) => updateEditDraft('title', event.target.value)} disabled={isEditSubmitting} />
              </label>
              <div className="submission-grid">
                <label className="submission-field">
                  <span>Категория</span>
                  <input value={editDraft.category} onChange={(event) => updateEditDraft('category', event.target.value)} disabled={isEditSubmitting} />
                </label>
                <label className="submission-field">
                  <span>Тональность</span>
                  <input value={editDraft.defaultKey} onChange={(event) => updateEditDraft('defaultKey', event.target.value)} disabled={isEditSubmitting} placeholder="G, Am..." />
                </label>
              </div>
              <div className="admin-inline-actions">
                <button type="button" className="sheet-secondary" onClick={fillEditDraftChords} disabled={isEditSubmitting}>
                  Дополнить аккорды из первого куплета
                </button>
              </div>
              <label className="submission-field">
                <span>Текст с аккордами</span>
                <textarea
                  value={editDraft.leadSheet}
                  onChange={(event) => updateEditDraft('leadSheet', event.target.value)}
                  disabled={isEditSubmitting}
                  rows={14}
                />
              </label>
              <label className="submission-field">
                <span>Ссылка на ноты</span>
                <input value={editDraft.sheetMusicUrl || ''} onChange={(event) => updateEditDraft('sheetMusicUrl', event.target.value)} disabled={isEditSubmitting} placeholder="https://...pdf или https://...jpg" />
              </label>
              <div className="submission-grid submission-grid-three">
                <label className="submission-field">
                  <span>BPM</span>
                  <input type="number" min={40} max={220} value={editDraft.bpm} onChange={(event) => updateEditDraft('bpm', Number(event.target.value))} disabled={isEditSubmitting} />
                </label>
                <label className="submission-field">
                  <span>Долей на строку</span>
                  <input type="number" min={1} max={16} value={editDraft.beatsPerLine} onChange={(event) => updateEditDraft('beatsPerLine', Number(event.target.value))} disabled={isEditSubmitting} />
                </label>
                <label className="submission-field">
                  <span>Вступление</span>
                  <input type="number" min={0} max={64} value={editDraft.introBeats} onChange={(event) => updateEditDraft('introBeats', Number(event.target.value))} disabled={isEditSubmitting} />
                </label>
              </div>
              <div className="submission-grid">
                <label className="submission-field">
                  <span>Имя</span>
                  <input value={editDraft.submitterName} onChange={(event) => updateEditDraft('submitterName', event.target.value)} disabled={isEditSubmitting} />
                </label>
                <label className="submission-field">
                  <span>Email</span>
                  <input type="email" value={editDraft.submitterEmail} onChange={(event) => updateEditDraft('submitterEmail', event.target.value)} disabled={isEditSubmitting} />
                </label>
              </div>
              <label className="submission-field">
                <span>Комментарий</span>
                <textarea value={editDraft.note} onChange={(event) => updateEditDraft('note', event.target.value)} disabled={isEditSubmitting} rows={3} />
              </label>
              <p className="submission-help">Правка попадёт в заявки админки. В каталоге она появится только после апрува.</p>
              <div className="sheet-actions">
                <button type="button" className="sheet-secondary" onClick={() => setIsEditOpen(false)} disabled={isEditSubmitting}>
                  Отмена
                </button>
                <button type="submit" className="sheet-primary" disabled={isEditSubmitting}>
                  {isEditSubmitting ? 'Отправка...' : 'Отправить правку'}
                </button>
              </div>
            </form>
          </section>
        </div>
      ) : null}

      {settings.showPlaybackDock && !isSheetMode ? (
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

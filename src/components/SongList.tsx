import { useEffect, useMemo, useState } from 'react';
import { Song, SongCollection } from '../types/song';

type SongListMode = 'all' | 'recent' | 'collection' | 'live';

type SongListProps = {
  songs: Song[];
  query: string;
  onQuery: (value: string) => void;
  onOpen: (songId: string) => void;
  categories: { name: string; count: number }[];
  activeCategory: string | null;
  onCategoryChange: (category: string | null) => void;
  initialCategoryPickerOpen?: boolean;
  mode: SongListMode;
  onModeChange: (mode: SongListMode) => void;
  totalCount: number;
  recentCount: number;
  canUseCollections: boolean;
  canUseLive: boolean;
  collections: SongCollection[];
  activeCollectionId: string | null;
  liveCollectionId: string | null;
  liveCollections: SongCollection[];
  activeLiveSongId: string | null;
  liveSongIds: string[];
  liveSourceSongs: Song[];
  collectionCounts: Record<string, number>;
  activeCollectionSongIds: string[];
  onCollectionSelect: (collectionId: string) => void;
  onDeleteCollection: (collectionId: string) => void;
  onCreateCollection: () => void;
  onShareCollection: (collectionId: string) => void;
  onOpenPresenter: () => void;
  onLiveCollectionChange: (collectionId: string | null) => void;
  onLiveCollectionSelect: (collectionId: string) => void;
  onCreateLiveCollection: () => void;
  onDeleteLiveCollection: (collectionId: string) => void;
  onLiveSongChange: (songId: string | null) => void;
  onAddLiveSong: (songId: string) => void;
  onRemoveLiveSong: (songId: string) => void;
  onMoveLiveSong: (songId: string, direction: -1 | 1) => void;
  onResetLiveSongs: () => void;
  onShareLive: () => void;
  onToggleSongCollection: (songId: string) => void;
  onRequireAccount: () => void;
};

const QUICK_CATEGORY_LIMIT = 1;

const HistoryIcon = () => (
  <svg className="history-icon" viewBox="0 0 24 24" aria-hidden="true">
    <path
      d="M4.75 11.5a7.25 7.25 0 1 1 2.12 5.13M4.75 11.5V6.75M4.75 11.5H9.5M12 7.75v4.5l3 1.75"
      fill="none"
      stroke="currentColor"
      strokeLinecap="round"
      strokeLinejoin="round"
      strokeWidth="2"
    />
  </svg>
);

const SongList = ({
  songs,
  query,
  onQuery,
  onOpen,
  categories,
  activeCategory,
  onCategoryChange,
  initialCategoryPickerOpen = false,
  mode,
  onModeChange,
  totalCount,
  recentCount,
  canUseCollections,
  canUseLive,
  collections,
  activeCollectionId,
  liveCollectionId,
  liveCollections,
  activeLiveSongId,
  liveSongIds,
  liveSourceSongs,
  collectionCounts,
  activeCollectionSongIds,
  onCollectionSelect,
  onDeleteCollection,
  onCreateCollection,
  onShareCollection,
  onOpenPresenter,
  onLiveCollectionChange,
  onLiveCollectionSelect,
  onCreateLiveCollection,
  onDeleteLiveCollection,
  onLiveSongChange,
  onAddLiveSong,
  onRemoveLiveSong,
  onMoveLiveSong,
  onResetLiveSongs,
  onShareLive,
  onToggleSongCollection,
  onRequireAccount,
}: SongListProps) => {
  const [isCategoryPickerOpen, setIsCategoryPickerOpen] = useState(initialCategoryPickerOpen);
  const [categoryQuery, setCategoryQuery] = useState('');
  const [liveSourceQuery, setLiveSourceQuery] = useState('');
  const [openLiveSongMenuId, setOpenLiveSongMenuId] = useState<string | null>(null);
  const hasCategoryOverflow = categories.length > QUICK_CATEGORY_LIMIT;
  const quickCategories = useMemo(() => {
    if (!hasCategoryOverflow) return categories;

    const sorted = [
      ...categories.filter((category) => category.name === activeCategory),
      ...categories.filter((category) => category.name !== activeCategory),
    ];

    return sorted.slice(0, QUICK_CATEGORY_LIMIT);
  }, [activeCategory, categories, hasCategoryOverflow]);
  const filteredCategories = useMemo(() => {
    const normalized = categoryQuery.trim().toLowerCase();
    if (!normalized) return categories;
    return categories.filter((category) => category.name.toLowerCase().includes(normalized));
  }, [categories, categoryQuery]);
  const selectCategory = (category: string | null) => {
    onCategoryChange(category);
    setIsCategoryPickerOpen(false);
    setCategoryQuery('');
  };
  const isLiveMode = mode === 'live' && canUseLive;
  const activeCollection = collections.find((collection) => collection.id === activeCollectionId) ?? null;
  const activePlaybackIndex = isLiveMode
    ? songs.findIndex((song) => song.id === activeLiveSongId)
    : -1;
  const nextPlaybackSongId =
    activePlaybackIndex >= 0 && activePlaybackIndex < songs.length - 1 ? songs[activePlaybackIndex + 1].id : null;
  const liveAdvanceSongId =
    isLiveMode && activePlaybackIndex < 0 ? songs[0]?.id ?? null : nextPlaybackSongId;
  const liveAdvanceLabel = activePlaybackIndex < 0 ? 'Начать' : 'Далее';
  const filteredLiveSourceSongs = useMemo(() => {
    const normalized = liveSourceQuery.trim().toLowerCase();
    if (!normalized) return liveSourceSongs;

    return liveSourceSongs.filter((song) =>
      [song.title, song.category, ...(song.authors ?? []), String(song.number)].join(' ').toLowerCase().includes(normalized),
    );
  }, [liveSourceQuery, liveSourceSongs]);

  useEffect(() => {
    if (!openLiveSongMenuId) return undefined;

    const closeOnOutsidePointer = (event: PointerEvent) => {
      const target = event.target as Element | null;
      if (target?.closest('.live-song-menu')) return;
      setOpenLiveSongMenuId(null);
    };
    const closeOnEscape = (event: KeyboardEvent) => {
      if (event.key === 'Escape') {
        setOpenLiveSongMenuId(null);
      }
    };

    document.addEventListener('pointerdown', closeOnOutsidePointer);
    document.addEventListener('keydown', closeOnEscape);

    return () => {
      document.removeEventListener('pointerdown', closeOnOutsidePointer);
      document.removeEventListener('keydown', closeOnEscape);
    };
  }, [openLiveSongMenuId]);

  return (
    <div className="catalog">
      {!isLiveMode ? (
        <>
          <div className="catalog-search-sticky">
            <label className="search-label sr-only" htmlFor="song-search">
              Поиск
            </label>
            <div className="search-field">
              <input
                id="song-search"
                value={query}
                onChange={(event) => onQuery(event.target.value)}
                placeholder="Поиск"
                className="search"
                aria-label="Поиск песни"
              />
              {query.trim().length > 0 ? (
                <button type="button" className="search-clear" onClick={() => onQuery('')} aria-label="Очистить поиск">
                  ×
                </button>
              ) : null}
            </div>
          </div>

          <div className="folder-strip" aria-label="Сборники и фильтры">
            <button
              className={`folder-chip ${mode === 'all' ? 'is-selected' : ''}`}
              onClick={() => onModeChange('all')}
              aria-pressed={mode === 'all'}
            >
              Все <span>{totalCount}</span>
            </button>
            {canUseCollections ? collections.map((collection) => (
              <span
                key={collection.id}
                className={`folder-chip collection-chip ${
                  mode === 'collection' && activeCollectionId === collection.id ? 'is-selected' : ''
                }`}
              >
                <button
                  type="button"
                  className="collection-chip-main"
                  onClick={() => onCollectionSelect(collection.id)}
                  aria-pressed={mode === 'collection' && activeCollectionId === collection.id}
                >
                  <span className="collection-chip-title">{collection.name}</span>
                  <span className="collection-chip-count">{collectionCounts[collection.id] ?? 0}</span>
                  {collection.isOwner === false ? (
                    <small className="collection-chip-meta">{collection.authorName ? `Автор: ${collection.authorName}` : 'Подписка'}</small>
                  ) : null}
                </button>
                {collection.isOwner !== false ? (
                  <button
                    type="button"
                    className="collection-chip-remove"
                    onClick={() => onDeleteCollection(collection.id)}
                    aria-label={`Удалить сборник ${collection.name}`}
                    title="Удалить сборник"
                  >
                    ×
                  </button>
                ) : null}
              </span>
            )) : null}
            {canUseCollections ? (
              <button className="folder-chip folder-create" onClick={onCreateCollection}>
                + Сборник
              </button>
            ) : null}
            <button
              className={`folder-chip history-chip ${mode === 'recent' ? 'is-selected' : ''}`}
              onClick={() => onModeChange('recent')}
              aria-pressed={mode === 'recent'}
              aria-label="Недавние песни"
              title="Недавние песни"
            >
              <HistoryIcon />
              <span>{recentCount}</span>
            </button>
            {songs.length > 0 && mode !== 'collection' ? (
              <button className="folder-chip" type="button" onClick={onOpenPresenter}>
                Презентация
              </button>
            ) : null}
          </div>
          {!canUseCollections ? (
            <div className="account-benefits-card">
              <span>
                <strong>Войдите, чтобы собрать свои песни</strong>
                <small>Личные сборники, подписки по ссылке и live сохраняются в аккаунте и открываются на другом телефоне.</small>
              </span>
              <button type="button" onClick={onRequireAccount}>
                Что дает вход
              </button>
            </div>
          ) : null}
          {mode === 'collection' && activeCollection ? (
            <div className="live-list-card">
              <span>
                <strong>{activeCollection.name}</strong>
                <small>
                  {activeCollection.songIds.length} песен
                  {activeCollection.authorName ? ` · автор: ${activeCollection.authorName}` : ''}
                  {activeCollection.isOwner === false ? ' · только чтение' : ''}
                </small>
              </span>
              <div className="live-list-actions">
                <button type="button" className="live-list-button live-list-button-secondary" onClick={onOpenPresenter}>
                  Презентация
                </button>
                <button type="button" className="live-list-button" onClick={() => onShareCollection(activeCollection.id)}>
                  Поделиться
                </button>
              </div>
            </div>
          ) : null}
        </>
      ) : null}

      {isLiveMode ? (
        <>
          <div className="folder-strip" aria-label="Live сборники">
            <button className="folder-chip folder-create" onClick={onCreateLiveCollection}>
              + Live сборник
            </button>
            {liveCollections.map((collection) => (
              <span
                key={collection.id}
                className={`folder-chip collection-chip ${liveCollectionId === collection.id ? 'is-selected' : ''}`}
              >
                <button
                  type="button"
                  className="collection-chip-main"
                  onClick={() => onLiveCollectionSelect(collection.id)}
                  aria-pressed={liveCollectionId === collection.id}
                >
                  <span className="collection-chip-title">{collection.name}</span>
                  <span className="collection-chip-count">{collection.songIds.length}</span>
                </button>
                <button
                  type="button"
                  className="collection-chip-remove"
                  onClick={() => onDeleteLiveCollection(collection.id)}
                  aria-label={`Удалить live-сборник ${collection.name}`}
                  title="Удалить live-сборник"
                >
                  ×
                </button>
              </span>
            ))}
          </div>
          <div className="live-list-card is-stage">
            <span>
              <strong>{liveSongIds.length > 0 ? 'Очередь' : 'Очередь пуста'}</strong>
              <small>{liveSongIds.length > 0 ? `${liveSongIds.length} песен выбрано` : 'Выберите песни ниже'}</small>
            </span>
            <div className="live-list-actions">
              {liveAdvanceSongId ? (
                <button
                  type="button"
                  className="live-list-button live-list-button-secondary"
                  onClick={() => onLiveSongChange(liveAdvanceSongId)}
                  aria-label={`${liveAdvanceLabel} live-песню`}
                >
                  {liveAdvanceLabel}
                </button>
              ) : null}
              {liveSongIds.length > 0 ? (
                <>
                  <button type="button" className="live-list-button live-list-button-secondary" onClick={onResetLiveSongs}>
                    Сбросить
                  </button>
                  <button type="button" className="live-list-button live-list-button-secondary" onClick={onShareLive}>
                    Поделиться
                  </button>
                  <button type="button" className="live-list-button live-list-button-secondary" onClick={onOpenPresenter}>
                    Презентация
                  </button>
                </>
              ) : null}
              <button
                type="button"
                className="live-list-button"
                onClick={() => {
                  onLiveCollectionChange(null);
                  onLiveSongChange(null);
                  onResetLiveSongs();
                  onModeChange('all');
                }}
              >
                Завершить
              </button>
            </div>
          </div>
        </>
      ) : null}

      {!isLiveMode && categories.length > 1 ? (
        <div className="category-strip" aria-label="Категории песен">
          <button
            className={`category-chip ${activeCategory === null ? 'is-selected' : ''}`}
            onClick={() => selectCategory(null)}
            aria-pressed={activeCategory === null}
          >
            Все
          </button>
          {quickCategories.map((category) => (
            <button
              key={category.name}
              className={`category-chip ${activeCategory === category.name ? 'is-selected' : ''}`}
              onClick={() => selectCategory(category.name)}
              aria-pressed={activeCategory === category.name}
            >
              {category.name}
            </button>
          ))}
          {hasCategoryOverflow ? (
            <button
              className="category-chip category-more"
              onClick={() => setIsCategoryPickerOpen(true)}
              aria-haspopup="dialog"
              aria-expanded={isCategoryPickerOpen}
              aria-label="Выбрать категорию"
            >
              ...
            </button>
          ) : null}
        </div>
      ) : null}

      <ul className="song-list" aria-label="Список песен">
        {songs.length === 0 ? (
          <li className="empty">
            {mode === 'live'
              ? 'Live список пуст. Добавьте песни из каталога ниже.'
              : mode === 'recent'
              ? 'Недавних песен пока нет.'
              : mode === 'collection'
                ? 'В этом сборнике пока нет песен.'
                : 'Каталог пока пуст.'}
          </li>
        ) : (
          songs.map((song, songIndex) => {
            const isInActiveCollection = mode === 'collection' && activeCollectionSongIds.includes(song.id);
            const isInAnyCollection = collections.some((collection) => collection.songIds.includes(song.id));
            const isNowPlaying = isLiveMode && song.id === activeLiveSongId;
            const isNextPlaying = isLiveMode && song.id === nextPlaybackSongId;

            return (
              <li
                key={song.id}
                className={`song-item ${isNowPlaying ? 'is-now-playing' : ''} ${
                  isNextPlaying ? 'is-next-playing' : ''
                }`}
              >
                <button
                  className="song-main"
                  onClick={() => {
                    if (isLiveMode) {
                      onLiveSongChange(song.id);
                    }
                    onOpen(song.id);
                  }}
                >
                  <span className="song-number">{song.number}</span>
                  <span className="song-title-block">
                    <span className="song-title">{song.title}</span>
                    {song.authors?.length ? <small className="song-authors">{song.authors.join(', ')}</small> : null}
                  </span>
                  {isNowPlaying ? <span className="live-song-badge">Сейчас</span> : null}
                  {isNextPlaying ? <span className="live-song-badge">Далее</span> : null}
                </button>
                {isLiveMode ? (
                  <details
                    className="live-song-menu"
                    open={openLiveSongMenuId === song.id}
                    onToggle={(event) => {
                      setOpenLiveSongMenuId(event.currentTarget.open ? song.id : null);
                    }}
                  >
                    <summary className="collection-btn live-song-menu-trigger" aria-label="Действия live-песни">
                      <span aria-hidden="true" />
                      <span aria-hidden="true" />
                      <span aria-hidden="true" />
                    </summary>
                    <div className="live-song-menu-panel">
                      <button
                        type="button"
                        className="live-song-menu-action"
                        onClick={() => {
                          onMoveLiveSong(song.id, -1);
                          setOpenLiveSongMenuId(null);
                        }}
                        disabled={songIndex === 0}
                      >
                        Выше
                      </button>
                      <button
                        type="button"
                        className="live-song-menu-action"
                        onClick={() => {
                          onMoveLiveSong(song.id, 1);
                          setOpenLiveSongMenuId(null);
                        }}
                        disabled={songIndex === songs.length - 1}
                      >
                        Ниже
                      </button>
                      <button
                        type="button"
                        className="live-song-menu-action is-danger"
                        onClick={() => {
                          onRemoveLiveSong(song.id);
                          setOpenLiveSongMenuId(null);
                        }}
                      >
                        Убрать
                      </button>
                    </div>
                  </details>
                ) : canUseCollections ? (
                  <button
                    className={`collection-btn ${isInAnyCollection ? 'is-selected' : ''}`}
                    onClick={() => onToggleSongCollection(song.id)}
                    aria-label={isInAnyCollection ? 'Изменить сборники песни' : 'Добавить в сборник'}
                  >
                    {isInActiveCollection || isInAnyCollection ? '✓' : '+'}
                  </button>
                ) : null}
              </li>
            );
          })
        )}
      </ul>

      {isLiveMode && liveSourceSongs.length > 0 ? (
        <section className="live-source-panel" aria-label="Все песни для live">
          <div className="live-source-title">
            <strong>Все песни</strong>
            <span>
              {filteredLiveSourceSongs.length}
              {liveSourceQuery.trim() ? `/${liveSourceSongs.length}` : ''}
            </span>
          </div>
          <label className="search-label sr-only" htmlFor="live-source-search">
            Поиск по каталогу
          </label>
          <input
            id="live-source-search"
            value={liveSourceQuery}
            onChange={(event) => setLiveSourceQuery(event.target.value)}
            placeholder="Найти песню для live"
            className="live-source-search"
            aria-label="Поиск песни для live"
          />
          <div className="live-source-list">
            {filteredLiveSourceSongs.length === 0 ? (
              <div className="empty live-source-empty">Песни не найдены.</div>
            ) : null}
            {filteredLiveSourceSongs.map((song) => {
              const isAdded = liveSongIds.includes(song.id);

              return (
                <button
                  key={song.id}
                  className={`live-source-song ${isAdded ? 'is-added' : ''}`}
                  onClick={() => onAddLiveSong(song.id)}
                  disabled={isAdded}
                  aria-label={isAdded ? `${song.title} уже в live` : `Добавить ${song.title} в live`}
                >
                  <span>{song.number}</span>
                  <strong>
                    {song.title}
                    {song.authors?.length ? <small>{song.authors.join(', ')}</small> : null}
                  </strong>
                  <b>{isAdded ? 'В live' : '+'}</b>
                </button>
              );
            })}
          </div>
        </section>
      ) : null}

      {isCategoryPickerOpen ? (
        <div
          className="sheet-backdrop"
          onClick={(event) => {
            if (event.target === event.currentTarget) {
              setIsCategoryPickerOpen(false);
            }
          }}
        >
          <section className="bottom-sheet" role="dialog" aria-modal="true" aria-labelledby="category-picker-title">
            <div className="sheet-header">
              <h2 id="category-picker-title">Категория</h2>
              <button className="sheet-close" onClick={() => setIsCategoryPickerOpen(false)} aria-label="Закрыть">
                Закрыть
              </button>
            </div>

            <label className="sr-only" htmlFor="category-search">
              Поиск категории
            </label>
            <input
              id="category-search"
              className="collection-name-input"
              value={categoryQuery}
              onChange={(event) => setCategoryQuery(event.target.value)}
              placeholder="Поиск категории"
              autoFocus
            />

            <div className="collection-choice-list category-picker-list">
              <button className="collection-choice" onClick={() => selectCategory(null)} aria-pressed={activeCategory === null}>
                <span>
                  <strong>Все</strong>
                  <small>{totalCount} песен</small>
                </span>
                <b aria-hidden="true">{activeCategory === null ? '✓' : ''}</b>
              </button>
              {filteredCategories.map((category) => (
                <button
                  key={category.name}
                  className="collection-choice"
                  onClick={() => selectCategory(category.name)}
                  aria-pressed={activeCategory === category.name}
                >
                  <span>
                    <strong>{category.name}</strong>
                    <small>{category.count} песен</small>
                  </span>
                  <b aria-hidden="true">{activeCategory === category.name ? '✓' : ''}</b>
                </button>
              ))}
            </div>
          </section>
        </div>
      ) : null}
    </div>
  );
};

export default SongList;

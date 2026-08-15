# Архитектура (проектный контур)

## Контексты
- **Catalog** — единый каталог песен, фильтры, поиск, snapshot для PWA.
- **Admin Catalog** — backend-only управление песнями, импорт/экспорт, публикация версий каталога.
- **Playback View** — отображение текста, аккордов, режим чтения.
- **User Settings** — режим отображения (аккорды, размер, тональность, repeat).
- **Backend API** — read-only catalog API в ранней фазе, admin mutation API только после auth-решения.
- **MySQL Storage** — источник истины для каталога, будущих пользователей, сборников, setlists, live-сессий.
- **Live Foundation** — планируется в фазах 2/3.

## Целевая структура папок
- `src/app` — инициализация, роутинг, провайдеры.
- `src/features/songs` — модель `Song`, репозиторий, сервис импорта, хуки.
- `src/features/view` — экран списка и экран песни.
- `src/features/settings` — настройки отображения.
- `src/features/collections` — сборники, недавние песни и быстрые фильтры.
- `src/storage` — IndexedDB + миграции схемы + fallback на localStorage.
- `src/live` — отдельный слой, не включать в фазы 1.
- `backend` — будущий backend service, не создавать публичные mutation API без отдельного решения.
- `migrations` — будущие MySQL migrations с rollback notes.

## Модель данных (предлагаемая)
- `Song`
  - `id`
  - `title`
  - `number`
  - `sections[]` (verse/chorus/bridge)
  - `lines[]` (текст строки)
  - `chords[]` (рядом со строками)
  - `metadata{}` (тема, тональность, теги, порядок)

- `SessionConfig`
  - `showChords`, `transposition`, `repeatChorus`, `fontScale`, `theme`

- `Preset`
  - `name`
  - `showChords`
  - `includeSections`

## Данные и кэш
- Phase 1 источник данных: встроенный generated bundled-каталог приложения.
- Phase 1.5 источник истины: MySQL + backend catalog API.
- PWA хранит локальный snapshot опубликованной версии каталога.
- Импорт/экспорт каталога: admin-only backend/admin сценарий, не обычный пользовательский flow.
- Версионирование каталога: `catalogVersion` + `lastUpdated` для контроля обновлений.
- Недавние песни остаются локальным пользовательским состоянием до появления user accounts.
- Текущая позиция песни (`songId`, `sectionId`, `lineIndex`) хранится локально как playback foundation и не синхронизируется с backend до фазы live.

## Offline-first стратегия
1. На первом старте загружается shell PWA и generated bundled-каталог.
2. Если backend доступен — PWA проверяет текущую опубликованную версию каталога.
3. Если версия изменилась или backend отдаёт валидный snapshot — PWA скачивает `/api/catalog/snapshot` и сохраняет его локально.
4. Интерфейс работает без интернета на последнем локальном snapshot, а при его отсутствии — на bundled-каталоге.
5. Backend недоступность не блокирует список песен и открытие песни.
6. Пользователь видит статусы источника/сети/sync/последнего обновления и может жестом pull-to-refresh запросить обновление каталога, но это не заменяет offline fallback.

## PWA shell caching
- Service worker precache генерируется после `vite build` через `scripts/generate-sw.mjs`.
- В precache входят `/`, manifest, icon и hashed assets из `dist`.
- `/api/*` намеренно не кэшируется service worker-ом, чтобы не смешивать HTTP cache и IndexedDB snapshot.
- `sw.js` должен отдаваться без долгого cache-control, иначе обновление app shell будет задерживаться.

## Backend + MySQL boundaries
- Backend не должен быть обязательным для чтения уже загруженного каталога.
- MySQL schema должна оптимизировать list/search/song detail access patterns.
- Пользовательские связи (`collections`, `setlists`, `live participants`) планировать в MySQL, но не внедрять до подтверждения auth/user model.
- Admin mutation endpoints требуют auth/security design до реализации.
- Все SQL-запросы должны быть параметризованы; поиск и сортировка требуют индексов и `EXPLAIN` после появления реальных запросов.

## Development quality boundary
- Каждый цикл разработки завершается проверкой по `docs/development-quality-gates.md`.
- Frontend проверяется на актуальной локальной или full-stack сборке, а не только через TypeScript/build.
- API-интеграция считается проверенной только если frontend реально получает ожидаемые ответы или корректно показывает fallback/error state.
- Self-review выполняется по `docs/self-review-prompt.md`; неподтвержденные claims в финальном отчете запрещены.
- UI-изменения должны проходить `docs/frontend-guardrails.md` и `docs/ui-ux-design-system.md`.

## Live-ready границы
- Все состояния live не должны смешиваться с базовыми настройками просмотра.
- `playerState` и `activeToken` (в будущем): отдельные сущности.
- Локальный `playbackPosition` не должен менять структуру каталога и не должен требовать сети.
- Сериализация состояния должна быть устойчивой к перезапуску приложения.

## Принципы UI/UX (на основе ui-ux-pro-max)
- Mobile-first, без hover-only логики.
- Touch targets ≥ 44px.
- Контраст 4.5:1 для текста, без избыточных декоративных анимаций.
- Никаких emoji-иконок вместо системных/векторных символов.
- Анимации только по смыслу, 150–300мс.

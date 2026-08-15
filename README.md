# Христианский сборник песен

Проект: веб-приложение для сборника песен с аккордами для служб/практики и репетиции.

Стартовая идея:
- сначала как удобный **сборник (MVP)**,
- затем — **live-режим для команды** (разные роли просмотра, синхронная подсветка).

> Репозиторий-референс: `pavelliolia/christian-songs-mobile-app` используется только как источник идей по UX и модели данных, но реализуем как новый web-проект с собственной архитектурой.

## Быстрый статус
- Платформа: React + TypeScript + Vite
- Формат приложения: PWA (offline-first)
- Язык интерфейса: русский

## Что уже сделано в плановой документации
- [`docs/repo-audit.md`](docs/repo-audit.md) — оценка референсного репозитория и выводы.
- [`docs/requirements.md`](docs/requirements.md) — требования и нефункциональные требования.
- [`docs/architecture.md`](docs/architecture.md) — проектная архитектура.
- [`docs/backend-mysql-plan.md`](docs/backend-mysql-plan.md) — план backend + MySQL foundation.
- [`docs/ui-ux-design-system.md`](docs/ui-ux-design-system.md) — UI/UX стиль и палитра.
- [`docs/frontend-guardrails.md`](docs/frontend-guardrails.md) — ограничения и правила для frontend, чтобы не раздувать UI и не ломать mobile/PWA.
- [`docs/development-quality-gates.md`](docs/development-quality-gates.md) — обязательные проверки после каждого цикла разработки.
- [`docs/self-review-prompt.md`](docs/self-review-prompt.md) — prompt для строгого self-review без неподтвержденных утверждений.
- [`docs/roadmap.md`](docs/roadmap.md) — план по фазам.
- [`docs/tasks/phase-1-mvp.md`](docs/tasks/phase-1-mvp.md)
- [`docs/tasks/phase-1-5-backend-mysql.md`](docs/tasks/phase-1-5-backend-mysql.md)
- [`docs/tasks/phase-2-live-foundation.md`](docs/tasks/phase-2-live-foundation.md)
- [`docs/tasks/phase-3-live-sync.md`](docs/tasks/phase-3-live-sync.md)

## Структура проекта (план)
- `src/pages` — экраны (список, песня, настройки).
- `src/features/songs` — модель песни, репозиторий, преобразования.
- `src/features/player` — режим автопереходов и будущая синхронизация.
- `src/features/live` — фаза 2 и 3 (после MVP).
- `src/storage` — IndexedDB + локальный snapshot каталога.
- `backend` — будущий backend service для MySQL catalog/users/setlists/live.
- `migrations` — будущие MySQL migrations.
- `docs/ui-ux-design-system.md` — визуальная система (палитра, spacing, контраст).

## Полезные соглашения
- Изменения не должны ломать офлайн-поведение.
- Live-режим открывается верхней кнопкой `Live`, выбирает песни из всего каталога, поддерживает отдельные live-сборники, сброс текущей очереди и отправку через Web Share/clipboard.
- Транспонирование выполняется на уровне конкретной открытой песни; нижняя BPM-панель включается в настройках и поддерживает ручной ввод, шаги `-/+` и tap tempo.
- Аккаунт и персональные настройки являются optional layer: сборник работает без входа, а вход через Google открывается из настроек.
- Для залогиненного пользователя настройки позволяют сохранить инструмент, удобные тональности, capo и transpose-подсказки.
- Возврат из песни должен восстанавливать позицию списка, с которой пользователь открыл песню.
- Любые изменения структуры данных песни описывать в `AGENTS.md` и `docs/requirements.md`.
- Первичная метрика качества: время открытия списка после установки не должна требовать сети.
- После каждого цикла разработки нужно открыть frontend и проверить затронутые сценарии на мобильном, планшетном и desktop-разрешениях.
- Backend/API изменения проверяются вместе с frontend-интеграцией, а не только отдельным health endpoint.
- Финальный отчет должен перечислять только реально выполненные проверки.

## Релизный режим
1. Собираем только MVP-ядро.
2. Параллельно проектируем backend + MySQL foundation без ломки offline-first.
3. Добавляем настройки и улучшения UX.
4. После стабилизации выводим в live-план (фаза 2/3).

## Как запускать локально
- Установка зависимостей:
  - `npm install`
- Режим разработки:
  - `npm run dev -- --host 0.0.0.0 --port 5173`
- Локальная предпросмотр сборки:
  - `npm run build`
  - `npm run preview`
- Публичный просмотр для проверки:
  - Поднятый туннель: `ngrok http 5173`
  - Ссылка из API: `curl http://127.0.0.1:4040/api/tunnels` (берётся `public_url`).

## Backend + MySQL foundation

Phase 1.5 scaffold уже добавлен: backend, MySQL, read-only catalog schema и API.

- Backend: Go HTTP service на `localhost:8082`.
- MySQL: `localhost:3309` внутри Docker Compose.
- Health:
  - `GET http://127.0.0.1:8082/healthz`
  - `GET http://127.0.0.1:8082/readyz`
- Catalog API:
  - `GET http://127.0.0.1:8082/api/catalog/version`
  - `GET http://127.0.0.1:8082/api/catalog/snapshot`
  - `GET http://127.0.0.1:8082/api/songs`
  - `GET http://127.0.0.1:8082/api/songs/song-1`

Команды:
- `make backend-build`
- `make backend-up`
- `make db-migrate`
- `make backend-health`
- `make backend-logs`
- `make backend-down`
- `make stack-up` — frontend + backend + MySQL вместе
- `make stack-health` — проверка web, proxied API и backend readiness

Важно:
- Backend читает опубликованный каталог из MySQL.
- Fresh MySQL volume получает schema через `docker-entrypoint-initdb.d`; каталог наполняется через admin/import seed flow.
- Admin mutation API сейчас защищён `ADMIN_API_KEY`; user accounts для персональных настроек начинаются через OAuth-only foundation, а полноценные роли/audit остаются отдельным hardening-шагом.
- Frontend стартует со встроенного bundled-каталога, обновляет локальный snapshot из `/api/catalog/snapshot`, но при недоступности backend продолжает читать последний локальный snapshot или bundled-каталог.
- Недавние песни и пользовательские сборники сохраняются локально и доступны рядом со списком.
- В UI есть компактный индикатор статуса каталога; обновление каталога для обычного пользователя делается жестом pull-to-refresh, import/export не показываются.
- В панели музыканта есть локальные view presets `Lead`, `Singer`, `Chords` как foundation для будущих ролей команды без server-side users/live sync.

### Admin

- Отдельная админка открывается по `/admin`.
- Для входа нужен `ADMIN_API_KEY`; frontend проверяет ключ через admin API и не сохраняет его между запусками. В production поле ключа пустое, `123456` подставляется только локально на `localhost`/`127.0.0.1`.
- `/admin` использует отдельный `manifest-admin.webmanifest`, поэтому админку можно установить как отдельную PWA с `start_url=/admin`.
- Сейчас реализован admin slice: просмотр и редактирование pending заявок, approve в текущий MySQL-каталог, прямое добавление песни, редактирование опубликованных песен, единого `leadSheet` и playback-параметров. Полноценные пользователи, роли и audit log остаются отдельными задачами.

## PWA / offline

- `public/manifest.webmanifest` описывает installable app shell.
- `public/manifest-admin.webmanifest` описывает installable admin app shell для `/admin`.
- `public/icon.svg` используется как app icon.
- `public/sw.js` — исходный service worker template.
- `scripts/generate-sw.mjs` после `vite build` подставляет в `dist/sw.js` реальные hashed assets из сборки.
- `scripts/send-telegram-screenshots.sh` отправляет screenshot-файлы в Telegram task chat, если настроены `CODEX_TELEGRAM_BOT_TOKEN` и `CODEX_TELEGRAM_CHAT_ID`.
- API-запросы не кэшируются service worker-ом: каталог сохраняется отдельно в IndexedDB.
- Bundled offline-каталог генерируется командой `npm run seed:songbook:bundled-catalog` из staging-манифеста; песни получают самодостаточные slug-id из названий, а категории распределяются локальными правилами по темам Holychords.
- Канонический формат песни — единый `leadSheet`: заголовки секций и строки аккордов над строками текста, как в Holychords. `sections`, `verses`, `chorus` и `bridge` генерируются из него для чтения.
- Static assets в production-контейнере отдаются Go web runtime с long-cache, а `sw.js` и manifest — без долгого кэша.

## Запуск как production через Docker

### Простой сценарий
1. Собрать production-образ:
   - `make docker-build`
2. Запустить контейнер на `localhost:8081` (во избежание коллизии с уже занятым `8080` в этой машине):
   - `make docker-run`
3. Проверить:
   - `curl http://localhost:8081`

### Проверка через ngrok (для тебя)
1. После `make docker-run` запустить:
   - `make ngrok-fresh`
2. В браузере открыть `public_url` из:
   - `make ngrok-url`
3. Не использовать старый `public_url` вручную. После рестарта браузера/PC нужно заново получить URL командой `make ngrok-fresh` или `make ngrok-url`.
4. Если ошибка повторяется:
   - остановить предыдущие туннели: `make ngrok-stop`
   - перезапустить: `make ngrok-fresh`.

### Альтернативно через raw docker
- Сборка: `docker build -t christian-songbook:latest .`
- Запуск: `docker run -d --name christian-songbook -p 8081:8080 christian-songbook:latest`

### GitHub CI/CD
- CI workflow: `.github/workflows/ci.yml`
  - `npm run lint`
  - `npm test`
  - `npm run build`
  - `docker build` для web image
  - `docker build -f backend/Dockerfile` для backend API image
- Deploy workflow: `.github/workflows/deploy.yml`
  - публикует web image в `ghcr.io/<owner>/christian-songbook`;
  - публикует backend API image в `ghcr.io/<owner>/christian-songbook-api`;
  - собирает и пушит web/backend images отдельными параллельными jobs после quality gate;
  - после merge/push в `main` автоматически выполняет deploy через SSH;
  - manual `workflow_dispatch` тоже может выполнить deploy через SSH, если выбрать `restart_server=true`;
  - нужны GitHub secrets:
    - `DEPLOY_HOST`
    - `DEPLOY_USER`
    - `DEPLOY_SSH_KEY`
    - `DEPLOY_COMMAND`

Рекомендуемые значения для `songs.vess.by`:

```bash
DEPLOY_HOST=185.251.38.234
DEPLOY_USER=deploy
DEPLOY_COMMAND='cd /home/stanislavv/christian_songbook && ./restart.sh'
```

`DEPLOY_SSH_KEY` должен быть приватным SSH key, публичная часть которого добавлена в `authorized_keys` для `deploy@185.251.38.234`.

Если меняется инфраструктурная конфигурация, env или база, применяй management playbook отдельно. Обычный deploy после merge в `main` использует уже подготовленный `restart.sh`.

### Legacy catalog seed
Исходный mobile repo `pavelliolia/christian-songs-mobile-app` хранит модель клиента, но сам каталог тянет из legacy API.

Importer:

```bash
node scripts/import-legacy-songs.mjs --input legacy-songs.json --out src/data/importedCatalog.generated.json
node scripts/import-legacy-songs.mjs --input legacy-songs.json --sql-out migrations/003_legacy_catalog_seed.generated.sql --version 2026.08.13.legacy
```

Seed workspace:

- `seed/legacy/README.md`
- `seed/legacy/songs.example.json`

Команды:

```bash
npm run seed:legacy:example
npm run seed:legacy:json
npm run seed:legacy:sql
```

Если legacy API снова доступен:

```bash
node scripts/import-legacy-songs.mjs --url https://quiet-sierra-94562.herokuapp.com/songs --out src/data/importedCatalog.generated.json
```

Importer сопоставляет песни с русскими категориями из `src/data/songCategories.ts` по keyword mapping и использует `Разное` как fallback.

### Full-stack сценарий
- Запуск web + backend + MySQL:
  - `make stack-up`
- Проверка:
  - `make stack-health`
- В этом режиме frontend на `http://localhost:8083` проксирует `/api/*` в backend container.
- Порт можно поменять: `WEB_PORT=8090 make stack-up`.

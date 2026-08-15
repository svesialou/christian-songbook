# Development Quality Gates

## Purpose
Every development cycle must finish with runtime-oriented checks. A successful build alone is not enough for this project because the product is a PWA with frontend, backend API, MySQL, and offline behavior.

## Cycle definition
A cycle is any focused change to frontend, backend, API, storage, Docker, PWA/offline behavior, docs that define behavior, or project rules.

## Mandatory flow
1. Identify touched areas: frontend, backend, database, PWA/offline, Docker/runtime, docs.
2. Run the narrowest meaningful automated checks for touched areas.
3. Open the actual frontend build used for the cycle.
4. Verify affected scenarios on multiple viewport sizes.
5. Verify frontend/backend integration when API, catalog loading, status UI, or Docker composition changed.
6. Run self-review using `docs/self-review-prompt.md`.
7. Report exact checks and exact skipped checks in the final response.

## Frontend viewport checks
When frontend UI changes, inspect at minimum:
- Small phone: `360x740` or `375x667`.
- Modern phone: `390x844` or close equivalent.
- Tablet: `768x1024`.
- Desktop: `1440x900`.
- Landscape mobile or tablet when the changed screen can be used during worship practice.

Check:
- No horizontal scroll.
- No clipped lyrics, chords, status labels, filters, or bottom controls.
- No overlapping sticky header/footer/content.
- Touch targets are at least `44px`.
- Focus states are visible.
- Statuses are readable and not color-only.
- Pull-to-refresh, if touched, does not conflict with page scroll.
- Reduced-motion behavior remains acceptable when motion changed.

## Backend/API integration checks
When backend, catalog sync, Docker, API client, or status UI changes, verify:
- `GET /healthz` or `GET /readyz` for backend readiness.
- `GET /api/catalog/version` and `GET /api/catalog/snapshot` when catalog behavior changed.
- Frontend loads the catalog through the configured `/api/*` route in full-stack mode.
- Frontend shows the expected fallback/status when backend is unavailable.
- Offline reading still works from local snapshot or embedded catalog after the first successful load.

## Suggested commands
- Frontend build: `npm run build`.
- Backend tests: `cd backend && go test ./...`.
- Compose syntax: `docker compose config`.
- Full stack runtime: `make stack-up`.
- Full stack health: `make stack-health`.

Use only the commands relevant to the change. Do not run broad or slow checks without a reason.

## Evidence rule
Final reports must not contain guessed verification.

Allowed:
- "Ran `npm run build`: passed."
- "Checked `390x844` and `1440x900` manually: no horizontal scroll observed."
- "Skipped visual browser check: browser automation unavailable in this session."

Forbidden:
- "Responsive layout is fine" without an actual viewport check.
- "API works" after checking only TypeScript compilation.
- "Offline works" without opening the app in an offline/fallback scenario or explaining that it was not checked.

## Telegram screenshot delivery
For Telegram-driven frontend cycles, send screenshots back to the chat before the final response when Telegram credentials are configured.

Use:
- `scripts/send-telegram-screenshots.sh --caption "Христианский сборник песен viewport check" <png...>`

If screenshots were generated but could not be sent, the final response must say why. Do not claim "sent" unless the command succeeded.

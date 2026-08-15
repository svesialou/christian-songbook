# Frontend Guardrails

## Product direction
The product display name is `Христианский сборник песен`. It is a working songbook and worship tool. The UI must prioritize fast reading, search, statuses, and reliable offline behavior over decorative presentation.

## Required patterns
- Open directly into the useful catalog experience, not a marketing hero.
- Keep normal user flows close to the reference songbook behavior: catalog, search, collections/recent, song reading, chords toggle, transposition, text size.
- Use semantic design tokens for colors, spacing, radius, elevation, typography, and states.
- Keep catalog/network/sync state available without visual noise: use a compact status dot on the main screen with accessible label/title, and put detailed text only inside the overflow menu.
- Use pull-to-refresh for normal catalog refresh, with clear status feedback.
- Keep admin-only import/export/editing visually and route-wise separated from regular usage.
- Prefer mobile-first layouts, then adapt to tablet and desktop.
- Keep main content scroll simple. Avoid nested scroll containers unless a specific interaction requires them.

## Hard limits
- Do not show import/export to regular users.
- Do not add a user-facing source selector for local/API/manual catalog.
- Do not add extra primary buttons when a gesture, search, filter, or status can solve the problem more cleanly.
- Do not make backend availability required for opening already loaded songs.
- Do not introduce new frontend dependencies without a concrete current need.
- Do not use raw one-off colors inside components; add or reuse tokens instead.
- Do not use emoji as structural icons.
- Do not rely on hover-only interactions.
- Do not hide status meaning from assistive tech: if the visible UI uses only a status dot, it must include `aria-label`/`title` and detailed status text in the menu.
- Do not disable browser zoom.
- Do not use fixed pixel containers that create mobile horizontal scroll.
- Do not animate layout properties such as width, height, top, or left for routine UI motion.

## Visual system constraints
- Body text starts at `16px` or higher on mobile.
- Lyrics and chords are always the highest readability layer.
- Chords use a consistent accent treatment and must remain legible when transposed.
- Primary action per screen should be singular and visually clear.
- Secondary actions should be quieter than reading/search controls.
- Motion should be meaningful, short, and respect `prefers-reduced-motion`.

## Responsive acceptance checklist
- `360x740`: no horizontal scroll, clipped filters, or hidden status text.
- `390x844`: catalog/search/status flow fits naturally.
- `768x1024`: tablet layout uses space without stretching lyrics edge-to-edge.
- `1440x900`: desktop layout keeps readable line length and clear hierarchy.
- Landscape: song view remains usable for musicians.

## Code constraints
- Keep React components small and named by product concept, not visual decoration.
- Separate UI state from server/catalog state.
- Keep API fallback logic explicit and testable.
- Prefer simple CSS modules/global token files over styling logic in components.
- Do not introduce global state for isolated screen concerns.

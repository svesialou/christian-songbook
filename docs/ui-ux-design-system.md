# UI/UX Design System

## Direction
The product display name is `Христианский сборник песен`. It is a practical worship tool, not a landing page.

The interface should feel calm, readable, and reliable during rehearsal or service. The first screen must stay focused on search, catalog, collections, recent songs, and song reading.

## Palette
- `ink`: primary text and reading surfaces.
- `teal`: chords, active music controls, offline-first identity.
- `indigo`: navigation states, selected filters, section markers.
- `amber`: collections, offline warnings, admin-preview tools.

Avoid single-hue green/cream themes. Avoid decorative blobs and heavy atmospheric backgrounds.

## UI Rules
- Keep touch targets at least `44px`.
- Preserve visible focus states.
- Use high contrast for lyrics and chords.
- Do not show import/export to regular users.
- Keep admin tools visually separated and only available in admin-preview.
- Do not introduce marketing hero sections; the app should open directly into the working catalog.
- Use semantic CSS variables/tokens for color, elevation, radius, spacing, and state colors. Components should not introduce one-off raw hex palettes.
- Main-screen statuses should be compact: one status dot in the top corner is enough. Detailed source/network/sync text belongs in the overflow menu.
- Minimize buttons in the regular user flow. Prefer direct search, filters, pull-to-refresh, and compact status feedback over extra controls.

## Mobile Priorities
- Compact top bar, search, filters, and first songs should fit naturally in the first scroll.
- No horizontal scroll.
- Song text must remain the highest-contrast content in the UI.
- Pull-to-refresh must not fight nested scroll containers or horizontal gestures.
- Verify small phone, large phone, tablet, desktop, and landscape layouts before finishing UI changes.

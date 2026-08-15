# Tasks - Phase 1.6 User accounts and personal preferences

## Goal
Add account-backed personal settings without storing user passwords and without breaking offline song reading.

## Scope
- Google OAuth first, Apple OAuth after Google is stable.
- Backend-owned sessions with secure cookies.
- MySQL-backed users, provider identities, sessions, OAuth state, global preferences, and per-song preferences.
- Personal instrument preferences for guitar/piano usage.
- Per-song target key or transpose steps.
- Song view metadata showing original key, current key, semitone shift, guitar capo suggestion, and piano transpose hint.
- Offline cache for the last known personal settings.

## Out of scope for the first implementation slice
- Password login.
- Team roles and shared administration.
- Realtime live sync.
- Provider-specific Apple production setup before Google OAuth is working.

## Implementation order
1. Add MySQL schema foundation for users and preferences.
2. Add backend config/env contract for OAuth providers and session cookies.
3. Implement Google OAuth start/callback and `GET /api/me`.
4. Add profile/settings UI and local cached preferences.
5. Add per-song target key save/read flow.
6. Add automatic key suggestion as an explicit suggestion, not hidden mutation.
7. Add Apple OAuth using the same identity/session model.

## Acceptance criteria
- Users authenticate through external providers only.
- No password hashes or raw OAuth tokens are stored.
- Session tokens are stored only as hashes server-side.
- Regular song reading works while logged out and offline.
- Personal transposition never mutates canonical song data.
- The song screen clearly shows original key and user-applied shift.

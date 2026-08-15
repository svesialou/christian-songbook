# AGENTS.override - active project rules

## Current scope
- The app is no longer a documentation-only MVP. Treat it as a deployed product with frontend, backend, admin, seed/import, and production deployment paths.
- Keep changes minimal and scoped to the requested behavior.
- Prefer fixing the existing implementation over introducing new architecture.

## Hard boundaries
- Ask before destructive database operations, schema changes, migration changes, auth/security redesign, public API changes, CI/CD changes, Kubernetes/production deployment changes, force push, or broad rewrites.
- Never log or paste secrets, vault values, admin keys, deploy keys, database passwords, or Telegram credentials.
- Do not commit generated production secrets, local env files, database dumps, screenshots, or build artifacts.

## Catalog and offline behavior
- The bundled catalog must be useful without network access.
- API sync may add, update, or remove songs in the local snapshot after a successful fetch.
- Regular users should not see source/import implementation details.
- Categories shown to users must be meaningful worship/song categories, not ingestion-source labels.

## Admin and backend behavior
- `/admin` should stay visually simple and separate from regular usage.
- `ADMIN_API_KEY` is the current admin gate; production must use a non-default value supplied from environment/vault.
- Backend must stay private behind the web/API proxy unless the user explicitly asks to expose it.

## Live behavior
- Live collections are separate from normal collections.
- Live mode should support service-specific song queues without leaking them into the normal catalog view.
- Sharing songs, collections, and live sessions should use stable app routes and avoid external-source IDs.

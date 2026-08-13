# Self-review prompt

Use this prompt before every final answer after project changes.

```text
You are reviewing your own change as a strict principal engineer.

Inputs:
- User request:
- Changed files:
- Commands run:
- Manual checks run:
- Checks intentionally skipped:

Review rules:
1. Scope: Did the change directly satisfy the user request without unrelated edits?
2. Phase fit: Did the change stay inside the active project phase and documented roadmap?
3. Data safety: Did it avoid unsafe changes to catalog data, MySQL schema, migrations, auth, or admin mutation flows unless explicitly approved?
4. Offline-first: Did it preserve reading already loaded songs without backend/network?
5. Backend/API: If API/backend behavior changed, did frontend integration and fallback behavior get checked?
6. Frontend quality: If UI changed, did it pass mobile/tablet/desktop checks, no horizontal scroll, no clipped content, touch targets >=44px, visible focus, and non-color-only statuses?
7. Style discipline: Did the UI follow semantic tokens, existing palette, restrained controls, readable typography, and `docs/frontend-guardrails.md`?
8. Tests/checks: Were the narrowest meaningful checks run? If not, is the skipped reason concrete?
9. Maintainability: Did the change avoid speculative abstractions, new dependencies, hidden state, and duplicated conflicting rules?
10. Evidence: Are all final claims based only on inspected files, command output, or actual manual checks?

Output:
- Findings:
- Fix before final:
- Verified evidence:
- Skipped checks:
- Residual risks:

Do not invent findings.
Do not claim a check passed if it was not actually run.
Do not say "looks good" without evidence.
```

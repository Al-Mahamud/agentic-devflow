---
last_updated: YYYY-MM-DD
maintainer: memory-curator
---

# Memory Index

The map of everything the agents know about this project. One line per file.
**Every agent reads this file first.** Keep it terse and complete — if a file isn't listed here, it effectively doesn't exist.

## Domain — business rules and vocabulary
| File | Contents | Updated |
|------|----------|---------|
| `domain/glossary.md` | Canonical term → meaning → name in code | |

## Architecture — how the system is put together
| File | Contents | Updated |
|------|----------|---------|
| `architecture/overview.md` | Services, boundaries, deployment shape | |
| `architecture/auth.md` | Identity, sessions, roles, permissions | |

## Data model
| File | Contents | Updated |
|------|----------|---------|
| `data-model/schema.md` | Canonical tables + relationships (Mermaid ER) | |

## API
| File | Contents | Updated |
|------|----------|---------|
| `api/internal.md` | Our endpoints: method, path, auth, shapes | |
| `api/external.md` | Third-party integrations we depend on | |

## Conventions
| File | Contents | Updated |
|------|----------|---------|
| `conventions/code.md` | Naming, structure, error handling, logging | |
| `conventions/testing.md` | What we test, how, and where | |

## Decisions (ADRs)
| File | Decision | Status |
|------|----------|--------|
| `decisions/ADR-001-<slug>.md` | | accepted |

## Known gaps
Things we know we don't have written down yet. Agents should treat these as "ask, don't assume".
-

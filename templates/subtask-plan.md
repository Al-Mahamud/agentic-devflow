---
task: T-0000
subtask: 01
title: <short title>
scope: backend            # backend | frontend | shared | infra
depends_on: []
estimate: 0.5-1d
review_status: pending    # pending | changes-requested | approved
reviewed_by:
reviewed_at:
---

# 01 — <title>

## Goal
<one paragraph — what is done when this is done>

## Affected files / modules
| Path | Change |
|------|--------|
| `src/...` | new / modify / delete |

## Approach
1.
2.
3.

## Data changes
<none | see `../diagrams/01-er.md`>
Migration: forward / backfill / reversible?

## External APIs
<none | see `../api-contracts/01-<service>.md`>

## Contract with the other side
<If backend: the exact endpoint FE will call. If frontend: the exact shape it expects. Method, path, request, response, error codes.>

## Edge cases
-

## Test plan
| Case | Type (unit/integration/e2e/manual) | Expected |
|------|-----------------------------------|----------|

## Acceptance criteria
- [ ]

## Risks & trade-offs
| Risk | Likelihood | Mitigation |
|------|-----------|------------|

## Memory references
- `memory/...#anchor` — <what it constrained>

## Developer review
<!-- filled by a human via /review -->
- **verdict:**
- **feedback:**

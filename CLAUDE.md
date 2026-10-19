# Project operating rules

This repo runs a wiki → task → plan → review pipeline. Agents follow these rules without being reminded.

## Read order (every session, every agent)
1. `memory/index.md` — the map. Never skip it.
2. The task's `context/<ID>/manifest.md` if a task ID is in play.
3. Only then the specific memory files the manifest points to.

Never read the whole `memory/` tree. The index plus the manifest is the filter.

## Who may write where
| Path | Writer |
|------|--------|
| `memory/**` | **memory-curator only** |
| `context/**` | wiki-analyst |
| `tasks/**` | wiki-analyst (creates), any agent (status field) |
| `questions/**` | wiki-analyst, planner (append), human (answers) |
| `plans/**` | planner; human adds review blocks |
| `src/**` | implementer only, and only from an `approved` plan |

## Non-negotiables
- **Never invent a business rule, a table column, or a third-party API schema.** Ask instead. A blocking question costs minutes; a wrong assumption costs days.
- **Never silently resolve a conflict** between the wiki and the memory box. Surface it.
- **No implementation before `review_status: approved`** on the relevant plan file.
- **Cite memory inline** (`memory/architecture/auth.md#sessions`) whenever a decision follows from existing knowledge. Uncited = guess.
- **Ask one question at a time** in the terminal. Batched questions get batched, low-quality answers.
- Estimates are ranges. Single numbers are lies.

## Task IDs
`T-NNNN`, allocated by `scripts/new-id.sh`. Never reuse, never hand-pick.

## Status lifecycle
`draft → blocked → ready-for-plan → in-review → approved → in-progress → done`
`done` must be followed by `/absorb <ID>` or the memory box rots.

## Commands
| Command | Purpose |
|---------|---------|
| `/wiki [file]` | Analyze a wiki PDF → manifest + questions + task |
| `/answer <ID>` | Answer open questions interactively |
| `/plan <ID>` | Produce the implementation plan |
| `/review <ID>` | Walk through plan review, record verdicts |
| `/absorb <ID>` | Fold finished work back into memory |
| `/status` | Pipeline overview |

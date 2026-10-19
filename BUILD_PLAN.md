# BUILD_PLAN — Agentic Dev Workflow

Paste this into Claude Code at the root of a **new folder** (or your project repo).
Everything here is already scaffolded in this package — this document explains the design, the build order, and how to run it day to day.

---

## 1. What this system is

A human-in-the-loop pipeline that turns a wiki PDF from a client / PM / team lead into a reviewed, executable implementation plan.

```
wiki PDF  ──▶  wiki-analyst  ──▶  questions ──▶  YOU answer
                    │                                │
                    ▼                                ▼
            context manifest  ─────────────▶  planner  ──▶  plan files
                    ▲                                        │
                    │                                        ▼
              memory box  ◀── memory-curator ◀──  YOU review & approve
```

Four moving parts:

| Part | Role |
|------|------|
| **Memory box** (`memory/`) | Durable project knowledge. Single source of truth. |
| **wiki-analyst** | Reads the wiki, resolves it against memory, asks what it doesn't know, emits a task. |
| **planner** | Turns a task into FE/BE-split, decomposed, reviewable plans with ER diagrams and API contracts. |
| **memory-curator** | Folds finished work back into memory so the box gets smarter each cycle. |

The fourth part is the one your raw idea was missing, and it's the one that makes this compound instead of decay. Without a write-back step the memory box is a snapshot that goes stale in a month; with it, every task makes the next task cheaper.

---

## 2. Three changes I made to your design, and why

### a. "Virtual memory box" → **Context Manifest** (pointers, not copies)

Your instinct — give the planner only the relevant slice — is right. But *copying* wiki-relevant memory into a per-task box creates two sources of truth that silently diverge.

Instead, the manifest is a **resolved pointer set**: requirement → memory file → section → why it matters. Same filtering benefit, no divergence. It also gives you three extra columns that turn out to be the most valuable output of the whole analyst step:

- **Novel** — the wiki asks for something memory has never described. This is where all your risk is.
- **Conflicting** — the wiki contradicts memory. Never auto-resolved; always becomes a blocking question.
- **Stale-suspect** — memory this wiki implies is now wrong. Feeds the curator.

### b. Questions get a **severity** and a **best guess**

`BLOCKING` halts the pipeline. `NON-BLOCKING` proceeds with a stated assumption you can veto later. And every question ships with the agent's proposed answer — confirming a guess takes you ten seconds, writing prose takes ten minutes. This single detail is what determines whether you actually use the system or abandon it.

### c. Decompose *reluctantly*

Your rule was "divide if too big". Add a floor: under ~2 days, don't split. Every sub-task carries review overhead; over-decomposition costs you more time than it saves. A sub-task is worth creating only if it's independently mergeable, single-owner, and 0.5–2 days.

---

## 3. Folder layout

```
project-root/
├── CLAUDE.md                  # operating rules every agent obeys
├── .claude/
│   ├── agents/
│   │   ├── wiki-analyst.md
│   │   ├── planner.md
│   │   └── memory-curator.md
│   └── commands/
│       ├── wiki.md  answer.md  plan.md  review.md  absorb.md  status.md
├── memory/                    # THE memory box — curator writes, everyone reads
│   ├── index.md               # the map; read first, always
│   ├── domain/  architecture/  data-model/  api/  conventions/  decisions/
├── wiki-inbox/                # drop wiki PDFs here
├── wiki-extracted/            # text extraction of those PDFs
├── context/T-0042/manifest.md # the per-task "virtual memory box"
├── tasks/T-0042.md
├── questions/T-0042.md
├── plans/T-0042/
│   ├── 00-overview.md
│   ├── 01-<slug>.md
│   ├── diagrams/01-er.md
│   └── api-contracts/01-<service>.md
├── templates/                 # every artifact shape
├── scripts/new-id.sh  extract-pdf.sh
└── .state/counter.json        # task ID counter
```

---

## 4. Build order

**Phase 0 — scaffold (done for you)**
Copy this package into your repo root. Then:
```bash
chmod +x scripts/*.sh
bash scripts/new-id.sh   # should print T-0001; reset .state/counter.json to {"last":0} after testing
```
Install PDF tooling: `brew install poppler` (macOS) or `sudo apt install poppler-utils`. Optional OCR: `pip install ocrmypdf`.

**Phase 1 — seed the memory box (the only step you can't skip)**
This is where the system lives or dies. An empty memory box makes the analyst ask you fifty questions per wiki. Spend 2–4 hours here:

In Claude Code, at your existing project root:
> Read this codebase and populate `memory/` following the shelf structure in `memory/index.md`. Start with `architecture/overview.md`, `data-model/schema.md` (Mermaid ER of every existing table), `api/internal.md`, and `conventions/code.md`. Keep each file under 200 lines, lead with a 2-line summary, state facts not narrative, and use exact code identifiers. Then fill in `memory/index.md` completely.

Then review it yourself. Wrong memory is worse than no memory.

**Phase 2 — dry run on a wiki you already understand**
Pick a wiki for something you've already built. Run `/wiki`, then `/answer`, then `/plan`. Compare the plan to what you actually did. The gaps tell you exactly which memory files are thin.

**Phase 3 — tune the agents**
Edit `.claude/agents/*.md` directly. Most common tunings:
- The analyst asks too many questions → memory box is thin, or lower the BLOCKING bar.
- Plans are too shallow → add your stack's specifics to `planner.md` step 4 (framework, ORM, test runner, folder conventions).
- Sub-tasks are too small → raise the floor in step 3.

**Phase 4 — close the loop**
After your first shipped task, run `/absorb <ID>`. Check the diff carefully. The curator's judgement about what is "durable" is the thing you'll want to tune most.

**Phase 5 (optional) — add an implementer agent**
Once plans are consistently good, add `.claude/agents/implementer.md` that reads *only* an `approved` plan file and writes code. Keep it strictly gated on `review_status: approved` — that gate is the whole safety model.

---

## 5. Daily loop

```
/wiki client-spec-oct.pdf     # analyst reads, resolves, asks
/answer T-0042                 # you answer, one question at a time
/plan T-0042                   # planner produces plan files
/review T-0042                 # you approve or request changes
   ...implement...
/absorb T-0042                 # memory gets smarter
/status                        # what's waiting on you
```

Realistic time cost: 10–20 min of your attention per task, front-loaded into `/answer` and `/review`. That's the trade — the system doesn't remove your judgement, it moves it to the front where it's cheap.

---

## 6. Failure modes to watch for

| Symptom | Cause | Fix |
|---------|-------|-----|
| Analyst asks obvious questions | Memory box thin or index incomplete | Phase 1 again; the index is what agents actually read |
| Plans cite files that don't exist | Planner didn't Grep the codebase | Add "verify every path exists before writing it" to planner step 4 |
| Memory box balloons | Curator absorbing task specifics | Tighten its "durable" test; prune quarterly |
| You stop using `/review` | Plans too long | Cap sub-task plans at one screen; detail belongs in the ER/contract files |
| Two agents disagree about a table name | Naming ambiguity in memory | The glossary's "name in code" column is mandatory, not optional |

---

## 7. What to hand your PC Claude Code

Say this:

> This folder contains a wiki→task→plan pipeline scaffold. Read `CLAUDE.md` and `BUILD_PLAN.md`. Then execute Phase 1: read my codebase and populate `memory/` per the structure in `memory/index.md`. Ask me before writing anything you had to guess.

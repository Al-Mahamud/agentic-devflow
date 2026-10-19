# Agentic Dev Workflow

Wiki PDF → analyzed task → reviewed plan → smarter memory box.

**Start here:** `BUILD_PLAN.md` (design + build order), then `CLAUDE.md` (operating rules).

## How the workflow runs

```mermaid
flowchart TD
    PDF["📄 Wiki / spec PDF<br/>from client, PM or team lead"]

    subgraph S1["1 · /wiki — wiki-analyst"]
        WIKI["Extract text, split into<br/>requirement units W1, W2 …"]
        RESOLVE["Resolve each unit against<br/>memory/index.md"]
        MANIFEST["context/T-NNNN/manifest.md<br/>Grounded · Novel · Conflicting · Stale-suspect"]
        Q["questions/T-NNNN.md<br/>BLOCKING / NON-BLOCKING + best guess"]
        WIKI --> RESOLVE
        RESOLVE --> MANIFEST
        RESOLVE --> Q
    end

    BLOCK{"Open BLOCKING<br/>questions?"}
    ANSWER["2 · /answer — 🧑 you<br/>one question at a time"]
    TASK["tasks/T-NNNN.md<br/>status: ready-for-plan"]

    subgraph S3["3 · /plan — planner"]
        PLAN["Restate the real ask<br/>split FE / BE scope + contract<br/>decompose only if over ~2 days"]
        FILES["plans/T-NNNN/<br/>00-overview · NN-subtask plans<br/>ER diagrams · API contracts"]
        PLAN --> FILES
    end

    REVIEW{"4 · /review — 🧑 you<br/>approve / changes / reject"}
    IMPL["5 · Implement<br/>only from approved plans"]
    ABSORB["6 · /absorb — memory-curator<br/>keep durable facts, drop task chatter"]
    MEM[("🧠 memory/<br/>domain · architecture · data-model<br/>api · conventions · decisions")]

    PDF -->|drop in wiki-inbox/| WIKI
    Q --> BLOCK
    BLOCK -->|yes| ANSWER
    ANSWER --> BLOCK
    BLOCK -->|no| TASK
    TASK --> PLAN
    FILES --> REVIEW
    REVIEW -->|changes| PLAN
    REVIEW -->|approved| IMPL
    IMPL -->|task done| ABSORB
    ABSORB -->|writes| MEM

    MEM -.->|read first, every task| RESOLVE
    MANIFEST -.->|pointers, not copies| PLAN
    MANIFEST -.->|stale-suspect facts| ABSORB

    classDef human fill:#fff4d6,stroke:#d4a017,color:#000
    classDef store fill:#e3f0ff,stroke:#3b82f6,color:#000
    class ANSWER,REVIEW human
    class MEM store
    style S1 fill:#f6f8fa,stroke:#8b949e,color:#000
    style S3 fill:#f6f8fa,stroke:#8b949e,color:#000
```

| Step | Command | Who | Output |
|------|---------|-----|--------|
| 1 | `/wiki` | wiki-analyst | Context manifest + questions; task file once unblocked |
| 2 | `/answer <ID>` | **you** | Answers recorded; task moves to `ready-for-plan` |
| 3 | `/plan <ID>` | planner | Plan files with FE/BE split, ER diagrams, API contracts |
| 4 | `/review <ID>` | **you** | Each sub-plan approved, changed or rejected |
| 5 | implement | developer / implementer | Code, written only from `approved` plans |
| 6 | `/absorb <ID>` | memory-curator | Durable knowledge folded back into `memory/` |

The yellow boxes are the human gates. The memory box closes the loop: every finished task makes the next one cheaper to analyse and plan.

## Quick start
```bash
chmod +x scripts/*.sh
# then in Claude Code:
/wiki some-spec.pdf
/answer T-0001
/plan T-0001
/review T-0001
/absorb T-0001
```

Do Phase 1 of `BUILD_PLAN.md` (seed `memory/`) before anything else. An empty memory box makes every other part of this useless.

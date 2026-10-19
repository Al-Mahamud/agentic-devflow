---
description: Produce a reviewable implementation plan for a task ID
argument-hint: <TASK-ID e.g. T-0042>
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, Task
---

Plan task $ARGUMENTS.

Use the **planner** subagent.

Preconditions — verify before starting:
- `tasks/$ARGUMENTS.md` exists and `status` is `ready-for-plan`.
- `questions/$ARGUMENTS.md` has no `status: open` BLOCKING entries.

If a precondition fails, tell me which one and stop.

When done, list every file created and the review order.

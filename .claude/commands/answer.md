---
description: Record my answers to open questions and unblock a task
argument-hint: <TASK-ID>
allowed-tools: Read, Write, Edit, Glob, Grep
---

Open `questions/$ARGUMENTS.md`.

Walk me through each `status: open` question ONE AT A TIME, in the terminal:
- show the question, your best guess, and why it matters
- wait for my answer before moving to the next

After each answer:
- write it into the `Answer:` field
- set `status: answered` and stamp today's date
- if my answer contradicts something in `memory/`, flag it immediately rather than at the end

When all blocking questions are answered, update `tasks/$ARGUMENTS.md` status to `ready-for-plan` and tell me what changed.

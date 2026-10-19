---
description: Fold a completed task's knowledge back into the memory box
argument-hint: <TASK-ID>
allowed-tools: Read, Write, Edit, Glob, Grep, Task
---

Use the **memory-curator** subagent to absorb task $ARGUMENTS into `memory/`.

Show me a diff-style summary of what was added, edited, or marked superseded before you finish — I want to catch anything that shouldn't become permanent knowledge.

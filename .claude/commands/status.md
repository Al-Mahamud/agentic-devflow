---
description: Show the state of every task in the pipeline
allowed-tools: Read, Glob, Grep, Bash
---

Scan `tasks/*.md`, `questions/*.md`, `plans/*/`.

Print one table: ID | title | status | open blocking questions | plans approved/total | last touched.
Sort by: blocked first, then ready-for-plan, then in-review, then done.
Below the table, list in one line each what is waiting on ME specifically.

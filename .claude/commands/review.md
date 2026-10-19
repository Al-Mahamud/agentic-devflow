---
description: Walk me through reviewing the plan files for a task
argument-hint: <TASK-ID>
allowed-tools: Read, Write, Edit, Glob, Grep
---

Review session for plans in `plans/$ARGUMENTS/`.

For each file with `review_status: pending`, in dependency order:
1. Summarise the sub-task in 5 lines max — goal, scope side, affected files, data changes, estimate.
2. Point out the two or three decisions in it that I most need to check, and any assumption it rests on.
3. Ask for my verdict: approve / changes / reject.
4. Record my feedback verbatim under `## Developer review`, set `review_status` and `reviewed_by`/`reviewed_at`.
5. If I request changes, revise the plan file now and re-present it.

At the end, print a table: sub-task | status | estimate. Then tell me if the task is fully approved.

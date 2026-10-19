---
description: Analyze a wiki PDF from wiki-inbox and produce task + context manifest + questions
argument-hint: [filename in wiki-inbox/, or blank for newest]
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, Task
---

Analyze the wiki document: $ARGUMENTS
(If blank, use the most recently modified file in `wiki-inbox/`.)

Use the **wiki-analyst** subagent. Follow its procedure exactly.

Stop and show me the BLOCKING questions before creating the task file.

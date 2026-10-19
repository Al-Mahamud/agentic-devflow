#!/usr/bin/env bash
# Allocate the next task ID. Usage: bash scripts/new-id.sh
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STATE="$ROOT/.state/counter.json"
mkdir -p "$ROOT/.state"
[ -f "$STATE" ] || echo '{"last":0}' > "$STATE"
LAST=$(grep -o '[0-9]\+' "$STATE" | head -1)
NEXT=$((LAST + 1))
printf '{"last":%d}\n' "$NEXT" > "$STATE"
printf 'T-%04d\n' "$NEXT"

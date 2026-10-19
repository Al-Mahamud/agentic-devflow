#!/usr/bin/env bash
# Extract text from a wiki PDF. Usage: bash scripts/extract-pdf.sh wiki-inbox/foo.pdf
# Falls back to OCR if the PDF is image-only.
set -euo pipefail
SRC="$1"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BASE="$(basename "${SRC%.*}")"
OUT="$ROOT/wiki-extracted/$BASE.txt"
mkdir -p "$ROOT/wiki-extracted"

if command -v pdftotext >/dev/null 2>&1; then
  pdftotext -layout "$SRC" "$OUT"
else
  echo "pdftotext not found. Install poppler-utils:" >&2
  echo "  macOS: brew install poppler | Debian/Ubuntu: sudo apt install poppler-utils" >&2
  exit 1
fi

CHARS=$(wc -c < "$OUT")
if [ "$CHARS" -lt 500 ]; then
  echo "WARNING: only $CHARS chars extracted — this PDF is probably scanned images." >&2
  if command -v ocrmypdf >/dev/null 2>&1; then
    echo "Running OCR..." >&2
    ocrmypdf --force-ocr "$SRC" "/tmp/$BASE-ocr.pdf" >/dev/null
    pdftotext -layout "/tmp/$BASE-ocr.pdf" "$OUT"
  else
    echo "Install ocrmypdf for OCR support, or read the PDF directly with the Read tool." >&2
  fi
fi
echo "$OUT"

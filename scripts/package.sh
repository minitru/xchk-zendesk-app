#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
OUT="${1:-xchk-zendesk-app.zip}"
rm -f "$OUT"
zip -r "$OUT" manifest.json assets translations
echo "Created $ROOT/$OUT"

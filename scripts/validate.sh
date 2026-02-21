#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SKILL_DIR="$ROOT_DIR/skills/d2-diagram"

if ! command -v d2 >/dev/null 2>&1; then
  echo "d2 CLI not found. Install D2 first."
  exit 1
fi

shopt -s globstar nullglob
FILES=("$SKILL_DIR/templates"/**/*.d2 "$SKILL_DIR/examples"/**/*.d2)

if [ ${#FILES[@]} -eq 0 ]; then
  echo "No .d2 files found under templates/examples."
  exit 1
fi

echo "Validating templates and examples..."
for file in "${FILES[@]}"; do
  d2 validate "$file"
done

echo "Checking formatting..."
for file in "${FILES[@]}"; do
  d2 fmt --check "$file"
done

echo "All checks passed."

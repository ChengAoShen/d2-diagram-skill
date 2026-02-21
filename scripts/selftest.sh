#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

required=(
  "$ROOT_DIR/skills/d2-diagram/SKILL.md"
  "$ROOT_DIR/scripts/install.sh"
  "$ROOT_DIR/scripts/install.ps1"
  "$ROOT_DIR/scripts/validate.sh"
)

for path in "${required[@]}"; do
  if [[ ! -e "$path" ]]; then
    echo "Missing required file: $path"
    exit 1
  fi
done

echo "Selftest passed."

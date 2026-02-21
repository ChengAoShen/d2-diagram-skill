#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

"$SCRIPT_DIR/install.sh" --scope project --source local

echo "Synced runtime skill directory: $ROOT_DIR/.claude/skills/d2-diagram"

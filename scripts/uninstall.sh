#!/usr/bin/env bash
set -euo pipefail

SCOPE="project"

usage() {
  cat <<'EOF'
Uninstall d2-diagram skill.

Usage:
  uninstall.sh [--scope project|global]
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --scope)
      SCOPE="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1"
      usage
      exit 1
      ;;
  esac
done

if [[ "$SCOPE" == "global" ]]; then
  DST_DIR="$HOME/.claude/skills/d2-diagram"
else
  DST_DIR="$PWD/.claude/skills/d2-diagram"
fi

rm -rf "$DST_DIR"
echo "Removed $DST_DIR"

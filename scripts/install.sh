#!/usr/bin/env bash
set -euo pipefail

SCOPE="project"
SOURCE="local"
REPO=""
REF="main"

usage() {
  cat <<'EOF'
Install d2-diagram skill.

Usage:
  install.sh [--scope project|global] [--source local|remote] [--repo <owner/repo|github-url>] [--ref <branch-or-tag>]

Examples:
  ./scripts/install.sh --scope project --source local
  ./scripts/install.sh --scope global --source local
  curl -fsSL <raw-url>/scripts/install.sh | bash -s -- --scope global --source remote --repo ChengAoShen/d2-diagram-skill --ref main
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --scope)
      SCOPE="$2"
      shift 2
      ;;
    --source)
      SOURCE="$2"
      shift 2
      ;;
    --repo)
      REPO="$2"
      shift 2
      ;;
    --ref)
      REF="$2"
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

if [[ "$SCOPE" != "project" && "$SCOPE" != "global" ]]; then
  echo "Invalid --scope: $SCOPE"
  exit 1
fi

if [[ "$SOURCE" != "local" && "$SOURCE" != "remote" ]]; then
  echo "Invalid --source: $SOURCE"
  exit 1
fi

normalize_repo_slug() {
  local input="$1"
  input="${input#https://github.com/}"
  input="${input#http://github.com/}"
  input="${input%.git}"
  echo "$input"
}

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SRC_DIR=""
TEMP_DIR=""

if [[ "$SOURCE" == "local" ]]; then
  if [[ -d "$ROOT_DIR/skills/d2-diagram" ]]; then
    SRC_DIR="$ROOT_DIR/skills/d2-diagram"
  elif [[ -d "$PWD/skills/d2-diagram" ]]; then
    SRC_DIR="$PWD/skills/d2-diagram"
  else
    echo "Local source not found. Expected skills/d2-diagram in repo root or current directory."
    exit 1
  fi
else
  if [[ -z "$REPO" ]]; then
    echo "--repo is required for --source remote"
    exit 1
  fi

  REPO_SLUG="$(normalize_repo_slug "$REPO")"
  TEMP_DIR="$(mktemp -d)"
  ARCHIVE_URL="https://codeload.github.com/${REPO_SLUG}/tar.gz/${REF}"

  if ! command -v curl >/dev/null 2>&1; then
    echo "curl is required for remote install"
    exit 1
  fi

  curl -fsSL "$ARCHIVE_URL" -o "$TEMP_DIR/repo.tar.gz"
  tar -xzf "$TEMP_DIR/repo.tar.gz" -C "$TEMP_DIR"

  EXTRACT_DIR="$TEMP_DIR/${REPO_SLUG##*/}-${REF}"
  if [[ ! -d "$EXTRACT_DIR" ]]; then
    for d in "$TEMP_DIR"/*; do
      if [[ -d "$d" ]]; then
        EXTRACT_DIR="$d"
        break
      fi
    done
  fi

  SRC_DIR="$EXTRACT_DIR/skills/d2-diagram"
  if [[ ! -d "$SRC_DIR" ]]; then
    echo "Remote source does not contain skills/d2-diagram"
    exit 1
  fi
fi

if [[ "$SCOPE" == "global" ]]; then
  DST_DIR="$HOME/.claude/skills/d2-diagram"
else
  DST_DIR="$PWD/.claude/skills/d2-diagram"
fi

mkdir -p "$(dirname "$DST_DIR")"
rm -rf "$DST_DIR"
cp -R -L "$SRC_DIR" "$DST_DIR"

if [[ -n "$TEMP_DIR" ]]; then
  rm -rf "$TEMP_DIR"
fi

echo "Installed d2-diagram to $DST_DIR"

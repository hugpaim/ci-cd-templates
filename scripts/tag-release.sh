#!/usr/bin/env bash
# ─────────────────────────────────────────────────────
# tag-release.sh — Semantic version release tagger
# Usage: ./scripts/tag-release.sh [major|minor|patch]
# ─────────────────────────────────────────────────────
set -euo pipefail

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
log()  { echo -e "${GREEN}[tag]${NC} $*"; }
warn() { echo -e "${YELLOW}[warn]${NC} $*"; }

BUMP="${1:-patch}"
[[ "$BUMP" =~ ^(major|minor|patch)$ ]] || { echo "Usage: $0 [major|minor|patch]"; exit 1; }

git rev-parse --git-dir &>/dev/null || { echo "Not inside a Git repo"; exit 1; }

# Get latest tag
LATEST=$(git tag --sort=-v:refname | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' | head -1 || echo "v0.0.0")
log "Latest tag: ${LATEST}"

# Parse semver
IFS='.' read -r MAJOR MINOR PATCH <<< "${LATEST#v}"

case "$BUMP" in
  major) MAJOR=$((MAJOR+1)); MINOR=0; PATCH=0 ;;
  minor) MINOR=$((MINOR+1)); PATCH=0 ;;
  patch) PATCH=$((PATCH+1)) ;;
esac

NEW_TAG="v${MAJOR}.${MINOR}.${PATCH}"
log "New tag:    ${NEW_TAG}"

read -rp "$(echo -e "${CYAN}Create and push tag ${NEW_TAG}? [y/N]:${NC} ")" confirm
[[ "$confirm" =~ ^[Yy]$ ]] || { warn "Aborted."; exit 0; }

git tag -a "$NEW_TAG" -m "Release ${NEW_TAG}"
git push origin "$NEW_TAG"

log "Tag ${NEW_TAG} created and pushed ✓"
echo ""
echo -e "  View release: https://github.com/hugpaim/ci-cd-templates/releases/tag/${NEW_TAG}"

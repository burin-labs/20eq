#!/usr/bin/env bash
# Point this clone's git at .githooks/. One-time per clone.
set -euo pipefail
HERE="$(cd "$(dirname "$0")/.." && pwd)"
git -C "$HERE" config core.hooksPath .githooks
echo "hooks installed: $(git -C "$HERE" config --get core.hooksPath)"

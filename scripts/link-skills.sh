#!/usr/bin/env bash
set -euo pipefail
# link root and every skill into the agent skills dir
root=$(cd "$(dirname "$0")/.." && pwd)
dest=${1:-$HOME/.claude/skills}
mkdir -p "$dest"
ln -sfn "$root" "$dest/dnaism"
echo "linked dnaism"
for d in "$root"/skills/*/; do
  d=${d%/}
  ln -sfn "$d" "$dest/$(basename "$d")"
  echo "linked $(basename "$d")"
done

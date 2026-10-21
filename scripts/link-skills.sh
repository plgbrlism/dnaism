#!/usr/bin/env bash
set -euo pipefail
# link root and every skill into the agent skills dir
root=$(cd "$(dirname "$0")/.." && pwd)
dest=${1:-$HOME/.claude/skills}
mkdir -p "$dest"
name=$(sed -n 's/^name: //p' "$root/SKILL.md" | head -1)
ln -sfn "$root" "$dest/$name"
echo "linked $name"
for d in "$root"/skills/*/; do
  d=${d%/}
  ln -sfn "$d" "$dest/$(basename "$d")"
  echo "linked $(basename "$d")"
done

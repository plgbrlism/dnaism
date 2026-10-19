#!/usr/bin/env bash
set -euo pipefail
# print name and description of every skill
root=$(cd "$(dirname "$0")/.." && pwd)
for f in "$root"/SKILL.md "$root"/skills/*/SKILL.md; do
  n=$(sed -n 's/^name: //p' "$f" | head -1)
  d=$(sed -n 's/^description: //p' "$f" | head -1)
  printf '%s\t%s\n' "$n" "$d"
done

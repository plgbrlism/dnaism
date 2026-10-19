#!/usr/bin/env bash
set -euo pipefail
# remove links created by link-skills.sh
root=$(cd "$(dirname "$0")/.." && pwd)
dest=${1:-$HOME/.claude/skills}
for l in "$dest"/*; do
  [[ -L $l ]] || continue
  case $(readlink "$l") in
    "$root"|"$root"/skills/*) rm "$l"; echo "removed $(basename "$l")" ;;
  esac
done

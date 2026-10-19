#!/usr/bin/env bash
set -euo pipefail
# lint the repo against its own rules
root=$(cd "$(dirname "$0")/.." && pwd)
max=100
bad=0
em=$(printf '\xe2\x80\x94')

# em-dash scan over every text file
hits=$(grep -rIl --exclude-dir=.git --exclude-dir=node_modules "$em" "$root" || true)
if [[ -n $hits ]]; then echo "em-dash in:"; echo "$hits"; bad=1; fi

# skill shape
for f in "$root"/SKILL.md "$root"/skills/*/SKILL.md; do
  head -1 "$f" | grep -q '^---$' || { echo "no frontmatter: $f"; bad=1; }
  grep -q '^name: ' "$f" || { echo "no name: $f"; bad=1; }
  grep -q '^description: ' "$f" || { echo "no description: $f"; bad=1; }
  (( $(wc -l < "$f") <= max )) || { echo "over $max lines: $f"; bad=1; }
done

bash "$root/scripts/check-rule-copies.sh" || bad=1
bash "$root/scripts/check-versions.sh" || bad=1

(( bad == 0 )) && echo "ok"
exit $bad

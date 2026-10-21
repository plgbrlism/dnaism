#!/usr/bin/env bash
set -euo pipefail
# run check.sh on a clean copy and on deliberately broken copies
root=$(cd "$(dirname "$0")/.." && pwd)
fail=0
mk() { local t; t=$(mktemp -d); cp -a "$root/." "$t/"; rm -rf "$t/.git"; echo "$t"; }
ok()  { if bash "$1/scripts/check.sh" >/dev/null 2>&1; then echo "pass: $2"; else echo "FAIL: $2"; fail=1; fi; }
bad() { if bash "$1/scripts/check.sh" >/dev/null 2>&1; then echo "FAIL: $2"; fail=1; else echo "pass: $2"; fi; }

t=$(mk); ok "$t" "clean repo"
t=$(mk); python3 -c "open('$t/skills/yap-code/SKILL.md','a').write('x \u2014 y\n')"; bad "$t" "em-dash caught"
t=$(mk); echo drift >> "$t/.clinerules/yap.md"; bad "$t" "stale rule copy caught"
t=$(mk); sed -i 's/"version": "0.1.0"/"version": "9.9.9"/' "$t/gemini-extension.json"; bad "$t" "version drift caught"
t=$(mk); sed -i 's/"version": "0.1.0"/"version": "9.9.9"/' "$t/.github/plugin/plugin.json"; bad "$t" "new manifest drift caught"
t=$(mk); seq 1 120 >> "$t/skills/yap-code/SKILL.md"; bad "$t" "oversize skill caught"
t=$(mk); sed -i '1d' "$t/skills/yap-docs/SKILL.md"; bad "$t" "missing frontmatter caught"
t=$(mk); sed -i '/| corrections, improving these skills |/d' "$t/SKILL.md"; bad "$t" "routing table drift caught"
t=$(mk); cp "$t/.clinerules/yap.md" "$t/.clinerules/old.md"; bad "$t" "leftover rule copy caught"
t=$(mk); sed -i '0,/^name: yap$/s//name: zap/' "$t/SKILL.md"; sed -i 's/^| yap (root) |/| zap (root) |/' "$t/README.md"; mv "$t/rules/yap.md" "$t/rules/zap.md"; python3 "$t/scripts/sync-rules.py" >/dev/null; ok "$t" "root rename still checks out"
exit $fail

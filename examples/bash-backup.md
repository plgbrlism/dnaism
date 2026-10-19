# bash backup

one-line summary: timestamped copy of a path.

| generic | dnaism |
|---|---|
| 40 lines, functions, usage text, color output | 4 lines |

```bash
#!/usr/bin/env bash
set -euo pipefail
src=${1:?src} dst=${2:?dst}
# timestamped copy
cp -a "$src" "$dst/$(date +%F)-$(basename "$src")"
```

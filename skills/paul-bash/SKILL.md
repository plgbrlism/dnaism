---
name: paul-bash
description: Paul's bash idioms. Load with paul-code whenever writing or editing shell scripts.
---

# paul-bash

one-line goal: tiny, safe, shellcheck-clean scripts.

| area | rule |
|---|---|
| header | `#!/usr/bin/env bash` then `set -euo pipefail` |
| quoting | quote every expansion |
| tests | `[[ ]]` over `[ ]` |
| speed | builtins and parameter expansion over spawning `sed`, `awk`, `cat` |
| vars | `local` inside functions, lowercase names |
| cleanup | `trap` for temp files |
| files | kebab-case script names |
| constants | lowercase at top per paul-code |
| lint | shellcheck clean |
| comments | short lowercase phrases |

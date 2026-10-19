#!/usr/bin/env bash
set -euo pipefail
# fail when a harness rule file drifts from rules/dnaism.md
root=$(cd "$(dirname "$0")/.." && pwd)
python3 "$root/scripts/sync-rules.py" --check

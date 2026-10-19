#!/usr/bin/env bash
set -euo pipefail
# fail when manifest versions disagree
root=$(cd "$(dirname "$0")/.." && pwd)
python3 - "$root" <<'PY'
import json, sys
root = sys.argv[1]
files = ["package.json", ".claude-plugin/plugin.json", ".codex-plugin/plugin.json", "gemini-extension.json"]
vers = {f: json.load(open(f"{root}/{f}"))["version"] for f in files}
if len(set(vers.values())) != 1:
    for f, v in vers.items():
        print("version:", f, v)
    sys.exit(1)
PY

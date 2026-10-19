#!/usr/bin/env bash
set -euo pipefail
# fail when manifest versions disagree, or a release tag does not match
root=$(cd "$(dirname "$0")/.." && pwd)
python3 - "$root" <<'PY'
import json, os, sys
root = sys.argv[1]
files = [
    "package.json",
    ".claude-plugin/plugin.json",
    ".codex-plugin/plugin.json",
    ".qoder-plugin/plugin.json",
    ".github/plugin/plugin.json",
    "gemini-extension.json",
]
vers = {f: json.load(open(f"{root}/{f}"))["version"] for f in files}
if len(set(vers.values())) != 1:
    for f, v in vers.items():
        print("version:", f, v)
    sys.exit(1)
if os.environ.get("GITHUB_REF_TYPE") == "tag":
    shared = next(iter(vers.values()))
    tag = os.environ.get("GITHUB_REF_NAME", "").removeprefix("v")
    if tag != shared:
        print(f"release tag {os.environ.get('GITHUB_REF_NAME')} does not match version {shared}")
        sys.exit(1)
PY

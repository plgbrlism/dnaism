#!/usr/bin/env bash
set -euo pipefail
# set one version across all manifests
v=${1:?version}
cd "$(dirname "$0")/.."
python3 - "$v" <<'PY'
import json, sys
v = sys.argv[1]
for p in ["package.json", ".claude-plugin/plugin.json", ".codex-plugin/plugin.json", "gemini-extension.json"]:
    d = json.load(open(p))
    d["version"] = v
    json.dump(d, open(p, "w"), indent=2)
    open(p, "a").write("\n")
print("version", v)
PY

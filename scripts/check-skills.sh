#!/usr/bin/env bash
set -euo pipefail
# fail when a skill is missing from the routing table, the rules list or the README
root=$(cd "$(dirname "$0")/.." && pwd)
python3 - "$root" <<'PY'
import pathlib, re, sys

root = pathlib.Path(sys.argv[1]).resolve()
skills = sorted(p.name for p in (root / "skills").iterdir() if p.is_dir())
expected = set(skills)
bad = False


def check(label, missing, extra):
    global bad
    for name in sorted(missing):
        print(f"{label} missing skill: {name}")
        bad = True
    for name in sorted(extra):
        print(f"{label} lists unknown skill: {name}")
        bad = True


# root SKILL.md routing table: backticked names between ## routing and the rules block
skill_md = (root / "SKILL.md").read_text()
block = re.search(r"## routing(.*?)<!-- rules:start -->", skill_md, re.S)
routing = set(re.findall(r"`([a-z][a-z0-9-]*)`", block.group(1))) if block else set()
check("routing table", expected - routing, routing - expected)

# rules/dnaism.md: names in the trailing (...) list of the skills line
rules = (root / "rules" / "dnaism.md").read_text()
m = re.search(r"load skills/<name>/SKILL\.md for the task \(([^)]*)\)", rules)
rule_names = {x.strip() for x in m.group(1).split(",")} if m else set()
check("rules/dnaism.md", expected - rule_names, rule_names - expected)

# README.md skills table: names in the first column
readme = (root / "README.md").read_text()
sec = re.search(r"## skills(.*?)(?:\n## |\Z)", readme, re.S)
readme_names = set()
for line in (sec.group(1).splitlines() if sec else []):
    if not line.startswith("|"):
        continue
    first = line.strip("|").split("|")[0].strip()
    if not first or first == "skill" or set(first) <= set("-: "):
        continue
    for name in first.split(","):
        name = name.strip("` ")
        if name != "dnaism" and re.fullmatch(r"[a-z][a-z0-9-]*", name):
            readme_names.add(name)
check("README.md", expected - readme_names, readme_names - expected)

# frontmatter name must match the folder
for name in skills:
    lines = (root / "skills" / name / "SKILL.md").read_text().splitlines()
    fm = next((l for l in lines if l.startswith("name:")), "")
    if fm.split(":", 1)[1].strip() != name:
        print(f"skills/{name}/SKILL.md name: does not match its dir")
        bad = True

if bad:
    print("add or remove the skill in the routing table, rules/dnaism.md and README.md, then run scripts/sync-rules.py")
    sys.exit(1)
print(f"skills ok: {len(skills)} skills listed in routing, rules and README")
PY

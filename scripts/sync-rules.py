#!/usr/bin/env python3
"""copy the single rules source into every harness rule file and the SKILL.md block"""
import pathlib
import sys

root = pathlib.Path(__file__).resolve().parent.parent
router = (root / "SKILL.md").read_text()
name = next(l.split(":", 1)[1].strip() for l in router.splitlines() if l.startswith("name:"))
rules = sorted((root / "rules").glob("*.md"))
if len(rules) != 1:
    sys.exit(f"expected one rules/*.md, found {len(rules)}")
stem = rules[0].stem
src = rules[0].read_text()
head = f"<!-- generated from rules/{stem}.md, edit the source and run scripts/sync-rules.py -->\n"
start, end = "<!-- rules:start -->", "<!-- rules:end -->"

# path -> frontmatter the harness wants
copies = {
    f".agents/rules/{stem}.md": "",
    f".clinerules/{stem}.md": "",
    f".qoder/rules/{stem}.md": "",
    ".github/copilot-instructions.md": "",
    "GEMINI.md": "",
    f".windsurf/rules/{stem}.md": "---\ntrigger: always_on\n---\n",
    f".kiro/steering/{stem}.md": "---\ninclusion: always\n---\n",
    f".cursor/rules/{stem}.mdc": f"---\ndescription: {name} personal style rules\nalwaysApply: true\n---\n",
}


def skill_text():
    a = router.index(start) + len(start)
    b = router.index(end)
    body = src.split("\n", 1)[1].strip("\n")  # drop the h1
    return router[:a] + "\n" + body + "\n" + router[b:]


want = {p: fm + head + src for p, fm in copies.items()}
want["SKILL.md"] = skill_text()

# copies left behind by an old rules file name, only touch files we generated
marker = "<!-- generated from rules/"
stale = []
for d in (".agents/rules", ".clinerules", ".qoder/rules", ".windsurf/rules", ".kiro/steering", ".cursor/rules"):
    dd = root / d
    if not dd.is_dir():
        continue
    for f in sorted(dd.iterdir()):
        rel = f.relative_to(root).as_posix()
        if f.is_file() and rel not in want and marker in f.read_text():
            stale.append(f)

check = "--check" in sys.argv
bad = 0
for f in stale:
    rel = f.relative_to(root).as_posix()
    if check:
        print("stale:", rel)
        bad = 1
    else:
        f.unlink()
        print("removed", rel)
for p, text in want.items():
    f = root / p
    have = f.read_text() if f.exists() else None
    if have == text:
        continue
    if check:
        print("drift:", p)
        bad = 1
    else:
        f.parent.mkdir(parents=True, exist_ok=True)
        f.write_text(text)
        print("wrote", p)
sys.exit(bad)

#!/usr/bin/env python3
"""copy rules/dnaism.md into every harness rule file and the SKILL.md block"""
import pathlib
import sys

root = pathlib.Path(__file__).resolve().parent.parent
src = (root / "rules/dnaism.md").read_text()
head = "<!-- generated from rules/dnaism.md, edit the source and run scripts/sync-rules.py -->\n"
start, end = "<!-- rules:start -->", "<!-- rules:end -->"

# path -> frontmatter the harness wants
copies = {
    ".agents/rules/dnaism.md": "",
    ".clinerules/dnaism.md": "",
    ".qoder/rules/dnaism.md": "",
    ".github/copilot-instructions.md": "",
    "GEMINI.md": "",
    ".windsurf/rules/dnaism.md": "---\ntrigger: always_on\n---\n",
    ".kiro/steering/dnaism.md": "---\ninclusion: always\n---\n",
    ".cursor/rules/dnaism.mdc": "---\ndescription: dnaism personal style rules\nalwaysApply: true\n---\n",
}


def skill_text():
    s = (root / "SKILL.md").read_text()
    a = s.index(start) + len(start)
    b = s.index(end)
    body = src.split("\n", 1)[1].strip("\n")  # drop the h1
    return s[:a] + "\n" + body + "\n" + s[b:]


want = {p: fm + head + src for p, fm in copies.items()}
want["SKILL.md"] = skill_text()

check = "--check" in sys.argv
bad = 0
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

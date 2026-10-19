# dnaism agent rules

one-line summary: personal style skills, improved by use, every file follows the style it teaches.

## layout

| path | holds |
|---|---|
| rules/dnaism.md | single source of always-on rules |
| SKILL.md | root router, rules block generated from the source |
| skills/<name>/SKILL.md | one skill per folder |
| harness dirs | generated rule copies and manifests, see docs/agent-portability.md |
| commands/, .opencode/command/ | slash commands for learn and review |
| docs/skills.md | add, edit, delete or improve a skill |
| examples/ | before and after samples of the style |
| corrections.md | log of agent mistakes and the rule each produced |
| scripts/, tests/ | sync, check, link helpers and their tests |

## author rules

| rule | detail |
|---|---|
| em-dashes | never, anywhere |
| comments | short phrases, no capital at the start |
| names | kebab-case files and folders |
| docs | one-line summary on top, tables over prose |
| size | cut anything not needed |

## improve loop

| trigger | action |
|---|---|
| i correct your output | load paul-learn, add the rule, log it |
| a global rule changes | edit rules/dnaism.md, run `python3 scripts/sync-rules.py` |
| a rule never fires | delete it |
| a skill passes 100 lines | move detail into examples/ |
| before finishing any edit | run `bash scripts/check.sh` |

## hard rules

- never hand-edit generated harness copies
- frontmatter is `name` and `description` only
- skill bodies stay under 100 lines
- one rule per correction, no duplicates

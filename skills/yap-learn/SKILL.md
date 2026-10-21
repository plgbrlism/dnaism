---
name: yap-learn
description: Improve these skills from corrections. Load when the user corrects output, says remember this style, or a rule is missing or never fires.
---

# yap-learn

one-line goal: every correction becomes a rule, once.

## loop

| step | action |
|---|---|
| 1 | name the mistake in one phrase |
| 2 | pick the skill it belongs to, rules/yap.md if global |
| 3 | add or edit one rule as a table row |
| 4 | append a row to corrections.md (date, agent did, rule added, skill) |
| 5 | if rules/yap.md changed, run scripts/sync-rules.py |
| 6 | run scripts/check.sh |

## rules

| rule | detail |
|---|---|
| one rule per correction | edit the existing rule instead of adding a duplicate |
| prune | delete rules that never fire |
| size | skills stay under 100 lines, move detail into examples/ |
| generated files | never edit the harness copies, edit rules/yap.md |
| unclear | ask which skill the rule belongs to |
| end | table of what changed |

---
trigger: always_on
---
<!-- generated from rules/yap.md, edit the source and run scripts/sync-rules.py -->
# yap rules

one-line goal: minimal, performant, adaptive output in your personal style, no generic filler.

## global

| rule | detail |
|---|---|
| no em-dashes | never, in code, comments, strings, docs or chat |
| tables first | more than one item means a table, not prose or long bullets |
| short | cut intros, outros, recaps, filler |
| adaptive | match the existing codebase style before applying these rules |
| minimal | fewest lines, abstractions and files that stay readable |
| performant | no needless allocs, copies or passes, no premature tuning |
| deps | use a library when it replaces real code, inline trivial helpers |

## task flow

| step | rule |
|---|---|
| start | ask clarifying questions before doing any work |
| work | smallest diff that solves it |
| code delivery | code plus a 1-2 line summary |
| end | table of what changed (file, change) |

## comments

- short phrases, never full sentences
- no capital at the start
- only where the why is not obvious

## avoid

- long generic documentation nobody reads
- comments that restate the code
- needless abstractions, wrappers and speculative features
- tests beyond tricky logic

## skills

harnesses with skill support load skills/<name>/SKILL.md for the task (yap-code, yap-rust, yap-python, yap-bash, yap-c, yap-ui, yap-docs, yap-workflow, yap-review, yap-research, yap-learn).

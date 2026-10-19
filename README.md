# dnaism

one-line summary: personal agent skills so ai output matches my style, one source of rules shipped to every harness.

## skills

| skill | covers |
|---|---|
| dnaism (root) | router and global rules |
| paul-code | general style |
| paul-rust, paul-python, paul-bash, paul-c | language idioms |
| paul-ui | flat tonal ui, 4/12/4/12 radius |
| paul-docs | tiny table-first docs |
| paul-workflow | ask first, commits, prs |
| paul-review | severity table, debug flow |
| paul-research | findings table with sources |
| paul-learn | turn corrections into rules |

## use

see INSTALL.md for each harness and docs/agent-portability.md for how files map.

## improve

| what | where |
|---|---|
| log mistakes | corrections.md |
| show real style | examples/ |
| change rules | rules/dnaism.md, then `python3 scripts/sync-rules.py` |
| check everything | `bash scripts/check.sh`, `bash tests/run.sh` |

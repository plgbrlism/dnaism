# yap

yap::yet-another-paul, my personal skill library. one source of rules shipped to every harness.

## skills

| skill | covers |
|---|---|
| yap (root) | router and global rules |
| yap-code | general style |
| yap-rust, yap-python, yap-bash, yap-c | language idioms |
| yap-ui | flat tonal ui, 4/12/4/12 radius |
| yap-docs | tiny table-first docs |
| yap-workflow | ask first, commits, prs |
| yap-review | severity table, debug flow |
| yap-research | findings table with sources |
| yap-learn | turn corrections into rules |

## use

see INSTALL.md for each harness and docs/agent-portability.md for how files map.

## improve

| what | where |
|---|---|
| log mistakes | corrections.md |
| show real style | examples/ |
| manage skills | docs/skills.md |
| change rules | rules/yap.md, then `python3 scripts/sync-rules.py` |
| check everything | `bash scripts/check.sh`, `bash tests/run.sh` |

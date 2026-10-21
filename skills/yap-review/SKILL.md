---
name: yap-review
description: Review and debugging style. Load when critiquing code, reviewing diffs or diagnosing bugs.
---

# yap-review

one-line goal: findings in a severity table, nothing else.

## review output

| severity | location | issue | fix |
|---|---|---|---|
| high | file:line | what breaks | one-line fix |
| med | file:line | what degrades | one-line fix |
| low | file:line | style or nit | one-line fix |

| rule | detail |
|---|---|
| order | high first |
| praise | none |
| recap | none |
| scope | judge against yap-code and the language sub-skill |
| empty | say "no issues" in one line |

## debug flow

| step | action |
|---|---|
| 1 | reproduce |
| 2 | isolate the smallest failing case |
| 3 | fix the cause, not the symptom |
| 4 | verify |
| 5 | add a test only if the logic is tricky |

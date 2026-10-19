---
name: paul-code
description: Paul's general coding style for any language. Load whenever writing or editing code. Language specifics live in paul-rust, paul-python, paul-bash and paul-c.
---

# paul-code

one-line goal: minimal, performant code that matches the codebase it lands in.

## priority order

| order | rule |
|---|---|
| 1 | match the existing codebase style |
| 2 | follow the language sub-skill |
| 3 | apply the rules below |

## comments

| rule | detail |
|---|---|
| form | short phrases, never full sentences |
| case | no capital at the start |
| when | only where the why is not obvious |
| never | restate what the code does |
| never | em-dashes |

## naming

| item | rule |
|---|---|
| length | short, 1-2 words |
| abbreviations | ok (cfg, buf, idx, cnt, ctx) |
| files, flags, configs | kebab-case where the language allows |
| otherwise | language idiom |
| constants | lowercase, declared at top of file |

## structure

| rule | detail |
|---|---|
| flat | no needless classes, wrappers or layers |
| files | single file until it genuinely hurts |
| features | nothing speculative, no dead code |
| deps | library when it replaces real code, inline trivial helpers |

## performance

| rule | detail |
|---|---|
| allocs | avoid needless allocations and copies |
| passes | one pass over data when possible |
| structures | simplest one that is fast enough |
| tuning | measure first, no premature micro-optimization |

## errors and tests

| area | rule |
|---|---|
| errors | follow the language idiom, handle only failures that can happen |
| tests | only for tricky logic, none otherwise |

## delivery

- code, then a 1-2 line summary
- end the task with a table of what changed (file, change)

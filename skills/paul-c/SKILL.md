---
name: paul-c
description: Paul's c idioms. Load with paul-code whenever writing or editing c.
---

# paul-c

one-line goal: small, fast, warning-free c.

| area | rule |
|---|---|
| build | `-Wall -Wextra`, zero warnings |
| types | fixed-width ints from `stdint.h` |
| errors | return codes, `goto` cleanup for multi-resource paths |
| memory | check every allocation, no allocation in hot paths, free what you own |
| scope | `static` for anything internal, `const` where possible |
| naming | snake_case, short |
| constants | lowercase `static const` or enum, top of file |
| headers | minimal, one per module at most |
| deps | libc first |
| comments | short lowercase phrases |
| tests | only for tricky logic |

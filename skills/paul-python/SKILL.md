---
name: paul-python
description: Paul's python idioms. Load with paul-code whenever writing or editing python scripts or libraries.
---

# paul-python

one-line goal: short, stdlib-first python.

| area | rule |
|---|---|
| structure | functions over classes, a class only when state needs it |
| stdlib | first choice: `pathlib`, `itertools`, `collections`, `subprocess` |
| strings | f-strings |
| iteration | comprehensions and generators, no needless lists |
| errors | exceptions, narrow `except`, never bare `except` |
| types | hints only where they clarify |
| naming | snake_case modules and names, short; script files may be kebab-case |
| constants | lowercase at top per paul-code |
| format | ruff |
| deps | library when it replaces real code |
| comments | short lowercase phrases |
| tests | only for tricky logic |

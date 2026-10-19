# python csv sum

one-line summary: sum the second column of a csv.

| generic | dnaism |
|---|---|
| class, argparse, docstrings, pandas import | one expression, stdlib only |

```python
import csv, sys

# sum col 2, skip blank rows
print(sum(float(r[1]) for r in csv.reader(open(sys.argv[1])) if r))
```

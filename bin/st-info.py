#!/usr/bin/env srun.sh

import sys
from tabulate import tabulate

from schrodinger.structure import StructureReader

fnames = sys.argv[1:]

headers = ["title", "molecule count", "atom count", "file name"]
data = []

for fname in fnames:
    for st in StructureReader(fname):
        data.append([st.title, st.mol_total, st.atom_total, fname])

print(tabulate(data, headers=headers))

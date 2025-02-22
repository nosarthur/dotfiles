"""
If one input file, split the input; If many input files, merge them into one.

- sr zipper.py a.mae.gz
- sr zipper.py a.mae b.mae c.maegz d.mae.gz e.mol2 ...
"""

import sys

from pathlib import Path

from rdkit import Chem

fnames = sys.argv[1:]
if not fnames:
    print("At least 1 input file")
    sys.exit()

if len(fnames) == 1:  # -------------------split
    p = Path(fnames[0])
    suppl = Chem.SDMolSupplier(str(p), removeHs=False, sanitize=True)
    print(p.stem)
    for i, mol in enumerate(suppl, start=1):
        if mol is None:
            continue
        fout = f"{p.stem}_{i}.sdf"
        with Chem.SDWriter(fout) as writer:
            writer.write(mol)
    print(i, "in total")
else:  # ----------------------------------merge
    fout = "merged.mae.gz"
    all = []
    print(len(all), "in total. write to", Path(fout).absolute())

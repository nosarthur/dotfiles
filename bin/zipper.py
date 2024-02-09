#!/usr/bin/env srun.sh

#!$S/internal/bin/python3
"""
If one input file, split the input; If many input files, merge them into one.

- sr zipper.py a.mae.gz
- sr zipper.py a.mae b.mae c.maegz d.mae.gz e.mol2 ...
"""
import sys
from pathlib import Path

from schrodinger.structure import StructureReader, StructureWriter


fnames = sys.argv[1:]
if not fnames:
    print("At least 1 input file")
    sys.exit()

if len(fnames) == 1:  # -------------------split
    count = 0
    for st in StructureReader(fnames[0]):
        # print(st.title[:-1])
        fout = st.title + f"_{count}.maegz"
        fout = st.title + ".maegz"
        st.write(fout)
        print("write to", Path(fout).absolute())
        count += 1
    print(count, "in total")
else:  # ----------------------------------merge
    fout = "merged.mae.gz"
    all = []
    for fn in fnames:
        all.extend(list(StructureReader(fn)))
    with StructureWriter(fout) as writer:
        writer.extend(all)
    print(len(all), "in total. write to", Path(fout).absolute())

#!/usr/bin/env srun.sh

"""
extract structures whose titles include a substring
"""
import sys

from schrodinger.structure import StructureReader, StructureWriter

print(sys.argv)
if len(sys.argv) == 3:
    fin, title = sys.argv[1:]
else:
    print("filename, title")
    sys.exit()

for st in StructureReader(fin):
    if title in st.title:
        fname = st.title + ".maegz"
        st.write(fname)
        print("write to " + fname)

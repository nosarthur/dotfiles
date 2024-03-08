#!/usr/bin/env srun.sh

import sys
import click
from tabulate import tabulate

from schrodinger.structure import StructureReader


@click.command(
    context_settings={"show_default": True, "help_option_names": ["-h", "--help"]},
)
@click.argument("fnames", nargs=-1)
@click.option(
    "-p",
    "--property",
    help="additional CT-level property to extract",
    default="s_pdb_PDB_CRYST1_Space_Group",
)
def main(fnames, property):

    headers = ["title", "molecule count", "atom count", "file name", property]
    data = []

    for fname in fnames:
        for st in StructureReader(fname):
            got = st.property.get(property, "")
            data.append([st.title, st.mol_total, st.atom_total, fname, got])

    print(tabulate(data, headers=headers))


if __name__ == "__main__":
    main()

"""
Given a structure file or SMILES string on the command line, depict the
structure(s) using ASCII art to stdout.
"""
from __future__ import print_function
from __future__ import division

# Users: tubert
from __future__ import absolute_import
from past.utils import old_div
import argparse
import os
import sys

from schrodinger import structure
from schrodinger.structutils import smiles
from schrodinger.utils import fileutils
from six.moves import range

try:
    MAX_COLS = int(os.popen('stty size', 'r').read().split()[1])
except:
    MAX_COLS = 80
MAX_SCALE = 10.0  # columns per angstrom
ASPECT_RATIO = 0.4  # horizontal / vertical
PADDING = 2
MAX_ATOMS = 500

BOND_CHARS = [' ', '.', '=', '#']


def get_box(st):
    return ([min(a.xyz[i] for a in st.atom) for i in range(3)],
            [max(a.xyz[i] for a in st.atom) for i in range(3)])


def int_coords_for_atom(atom, box, scale):
    x = PADDING + int((atom.x - box[0][0]) * scale[0])
    y = PADDING + int((atom.y - box[0][1]) * scale[1])
    return x, y


def draw_line(screen, char, x1, y1, x2, y2):
    vertical = False
    if abs(x2 - x1) < abs(y2 - y1):
        x1, y1 = y1, x1
        x2, y2 = y2, x2
        vertical = True
    try:
        slope = 1.0 * (y2 - y1) / (x2 - x1)
    except ZeroDivisionError:
        return

    if x1 > x2:
        x1, x2 = x2, x1
        y1, y2 = y2, y1
    for x in range(x1 + 1, x2):
        y = int(round(y1 + slope * (x - x1)))
        if vertical:
            screen[x][y] = char
        else:
            screen[y][x] = char


def cat_structure(st, xscale=None):
    box = get_box(st)
    (xmin, ymin, zmin), (xmax, ymax, zmax) = box

    if xscale is None:
        xscale = min(old_div((MAX_COLS - PADDING * 2), (xmax - xmin)), MAX_SCALE)
    yscale = xscale * ASPECT_RATIO
    scale = (xscale, yscale)
    rows = int(PADDING * 2 + (ymax - ymin) * yscale)
    cols = int(round(xscale * (xmax - xmin) + 2 * PADDING))
    screen = [[' '] * cols for i in range(rows)]

    for bond in st.bond:
        x1, y1 = int_coords_for_atom(bond.atom1, box, scale)
        x2, y2 = int_coords_for_atom(bond.atom2, box, scale)
        draw_line(screen, BOND_CHARS[bond.order], x1, y1, x2, y2)

    for atom in st.atom:
        x, y = int_coords_for_atom(atom, box, scale)
        sym = atom.element
        screen[y][x] = sym[0]
        if len(sym) > 1:
            screen[y][x + 1] = sym[1]

    for line in reversed(screen):
        print(''.join(line))


def to_2d(st):
    gen = smiles.SmilesGenerator()
    smiles_str = gen.getSmiles(st)
    smiles_st = structure.SmilesStructure(smiles_str)
    return smiles_st.get2dStructure()


def is_3d(st):
    return any(atom.z for atom in st.atom)


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        'file_or_smiles', help="structure input file or SMILES string")
    parser.add_argument(
        '-n',
        default=1,
        help="index of structure to display. May be a range ('-n 1-4')")
    parser.add_argument(
        '-all', action='store_true', help='show all structures in the file')
    parser.add_argument(
        '-scale',
        type=float,
        default=None,
        help='scale in columns per Angstrom. Default is computed based on screen '
        'size, capped at 10.0')
    return parser.parse_args()


def parse_range(n):
    try:
        start = int(n)
        return start, start
    except ValueError:
        return (int(s) for s in n.split('-'))


def get_reader(filename, index=1):
    format = fileutils.get_structure_file_format(filename)
    if format == fileutils.SMILES:
        cls = structure.SmilesReader
    elif format == fileutils.SMILESCSV:
        cls = structure.SmilesCsvReader
    else:
        cls = structure.StructureReader
    return cls(filename, index=index)


def main():
    args = parse_args()
    if os.path.isfile(args.file_or_smiles):
        start, end = parse_range(args.n)
        reader = get_reader(args.file_or_smiles, index=start)
        for i, st in enumerate(reader, start):
            if i > end and not args.all:
                break
            if isinstance(st, structure.SmilesStructure):
                st = st.get2dStructure()
            if len(st.atom) > MAX_ATOMS:
                continue
            if is_3d(st):
                st = to_2d(st)
            cat_structure(st, args.scale)
    else:
        st = structure.SmilesStructure(args.file_or_smiles).get2dStructure()
        cat_structure(st, args.scale)


if __name__ == '__main__':
    main()


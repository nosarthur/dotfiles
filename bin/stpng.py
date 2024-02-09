import argparse
import os

from schrodinger import structure
from schrodinger.utils import fileutils
from schrodinger.Qt import QtCore
from schrodinger.ui.qt import structure2d
from schrodinger.Qt.QtWidgets import QApplication


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
    parser.add_argument('out', nargs='?', default='out.png', help='output file (png)')
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


def cat_structure(st, out):
    img = structure2d.generate_qimage_from_structure(st, 300, 300)
    ba = QtCore.QByteArray()
    img.save(out)


def main():
    app = QApplication(['foo', '-platform', 'offscreen'])
    args = parse_args()
    if os.path.isfile(args.file_or_smiles):
        start, end = parse_range(args.n)
        reader = get_reader(args.file_or_smiles, index=start)
        for i, st in enumerate(reader, start):
            if i > end and not args.all:
                break
            if isinstance(st, structure.SmilesStructure):
                st = st.get2dStructure()
            cat_structure(st, args.out)
    else:
        st = structure.SmilesStructure(args.file_or_smiles).get2dStructure()
        cat_structure(st, args.out)


if __name__ == '__main__':
    main()

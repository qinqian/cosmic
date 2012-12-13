#!/usr/bin/python

"""
convert tsv database to bed format file
"""

import sys
def line15(l):
    return l[13]

def line14(l):
    return l[12]

def readin(tsv, bed):
    bed_file = open(bed, 'w')
    index = lambda x: line15(x) if len(x) == 15 else line14(x)
    with open(tsv, 'rU') as f:
        for line in f.xreadlines():
            line = line.strip().split('\t')
            print len(line)
            print line

            print >> bed_file, line[1],'\t', index(line)
    f.close()
    bed_file()
                
def main(tsv, bed):
    readin(tsv, bed)

if  __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])

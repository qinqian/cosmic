#!/usr/bin/env python
# use to extract tsv files to bed files

from pandas import read_csv
from pandas import DataFrame
from pandas.tools.plotting import scatter_matrix
import sys
import os

class Cosmic():
    """ for convert Cosmic data to BED regularly"""
    def __init__(self, path):
        self.path = path

    def tsv(self, f = lambda x: True):
        """
        """
        return

    def csv(self):
        pass
    def pcsv(self):
        """
        """
        self.df = read_csv(self.path, index_col=0, header=0) # index_col and header is important
        ## delete the info line
        self.df = self.df[:-1]

def main(path):
    data = Cosmic(path)
    data.pcsv()
    mut_position =  data.df['GRCh37 genome position '] # note the space
    # mutation position
    Mut_pos =  mut_position.apply(lambda x: [x.split(":")[0]] + x.split(":")[1].split("-"))
    print Mut_pos[1:3]
    # wild type 
    WT = data.df['WT_SEQ ']
    print WT[1:2]
    # mutated sequence
    Mut = data.df['MUT_SEQ']
    print type(WT), type(Mut)
    # print data.df.columns
    # data.df.save("testout")
    # plot
    # scatter_matrix(data.df, alpha=2)
    #Mut_pos.to_string()
    f = open(os.path.join('../temp/','cosmic_noncodingMut.txt'), 'w')
    for element in Mut_pos:
        print >>f, 'chr'+element[0] + '\t' + '\t'.join(element[1:])
    f.close()

if __name__ == "__main__":
    try:
        main(sys.argv[1])
    except KeyboardInterrupt:
        print >>sys.error, "user interupt"

#!/usr/bin/env python

'''This code is to parse bitwise flags after alignment'''

import argparse


def get_args():
    '''argument parser for generating input in terminal. All arguments are necessary
        -f input File name'''
    parser = argparse.ArgumentParser(description="A program to introduce yourself")
    parser.add_argument("-f", "--fileread1", help="Your filename", type=str)
    return parser.parse_args()

def parse_read_bitflag(File: str):
    '''Takes sam file as input and checks if read is repeat sequence then 
        if it is mapped in that order.'''
    
    with open(File) as fh:
        mapped=0
        unmapped=0
        for line in fh:
            #getting rid of header lines
            if not line.startswith('@'):
                #splitting line into list
                line = line.split()
                #getting bitwise flag from list
                flag = int(line[1])
                #checking bitwise flag if repeat sequence then if mapped
                if((flag & 256) != 256):
                    if((flag & 4) != 4):
                        mapped+=1
                    else:
                        unmapped+=1
        return mapped, unmapped



if __name__ == "__main__":  

    args = get_args()
    
    file1 = args.fileread1


    mapped_uniquereads, unmapped_reads=parse_read_bitflag(file1)

    print(f'mapped unique reads: {mapped_uniquereads}\t unmapped reads: {unmapped_reads}')
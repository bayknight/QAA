#!/usr/bin/env python

#Bailey Knight 9 September 2023
'''Count reads and plot read length distributions'''


import argparse
import numpy as np
import gzip
from matplotlib import pyplot as plt

def get_args():
    '''argument parser for generating input in terminal. All arguments are necessary
        -r input File name
        -w'''
    parser = argparse.ArgumentParser(description="A program to introduce yourself")
    parser.add_argument("-f", "--fileread1", help="Your filename", type=str)
    parser.add_argument("-F", "--fileread2", help="Your filename", type=str)
    return parser.parse_args()


def read_length(fileread):
    read_lengths = []
    with gzip.open(fileread, 'rt') as fh:
        for i, line in enumerate(fh):
            #check every 4th line
            if i%4 == 3:
                #clean every 4th line
                line = line.strip()
                read_lengths.append(len(line))
    return read_lengths

if __name__ == "__main__":  

    args = get_args()
    
    fileread1 = args.fileread1
    fileread2 = args.fileread2
    
    
    read_lengths1 = read_length(fileread1)
    read_lengths2 = read_length(fileread2)

    combined = read_lengths1 + read_lengths2
    dif = max(combined)-min(combined) # type: ignore

   
    
    
    figure_data1 = np.array(read_lengths1)
    figure_data2 = np.array(read_lengths2)


    path = "/projects/bgmp/bailey/bioinfo/Bi623/Assignments/QAA/Figures/"
    figure_name = fileread1.split('/')[-1]
    plt.figure(figsize=(8,6), dpi=200)
    plt.hist(figure_data1, bins=dif, edgecolor='steelblue', histtype='step', label = "Read 1")
    plt.hist(figure_data2, bins=dif, edgecolor='orange', histtype='step', label = "Read 2")
    plt.legend()
    plt.xticks(np.arange(min(combined), max(combined), step=5), fontsize=7.5)
    plt.yticks(fontsize=7.5)
    plt.grid(True)
    plt.yscale("log")
    plt.xlabel("Read Length(bp)", fontsize=15)
    plt.ylabel("Read Length Frequency", fontsize=15)
    plt.title("Read Length Distribution 14_3B_control_s10", fontsize=20)
    plt.savefig(path + f'{figure_name}_hist.png')         

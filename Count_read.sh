#!/bin/bash                                  
#SBATCH --account=bgmp                    #REQUIRED: which account to use
#SBATCH --partition=compute               #REQUIRED: which partition to use
#SBATCH --cpus-per-task=8                 #optional: number of cpus, default is 1
#SBATCH --mem=16GB                        #optional: amount of memory, default is 4GB may need to change stuff


#example_run sbatch ./Count_read.sh Trimmed_reads/trimmed_R1_14_3B_control_S10_L008_R1_001.fastq.gz Trimmed_reads/trimmed_R2_14_3B_control_S10_L008_R2_001.fastq.gz
#example_run sbatch ./Count_read.sh Trimmed_reads/trimmed_R1_8_2F_fox_S7_L008_R1_001.fastq.gz Trimmed_reads/trimmed_R2_8_2F_fox_S7_L008_R2_001.fastq.gz
set -e
file1=$1
file2=$2

conda activate QAA
/usr/bin/time -v \
    ./Count_reads.py -f $file1 -F $file2


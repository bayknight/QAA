#!/bin/bash                                  
#SBATCH --account=bgmp                    #REQUIRED: which account to use
#SBATCH --partition=compute               #REQUIRED: which partition to use
#SBATCH --cpus-per-task=8                 #optional: number of cpus, default is 1
#SBATCH --mem=16GB                        #optional: amount of memory, default is 4GB may need to change stuff


#example_run sbatch ./cutadapt.sh AGATCGGAAGAGCACACGTCTGAACTCCAGTCA AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT /projects/bgmp/shared/2017_sequencing/demultiplexed/8_2F_fox_S7_L008_R1_001.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/8_2F_fox_S7_L008_R2_001.fastq.gz
# cutadapt -a ADAPTER_FWD -A ADAPTER_REV -o out.1.fastq -p out.2.fastq reads.1.fastq reads.2.fastq
set -e

adapter=$1
adapter2=$2
filename=$3
filename2=$4
intermediate_file_R1=/projects/bgmp/bailey/bioinfo/Bi623/Assignments/QAA/Trimmed_reads/intermediate_file_R1.fastq.gz
intermediate_file_R2=/projects/bgmp/bailey/bioinfo/Bi623/Assignments/QAA/Trimmed_reads/intermediate_file_R2.fastq.gz
outputfile1=/projects/bgmp/bailey/bioinfo/Bi623/Assignments/QAA/Trimmed_reads/"trimmed_R1_"$(basename -- "$filename")
outputfile2=/projects/bgmp/bailey/bioinfo/Bi623/Assignments/QAA/Trimmed_reads/"trimmed_R2_"$(basename -- "$filename2")
outputfile1_2=/projects/bgmp/bailey/bioinfo/Bi623/Assignments/QAA/Trimmed_reads/"trimmed_Un1_"$(basename -- "$filename")
outputfile2_2=/projects/bgmp/bailey/bioinfo/Bi623/Assignments/QAA/Trimmed_reads/"trimmed_Un2_"$(basename -- "$filename2")




conda activate QAA
/usr/bin/time -v \
    cutadapt --cores=8 -a $adapter -A $adapter2 -o $intermediate_file_R1 -p $intermediate_file_R2 $filename $filename2

    echo "starting trimmomatic"
    /usr/bin/time -v \
    trimmomatic PE -threads 8 -phred33 $intermediate_file_R1 $intermediate_file_R2 $outputfile1 $outputfile1_2 $outputfile2 $outputfile2_2 LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35


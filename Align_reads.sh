#!/bin/bash
#SBATCH --account=bgmp                    #REQUIRED: which account to use
#SBATCH --partition=compute               #REQUIRED: which partition to use
#SBATCH --cpus-per-task=8                 #optional: number of cpus, default is 1
#SBATCH --mem=32G                        #optional: amount of memory, default is 4GB

#example sbatch ./Align_reads.sh Trimmed_reads/trimmed_R1_8_2F_fox_S7_L008_R1_001.fastq.gz Trimmed_reads/trimmed_R2_8_2F_fox_S7_L008_R2_001.fastq.gz ./8_2F_aligned/8_2F_fox_S7_L008
#example sbatch ./Align_reads.sh Trimmed_reads/trimmed_R1_14_3B_control_S10_L008_R1_001.fastq.gz Trimmed_reads/trimmed_R2_14_3B_control_S10_L008_R2_001.fastq.gz ./14_3B_aligned/14_3B_control_S10_L008
conda activate QAA

#defining variables
read_file1=$1
read_file2=$2
Genome_directory="/projects/bgmp/bailey/bioinfo/Bi623/Assignments/QAA/Mousedb"
Output_name=$3
#capture run stats then align reads.
/usr/bin/time -v \
    STAR --runThreadN 8 --runMode alignReads \
        --outFilterMultimapNmax 3 \
        --outSAMunmapped Within KeepPairs \
        --alignIntronMax 1000000 --alignMatesGapMax 1000000 \
        --readFilesCommand zcat \
        --readFilesIn $read_file1 $read_file2 \
        --genomeDir $Genome_directory \
        --outFileNamePrefix $Output_name


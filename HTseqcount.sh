#!/bin/bash
#SBATCH --account=bgmp                    #REQUIRED: which account to use
#SBATCH --partition=compute               #REQUIRED: which partition to use
#SBATCH --cpus-per-task=4                 #optional: number of cpus, default is 1
#SBATCH --mem=16G                        #optional: amount of memory, default is 4GB



# sbatch HTseqcount.sh 14_3B_aligned/14_3B_control_S10_L008Aligned.out.sam DBfiles/Mus_musculus.GRCm39.110.gtf /projects/bgmp/bailey/bioinfo/Bi623/Assignments/QAA/HTseq_output/14_3B_control
# sbatch HTseqcount.sh 8_2F_aligned/8_2F_fox_S7_L008Aligned.out.sam DBfiles/Mus_musculus.GRCm39.110.gtf /projects/bgmp/bailey/bioinfo/Bi623/Assignments/QAA/HTseq_output/8_2F
set -e
conda activate QAA

#defining variables
sam=$1
gtf=$2
output=$3
#capture run stats then align reads.
/usr/bin/time -v \
    htseq-count --stranded=yes $sam $gtf > $output"stranded.txt"

/usr/bin/time -v \
    htseq-count --stranded=reverse $sam $gtf > $output"reverse.txt"


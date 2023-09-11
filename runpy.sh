#!/bin/bash                                  
#SBATCH --account=bgmp                    #REQUIRED: which account to use
#SBATCH --partition=compute               #REQUIRED: which partition to use
#SBATCH --cpus-per-task=4                 #optional: number of cpus, default is 1
#SBATCH --mem=8GB                        #optional: amount of memory, default is 4GB may need to change stuff


#example run sbatch ./runpy.sh /projects/bgmp/shared/2017_sequencing/demultiplexed/8_2F_fox_S7_L008_R1_001.fastq.gz 8_2F_fox_S7_R1
#example run sbatch ./runpy.sh /projects/bgmp/shared/2017_sequencing/demultiplexed/8_2F_fox_S7_L008_R2_001.fastq.gz 8_2F_fox_S7_R2
# sbatch ./runpy.sh /projects/bgmp/shared/2017_sequencing/demultiplexed/14_3B_control_S10_L008_R1_001.fastq.gz 14_3B_control_S10_R1
# sbatch ./runpy.sh /projects/bgmp/shared/2017_sequencing/demultiplexed/14_3B_control_S10_L008_R2_001.fastq.gz 14_3B_control_S10_R2
#added lables later but not rerun.
set -e

filename=$1
length_read=$(zcat $filename | head -2 | grep -v "^@" | wc -L)
#test with test file
#length_read=$(cat $filename | head -2 | wc -L)


conda activate demultiplex

echo "read length = $length_read"
echo "start python script"
/usr/bin/time -v \
    ./mean_qscore.py -f "$filename" -l $length_read

conda deactivate

echo "complete"
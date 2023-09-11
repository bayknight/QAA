#!/bin/bash
#SBATCH --account=bgmp                    #REQUIRED: which account to use
#SBATCH --partition=compute               #REQUIRED: which partition to use
#SBATCH --cpus-per-task=8                 #optional: number of cpus, default is 1
#SBATCH --mem=32G                        #optional: amount of memory, default is 4GB

conda activate QAA


#defining variables
genome_Directory="/projects/bgmp/bailey/bioinfo/Bi623/Assignments/QAA/Mousedb"
fastafile="/projects/bgmp/bailey/bioinfo/Bi623/Assignments/QAA/DBfiles/Mus_musculus.GRCm39.dna.primary_assembly.fa"
GTFfile="/projects/bgmp/bailey/bioinfo/Bi623/Assignments/QAA/DBfiles/Mus_musculus.GRCm39.110.gtf"

#capture run stats
/usr/bin/time -v \
    STAR --runMode genomeGenerate --runThreadN 8 \
        --genomeDir $genome_Directory \
        --genomeFastaFiles $fastafile \
        --sjdbGTFfile $GTFfile
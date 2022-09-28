#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem-per-cpu=4G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=trinity_assembly
#SBATCH --mail-user=marco.visani@students.unibe.ch
#SBATCH --mail-type=end,error
#SBATCH --output=/data/users/mvisani/genome_assembly/scripts/output_%j.o
#SBATCH --error=/data/users/mvisani/genome_assembly/scripts/error_%j.e
#SBATCH --partition=pcourseassembly

module load UHTS/Assembler/trinityrnaseq/2.5.1;

FILES=/data/users/mvisani/genome_assembly/participant_2/RNAseq
OUTDIR=/data/users/mvisani/genome_assembly/assembly/rna_trinity/

Trinity --seqType fq \
    --left $FILES/ERR754061_1.fastq.gz \
    --right $FILES/ERR754061_2.fastq.gz \
    --CPU 6 --max_memory 20G \
    --output $OUTDIR 
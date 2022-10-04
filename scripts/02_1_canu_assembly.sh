#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=4G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=canu_assembly
#SBATCH --mail-type=end,error
#SBATCH --output=/data/users/mvisani/genome_assembly/scripts/canu.o
#SBATCH --error=/data/users/mvisani/genome_assembly/scripts/canu.e
#SBATCH --mail-user=marco.visani@students.unibe.ch

module load UHTS/Assembler/canu/2.1.1;

rm -rf /data/users/mvisani/genome_assembly/assembly/pacbio_canu
mkdir /data/users/mvisani/genome_assembly/assembly/pacbio_canu

FILES=/data/users/mvisani/genome_assembly/participant_2/pacbio/*
OUTDIR=/data/users/mvisani/genome_assembly/assembly/pacbio_canu/

canu \
    -p pacbio_canu -d $OUTDIR \
    genomeSize=130m \
    -pacbio $FILES \
    gridEngineResourceOption="--cpus-per-task=THREADS --mem-per-cpu=MEMORY" \
    gridOptions="--partition=pall --mail-user=marco.visani@students.unibe.ch"

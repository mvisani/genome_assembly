#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=32G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=polishing
#SBATCH --mail-type=end,error
#SBATCH --output=/data/users/mvisani/genome_assembly/scripts/output_%j.o
#SBATCH --error=/data/users/mvisani/genome_assembly/scripts/error_%j.e
#SBATCH --mail-user=marco.visani@students.unibe.ch

module add UHTS/Aligner/bowtie2/2.3.4.1;

mkdir /data/users/mvisani/genome_assembly/assembly/polishing/
mkdir /data/users/mvisani/genome_assembly/assembly/polishing/illumina

OUTDIR=/data/users/mvisani/genome_assembly/assembly/polishing/illumina
FILES=/data/users/mvisani/genome_assembly/participant_2/Illumina/*

cd $OUTDIR

bowtie2-build \
    --threads 16 \
    -f $FILES \
    illumina
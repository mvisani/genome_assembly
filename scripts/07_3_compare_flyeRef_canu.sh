#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=4G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=compare_flyeRef_canu
#SBATCH --mail-user=marco.visani@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mvisani/genome_assembly/scripts/compare_flyeRef_canu_%j.o
#SBATCH --error=/data/users/mvisani/genome_assembly/scripts/compare_flyeRef_canu_%j.e
#SBATCH --partition=pcourseassembly

module add UHTS/Analysis/mummer/4.0.0beta1

#mkdir /data/users/mvisani/genome_assembly/comparison
mkdir /data/users/mvisani/genome_assembly/comparison/fat/canu_flyeRef
cd /data/users/mvisani/genome_assembly/comparison/fat/canu_flyeRef

REFFILE=/data/users/mvisani/genome_assembly/polishing/flye/flye_pilon.fasta
CANU=/data/users/mvisani/genome_assembly/polishing/canu/canu_pilon.fasta

nucmer \
    --prefix canu_flyeRef_fat \
    --breaklen 1000 \
    --mincluster 1000 \
    $REFFILE \
    $CANU

mummerplot \
    -R $REFFILE \
    -Q $CANU \
    --filter \
    -t png \
    --large \
    --layout \
    --prefix canu_flyeRef_fat \
    --fat \
    canu_flyeRef_fat.delta



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
mkdir /data/users/mvisani/genome_assembly/comparison/fat/flye_canuRef
cd /data/users/mvisani/genome_assembly/comparison/fat/flye_canuRef

REFFILE=/data/users/mvisani/genome_assembly/polishing/canu/canu_pilon.fasta
FLYE=/data/users/mvisani/genome_assembly/polishing/flye/flye_pilon.fasta

nucmer \
    --prefix flye_canuRef_fat \
    --breaklen 1000 \
    --mincluster 1000 \
    $REFFILE \
    $FLYE

mummerplot \
    -R $REFFILE \
    -Q $FLYE \
    --filter \
    -t png \
    --large \
    --layout \
    --prefix flye_canuRef_fat \
    --fat \
    flye_canuRef_fat.delta



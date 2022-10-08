#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=4G
#SBATCH --time=06:00:00
#SBATCH --job-name=fly_quast_ref
#SBATCH --mail-user=marco.visani@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mvisani/genome_assembly/scripts/fly_quast_ref_%j.o
#SBATCH --error=/data/users/mvisani/genome_assembly/scripts/fly_quast_ref_%j.e
#SBATCH --partition=pcourseassembly

module add UHTS/Quality_control/quast/4.6.0;

REFERENCE=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
OUTDIR=/data/users/mvisani/genome_assembly/evaluation/quast/with_reference/flye/
GENECOOR=/data/courses/assembly-annotation-course/references/TAIR10_GFF3_genes.gff
INPUT=/data/users/mvisani/genome_assembly/polishing/flye/pilon.fasta

quast.py \
    $INPUT \
    --output-dir $OUTDIR \
    -R $REFERENCE \
    -G $GENECOOR \
    --threads 8 \
    --eukaryote \
    --est-ref-size 135000000 \
    --no-sv \
    --labels flye_ref


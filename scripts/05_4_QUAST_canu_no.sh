#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=4G
#SBATCH --time=06:00:00
#SBATCH --job-name=canu_quast_no_ref
#SBATCH --mail-user=marco.visani@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mvisani/genome_assembly/scripts/canu_quast_no_%j.o
#SBATCH --error=/data/users/mvisani/genome_assembly/scripts/canu_quast_no_%j.e
#SBATCH --partition=pcourseassembly

module add UHTS/Quality_control/quast/4.6.0;

OUTDIR=/data/users/mvisani/genome_assembly/evaluation/quast/no_reference/canu/
INPUT=/data/users/mvisani/genome_assembly/polishing/canu/pilon.fasta

quast.py \
    $INPUT \
    --output-dir $OUTDIR \
    --threads 8 \
    --eukaryote \
    --est-ref-size 135000000 \
    --no-sv \
    --labels canu_no_ref

#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=4G
#SBATCH --time=06:00:00
#SBATCH --job-name=quast_no_ref
#SBATCH --mail-user=marco.visani@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mvisani/genome_assembly/scripts/quast_no_ref_%j.o
#SBATCH --error=/data/users/mvisani/genome_assembly/scripts/quast_no_ref_%j.e
#SBATCH --partition=pall

module add UHTS/Quality_control/quast/4.6.0;

OUTDIR=/data/users/mvisani/genome_assembly/evaluation/quast/no_reference/
INPUT_flye=/data/users/mvisani/genome_assembly/polishing/flye/flye_pilon.fasta
INPUT_canu=/data/users/mvisani/genome_assembly/polishing/canu/canu_pilon.fasta

quast.py \
    $INPUT_flye $INPUT_canu
    -o $OUTDIR \
    --threads $SLURM_CPUS_PER_TASK \
    --eukaryote \
    --est-ref-size 130000000 \ 
    --labels flye, canu \
    


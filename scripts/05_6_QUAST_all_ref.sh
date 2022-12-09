#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=4G
#SBATCH --time=01:00:00
#SBATCH --job-name=quast_with_ref
#SBATCH --mail-user=marco.visani@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mvisani/genome_assembly/scripts/quast_with_ref_%j.o
#SBATCH --error=/data/users/mvisani/genome_assembly/scripts/quast_with_ref_%j.e
#SBATCH --partition=pall

module add UHTS/Quality_control/quast/4.6.0;

REFERENCE=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
OUTDIR=/data/users/mvisani/genome_assembly/evaluation/quast/with_reference
INPUT_flye=/data/users/mvisani/genome_assembly/polishing/flye/flye_pilon.fasta
INPUT_canu=/data/users/mvisani/genome_assembly/polishing/canu/canu_pilon.fasta
GENECOOR=/data/courses/assembly-annotation-course/references/TAIR10_GFF3_genes.gff

quast.py \
    $INPUT_flye $INPUT_canu \
    --output-dir $OUTDIR \
    -R $REFERENCE \
    -G $GENECOOR \
    --threads $SLURM_CPUS_PER_TASK \
    --eukaryote \
    --est-ref-size 130000000 \
    --labels "flye with reference, canu with reference" \
    --no-sv


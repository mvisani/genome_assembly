#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=06:00:00
#SBATCH --job-name=eval_trinity
#SBATCH --mail-user=marco.visani@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mvisani/genome_assembly/scripts/output_%j.o
#SBATCH --error=/data/users/mvisani/genome_assembly/scripts/error_%j.e
#SBATCH --partition=pall


mkdir /data/users/mvisani/genome_assembly/evaluation/trinity
cd /data/users/mvisani/genome_assembly/evaluation/busco/trinity

WORKDIR=/data/users/mvisani/genome_assembly/
OUTDIR=/data/users/mvisani/genome_assembly/evaluation/busco/trinity
INPUT=/data/users/mvisani/genome_assembly/assembly/rna_trinity/Trinity.fasta

echo "busco \
    --in $INPUT \
    --mode transcriptome \
    --cpu 4 \
    --lineage brassicales_odb10 \
    --out trinity " > eval_trinity.sh

singularity exec \
    --bind $WORKDIR \
    /data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
    bash eval_trinity.sh

rm eval_trinity.sh


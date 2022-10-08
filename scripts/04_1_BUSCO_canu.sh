#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=4G
#SBATCH --time=06:00:00
#SBATCH --job-name=eval_canu
#SBATCH --mail-user=marco.visani@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mvisani/genome_assembly/scripts/output_%j.o
#SBATCH --error=/data/users/mvisani/genome_assembly/scripts/error_%j.e
#SBATCH --partition=pall

cd /data/users/mvisani/genome_assembly/evaluation/busco/canu

OUTDIR=/data/users/mvisani/genome_assembly/evaluation/busco/canu
WORKDIR=/data/users/mvisani/genome_assembly/
INPUT=/data/users/mvisani/genome_assembly/polishing/canu/pilon.fasta

echo "busco \
    --in $INPUT \
    --mode genome \
    --cpu 16 \
    --lineage brassicales_odb10 \
    --out canu " > eval_canu.sh

singularity exec \
    --bind $WORKDIR \
    /data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
    bash eval_canu.sh

rm eval_canu.sh




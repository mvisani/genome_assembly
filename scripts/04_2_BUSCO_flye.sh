#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=48G
#SBATCH --time=06:00:00
#SBATCH --job-name=eval_flye
#SBATCH --mail-user=marco.visani@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mvisani/genome_assembly/scripts/output_%j.o
#SBATCH --error=/data/users/mvisani/genome_assembly/scripts/error_%j.e
#SBATCH --partition=pall

mkdir /data/users/mvisani/genome_assembly/evaluation/flye
cd /data/users/mvisani/genome_assembly/evaluation/canu

WORKDIR=/data/users/mvisani/genome_assembly/
OUTDIR=/data/users/mvisani/genome_assembly/evaluation/flye

echo "busco \
    --in TODO \
    --mode genome \
    --cpu 4 \
    --lineage brassicales_odb10 \
    --out $OUTDIR " > eval_flye.sh

singularity exec \
    --bind $WORKDIR \
    /data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
    bash eval_flye.sh

rm eval_flye.sh


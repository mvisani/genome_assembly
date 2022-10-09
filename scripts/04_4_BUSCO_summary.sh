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


#mkdir /data/users/mvisani/genome_assembly/evaluation/busco/summary
cd /data/users/mvisani/genome_assembly/evaluation/busco/summary
OUTDIR=/data/users/mvisani/genome_assembly/evaluation/busco/summary/

#cp /data/users/mvisani/genome_assembly/evaluation/busco/canu/canu/short_summary.specific.brassicales_odb10.canu.txt \
#    $OUTDIR
#cp /data/users/mvisani/genome_assembly/evaluation/busco/flye/flye/short_summary.specific.brassicales_odb10.flye.txt \
#    $OUTDIR
#cp /data/users/mvisani/genome_assembly/evaluation/busco/trinity/trinity/short_summary.specific.brassicales_odb10.trinity.txt \
#    $OUTDIR

WORKDIR=/data/users/mvisani/genome_assembly/

singularity run \
    /data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
    python3 generate_plot.py -wd $OUTDIR




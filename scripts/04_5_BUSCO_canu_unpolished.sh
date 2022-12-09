#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=4G
#SBATCH --time=01:00:00
#SBATCH --job-name=eval_canu
#SBATCH --mail-user=marco.visani@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mvisani/genome_assembly/scripts/output_%j.o
#SBATCH --error=/data/users/mvisani/genome_assembly/scripts/error_%j.e
#SBATCH --partition=pall

mkdir /data/users/mvisani/genome_assembly/evaluation/busco/canu/unpolished
cd /data/users/mvisani/genome_assembly/evaluation/busco/canu/unpolished

OUTDIR=/data/users/mvisani/genome_assembly/evaluation/busco/canu/unpolished
WORKDIR=/data/users/mvisani/genome_assembly/
INPUT=/data/users/mvisani/genome_assembly/assembly/pacbio_canu/pacbio_canu.contigs.fasta

echo "busco \
    --in $INPUT \
    --mode genome \
    --cpu $SLURM_CPUS_PER_TASK \
    --lineage brassicales_odb10 \
    --out canu_unpolished " > eval_canu.sh

singularity exec \
    --bind $WORKDIR \
    /data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
    bash eval_canu.sh

rm eval_canu.sh




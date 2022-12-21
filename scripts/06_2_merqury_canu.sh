#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=4G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=merqury
#SBATCH --mail-user=marco.visani@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mvisani/genome_assembly/scripts/merqury_canu_%j.o
#SBATCH --error=/data/users/mvisani/genome_assembly/scripts/merqury_canu_%j.e
#SBATCH --partition=pall

module load UHTS/Assembler/canu/2.1.1;

#directories for Singularity binding
PROJDIR=/data/users/mvisani/genome_assembly/
READSDIR=/data/courses/assembly-annotation-course/raw_data/

#create output directory
#mkdir /data/users/mvisani/genome_assembly/evaluation/merqury/canu
#OUTDIR=/data/users/mvisani/genome_assembly/evaluation/merqury/canu
mkdir /data/users/mvisani/genome_assembly/evaluation/merqury/canu_unpolished
OUTDIR=/data/users/mvisani/genome_assembly/evaluation/merqury/canu_unpolished

#directory for fasta files
CANU=/data/users/mvisani/genome_assembly/assembly/pacbio_canu/pacbio_canu.contigs.fasta

#illumina reads
READ1=/data/courses/assembly-annotation-course/raw_data/An-1/participant_2/Illumina/ERR3624579_1.fastq.gz
READ2=/data/courses/assembly-annotation-course/raw_data/An-1/participant_2/Illumina/ERR3624579_2.fastq.gz

cd $OUTDIR

k=18

# prepare meryl dbs
singularity exec \
    --bind $PROJDIR,$READSDIR \
    /software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
    meryl k=$k count output read1.meryl $READ1 ; \
    meryl k=$k count output read2.meryl $READ2 ; \
    meryl union-sum output Illumina.meryl read*.meryl

#Illumina meryl file
ILLMERYL=/data/users/mvisani/genome_assembly/evaluation/merqury/canu_unpolished/Illumina.meryl


# merqury assembly evaluation for canu
singularity exec \
    --bind $PROJDIR,$READSDIR \
    /software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
    merqury.sh \
        $ILLMERYL \
        $CANU \
        canu_unpolished
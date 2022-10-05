#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=48G
#SBATCH --time=06:00:00
#SBATCH --job-name=polishing_flye
#SBATCH --mail-user=marco.visani@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mvisani/genome_assembly/scripts/output_%j.o
#SBATCH --error=/data/users/mvisani/genome_assembly/scripts/error_%j.e
#SBATCH --partition=pall

# load canu module
module add UHTS/Aligner/bowtie2/2.3.4.1;
module load UHTS/Analysis/samtools/1.10;
module load UHTS/Analysis/pilon/1.22;

mkdir /data/users/mvisani/genome_assembly/polishing/flye
cd /data/users/mvisani/genome_assembly/polishing/flye

FLYE=/data/users/mvisani/genome_assembly/assembly/pacbio_flye/assembly.fasta
# run bowtie2 indexer for flye
bowtie2-build \
    -f \
    --threads 16 \
    $FLYE \
    flye_index


# run bowtie2 aligner for flye
FORWARD=/data/users/mvisani/genome_assembly/participant_2/Illumina/ERR3624579_1.fastq.gz
REVERSE=/data/users/mvisani/genome_assembly/participant_2/Illumina/ERR3624579_2.fastq.gz

bowtie2 \
    -x flye_index \
    -q \
    --sensitive-local \
    --threads 16 \
    -1 $FORWARD \
    -2 $REVERSE \
    -S flye.sam


# convert sam to bam file
samtools view -bS canu.sam > canu.bam

# run pilon
java -Xmx45g -jar /mnt/software/UHTS/Analysis/pilon/1.22/bin/pilon-1.22.jar \
    --genome $FLYE \
    --bam flye.bam \
    --outdir .
#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=4G
#SBATCH --time=06:00:00
#SBATCH --job-name=polishing
#SBATCH --mail-user=marco.visani@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mvisani/genome_assembly/scripts/output_%j.o
#SBATCH --error=/data/users/mvisani/genome_assembly/scripts/error_%j.e
#SBATCH --partition=pcourseassembly

# load canu module
module add UHTS/Aligner/bowtie2/2.3.4.1;
module load UHTS/Analysis/samtools/1.10;
module load UHTS/Analysis/pilon/1.22;

mkdir /data/users/mvisani/genome_assembly/polishing/
mkdir /data/users/mvisani/genome_assembly/polishing/canu
cd /data/users/mvisani/genome_assembly/polishing/canu

CANU=/data/users/mvisani/genome_assembly/assembly/pacbio_canu/pacbio_canu.contigs.fasta
## run bowtie2 indexer for canu
bowtie2-build \
    -f \
    --threads $SLURM_CPUS_PER_TASK \
    $CANU \
    canu_index


## run bowtie2 aligner for canu
FORWARD=/data/users/mvisani/genome_assembly/participant_2/Illumina/ERR3624579_1.fastq.gz
REVERSE=/data/users/mvisani/genome_assembly/participant_2/Illumina/ERR3624579_2.fastq.gz
#
bowtie2 \
    -x canu_index \
    -q \
    --sensitive-local \
    --threads $SLURM_CPUS_PER_TASK \
    -1 $FORWARD \
    -2 $REVERSE \
    -S canu.sam


# convert sam to bam file
samtools sort -T $SCRATCH -@ $SLURM_CPUS_PER_TASK canu.sam -o canu_sorted.sam
samtools view -bS -@ $SLURM_CPUS_PER_TASK canu_sorted.sam > canu.bam
samtools index --threads $SLURM_CPUS_PER_TASK canu.bam

# run pilon
java -Xmx45g -jar /mnt/software/UHTS/Analysis/pilon/1.22/bin/pilon-1.22.jar \
    --genome $CANU \
    --bam canu.bam \
    --threads $SLURM_CPUS_PER_TASK \
    --outdir . \
    --output canu_pilon
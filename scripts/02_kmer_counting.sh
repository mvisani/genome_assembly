#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=16G
#SBATCH --time=01:00:00
#SBATCH --job-name=kmer_count
#SBATCH --mail-user=marco.visani@students.unibe.ch
#SBATCH --mail-type=end,error
#SBATCH --output=/data/users/mvisani/genome_assembly/scripts/output_%j.o
#SBATCH --error=/data/users/mvisani/genome_assembly/scripts/error_%j.e
#SBATCH --partition=pcourseassembly


module load UHTS/Analysis/jellyfish/2.3.0;

jellyfish count \
-C -m 19 -s 1G -t 4 -o /data/users/mvisani/genome_assembly/read_QC/kmer_counting/Illumina.jf \
<(zcat /data/users/mvisani/genome_assembly/participant_2/Illumina/ERR3624579_1.fastq.gz) \
<(zcat /data/users/mvisani/genome_assembly/participant_2/Illumina/ERR3624579_2.fastq.gz)

jellyfish histo \
-t 4 /data/users/mvisani/genome_assembly/read_QC/kmer_counting/Illumina.jf \
> /data/users/mvisani/genome_assembly/read_QC/kmer_counting/Illumina.histo

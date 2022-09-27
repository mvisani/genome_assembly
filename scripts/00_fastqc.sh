#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=marco.visani@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mvisani/output_fastqc_%j.o
#SBATCH --error=/data/users/mvisani/error_fastqc_%j.e
#SBATCH --partition=pcourseassembly

cd /data/users/mvisani/genome_assembly/participant_2/

module load UHTS/Quality_control/fastqc/0.11.9;

for i in $(ls ./*/*); do
	fastqc -o /data/users/mvisani/genome_assembly/read_QC/fastqc -f fastq $i
done



#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=4G
#SBATCH --time=06:00:00
#SBATCH --job-name=canu_assembly
#SBATCH --mail-user=marco.visani@students.unibe.ch
#SBATCH --mail-type=end,error
#SBATCH --output=/data/users/mvisani/genome_assembly/scripts/output_%j.o
#SBATCH --error=/data/users/mvisani/genome_assembly/scripts/error_%j.e
#SBATCH --partition=pcourseassembly

module load UHTS/Assembler/trinityrnaseq/2.5.1;

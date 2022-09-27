#!/usr/bin/env bash

#SBATCH --time=06:00:00
#SBATCH --job-name=canu_assembly
#SBATCH --mail-type=end,error
#SBATCH --output=/data/users/mvisani/genome_assembly/scripts/output_%j.o
#SBATCH --error=/data/users/mvisani/genome_assembly/scripts/error_%j.e

module load UHTS/Assembler/canu/2.1.1;

gridEngineResourceOption="--cpus-per-task=THREADS --mem-per-cpu=MEMORY"
gridOptions="--partition=pcourseassembly --mail-user=marco.visani@students.unibe.ch"
FILES=
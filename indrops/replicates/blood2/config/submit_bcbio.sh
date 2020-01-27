#!/bin/bash
#SBATCH -n 1                 # Number of cores
#SBATCH -t 00-45:59:00       # Runtime
#SBATCH -p medium            # Partition (queue)
#SBATCH -J perrimon          # Job name
#SBATCH -o run.o             # Standard out
#SBATCH -e run.e             # Standard error
#SBATCH --cpus-per-task=1    # CPUs per task
#SBATCH --mem-per-cpu=8G     # Memory needed per core
#SBATCH --mail-type=END      # Mail when the job ends
bcbio_nextgen.py ../config/indrop_rnaseq.yaml -n 72 -t ipython -s slurm -q medium -r t=15:59

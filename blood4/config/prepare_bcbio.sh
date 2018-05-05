# Set up the run on the scratch disk
scratch_dir="/n/scratch2/mjs65/perrimon/flyblood_run4"
mkdir -p "scratch_dir"
cd "$scratch_dir"

# Prepare and copy the required files to the scratch disk
cp /n/data1/cores/bcbio/PIs/norbert_perrimon/blood_scrnaseq/blood4/config/* .

# Configure bcbio
bcbio_nextgen.py -w template bcbio.yaml bcbio.csv /n/data1/cores/bcbio/PIs/norbert_perrimon/blood_scrnaseq/blood4/data-raw/fastq/*.fastq.gz

cd bcbio/work
cp ../../submit_bcbio.sh .

# Submit from the login node
sbatch submit_bcbio.sh
squeue -u $USER

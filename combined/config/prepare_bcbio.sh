# Combine blood1, 2, 3 into a single bcbio run
# Using the lastest FlyBase release from 2018-02 (r6.21)

scratch_dir=/n/scratch2/mjs65/perrimon/combined
mkdir -p $scratch_dir
cd $scratch_dir

run_dir=/n/data1/cores/bcbio/PIs/norbert_perrimon/blood_scrnaseq/combined
config_dir=${run_dir}/config

cp $config_dir/indrop_rnaseq.csv bcbio.csv
cp $config_dir/indrop_rnaseq-template.yaml bcbio.yaml

fastq_dir=${run_dir}/data-raw/fastq
ls -lh ${fastq_dir}/*.fastq.gz

# Configure bcbio
bcbio_nextgen.py -w template bcbio.yaml bcbio.csv ${fastq_dir}/*.fastq.gz

# Edit the sample barcode configuration for each FASTQ set
vim /n/scratch2/mjs65/perrimon/combined/bcbio/config/bcbio.yaml


cd bcbio/work
cp $config_dir/submit_bcbio.sh .
less submit_bcbio.sh

# Submit from the login node
sbatch submit_bcbio.sh
squeue -u $USER

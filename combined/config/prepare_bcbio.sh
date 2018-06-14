# Combine blood1, 2, 3 into a single bcbio run
# Using the lastest FlyBase release from 2018-02 (r6.21)

scratch_dir=/n/scratch2/mjs65/perrimon/combined
mkdir -p $scratch_dir
cd $scratch_dir

run_dir=/n/data1/cores/bcbio/PIs/norbert_perrimon/blood_scrnaseq/combined
config_dir=${run_dir}/config
ls $config_dir

ln -s $config_dir/bcbio.csv .
ln -s $config_dir/bcbio.yaml .

fastq_dir=${run_dir}/data-raw/fastq
ln -s $fastq_dir/*.fastq.gz .
ls *.fastq.gz

# Configure bcbio
bcbio_nextgen.py -w template bcbio.yaml bcbio.csv *.fastq.gz

# Edit the sample barcode configuration for each FASTQ set
ls $config_dir/sample_barcodes_reverse_complement
# blood1.txt blood2.txt blood3.txt
vim bcbio/config/bcbio.yaml

cd bcbio/work
ln -s $config_dir/submit_bcbio.sh .
vim submit_bcbio.sh

# Submit from the login node
sbatch submit_bcbio.sh
squeue -u $USER

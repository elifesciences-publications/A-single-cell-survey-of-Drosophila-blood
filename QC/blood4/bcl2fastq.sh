# Demultiplex inDrop data into R1-R4 FASTQ files

# Run script from Illumina run directory
cd /n/data1/cores/bcbio/PIs/norbert_perrimon/blood_scrnaseq/blood4/data-raw/FC_03654/n/scratch2/bpf/180301_NB501673_0251_AHJMMHBGX5

# Directory has 2 sample sheets:
# - SampleSheet_FC003654_1234_PF_mm1.csv
# - SampleSheet_FC003654_1234a_PF_mm1.csv
# The index column looks correct in "1234" but not "1234a", which contains polyG

# Copy our modified `SampleSheet.csv` that demultiplexes to R1-4 FASTQs
cp ../../../../../SampleSheet.csv .

# Note newer version used compared to previous blood runs
module load bcl2fastq/2.20.0.422
bcl2fastq --use-bases-mask y*,y*,y*,y* --mask-short-adapter-reads 0 --minimum-trimmed-read-length 0 > bcl2fastq.log

# Files output to` Data/Intensities/BaseCalls/Project_tsudhirg`

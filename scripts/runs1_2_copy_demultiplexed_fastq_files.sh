cd data-raw/
mkdir fastq/run1 fastq/run2

# Run1 (16 files)
run1="170201_NB501807_0021_AHWCYVBGXY"
# Copy to the FASTQ folder it is own folder by Illumina run ID
mkdir -p fastq/${run1}
find . -wholename "*/${run1}/Data/Intensities/BaseCalls/*.fastq.gz" \
    -print0 | xargs -0 -I {} \
    cp --link {} fastq/${run1}/.

# Run2 (16 files)
run2="170620_NB501673_0150_AH2W2CBGX3"
# Copy to the FASTQ folder it is own folder by Illumina run ID
mkdir -p fastq/${run2}
find . -wholename "*/${run2}/Data/Intensities/BaseCalls/*.fastq.gz" \
    -print0 | xargs -0 -I {} \
    cp --link {} fastq/${run2}/.

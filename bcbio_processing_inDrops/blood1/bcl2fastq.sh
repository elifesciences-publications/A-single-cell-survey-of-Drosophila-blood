# This was run on Orchestra

# Follow the workflow for Illumina NextSeq 500/550 system
# NextSeq 500/550
# <run folder>/Data/Intensities/BaseCalls
# - BCL Files (*bcl.bgzf) • BCI Files
# - FILTER Files
# - Position Files
# - RunInfo Files
# - Sample Sheet Files (optional)

$root="FC_02688/n/scratch2/bpf"
$illumina="170201_NB501807_0021_AHWCYVBGXY"

mkdir -p "$illumina"
cd "$illumina"

# Data folder containing BCLs
cp -R ../"$root"/"$illumina"/Data .

# InterOp folder
cp -R ../"$root"/"$illumina"/InterOp .

# RunInfo.xml
cp ../"$root"/"$illumina"/RunInfo.xml .

# SampleSheet CSV
cp ../"$root"/"$illumina"/SampleSheet*.csv SampleSheet.csv

module load seq/bcl2fastq/2.17.1.14
bcl2fastq --use-bases-mask y*,y*,y*,y* --mask-short-adapter-reads 0 --minimum-trimmed-read-length 0 > ../bcl2fastq.log
cd ..

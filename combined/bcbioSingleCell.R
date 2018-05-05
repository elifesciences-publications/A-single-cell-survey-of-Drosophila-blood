# v0.1.5
library(bcbioSingleCell)
uploadDir <- file.path("bcbio", "2018-04-30")
bcb <- bcbioSingleCell(
    uploadDir = uploadDir,
    organism = "Drosophila melanogaster",
    sampleMetadataFile = file.path(uploadDir, "sample_metadata.xlsx"),
    gffFile = file.path(
        "..",
        "annotations",
        "flybase",
        "FB2018_02",
        "dmel-all-r6.21.gtf"
    )
)
flatFiles <- flatFiles(bcb)
saveData(bcb, flatFiles, dir = file.path("data", Sys.Date()))

# Need to re-run with spike-ins added to GTF file
# The bcbio single-cell pipeline dumps them when converting to gene level
# transgeneNames = c("EGFP", "gal4")

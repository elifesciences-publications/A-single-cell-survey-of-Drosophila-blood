# v0.1.5
library(bcbioSingleCell)
bcb <- bcbioSingleCell(
    uploadDir = file.path("bcbio", "2018-06-14"),
    organism = "Drosophila melanogaster",
    sampleMetadataFile = "sample_metadata.xlsx",
    gffFile = file.path(
        "..",
        "annotations",
        "flybase",
        "FB2018_02",
        "dmel-all-r6.21-spike.gtf"
    ),
    transgeneNames = c("EGFP", "gal4")
)
flatFiles <- flatFiles(bcb)
saveData(bcb, flatFiles, dir = file.path("data", Sys.Date()))


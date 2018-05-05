# bcbioSingleCell v0.1.0
library(bcbioSingleCell)
uploadDir <- "bcbio/2018-03-27"
blood4 <- loadSingleCell(
    uploadDir = uploadDir,
    sampleMetadataFile = "meta/sample_metadata.csv",
    organism = "Drosophila melanogaster",
    gffFile = file.path(
        "..",
        "annotations",
        "flybase",
        "FB2017_06",
        "dmel-all-r6.19.gtf.gz"
    ),
    isSpike = c("EGFP", "gal4")
)
saveData(blood4, dir = file.path("data", Sys.Date()))

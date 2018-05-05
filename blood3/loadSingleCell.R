library(bcbioSingleCell)
uploadDir <- "bcbio/2018-01-10"
blood3_2018_01_10 <- loadSingleCell(
    uploadDir = uploadDir,
    sampleMetadataFile = file.path(uploadDir, "sample_metadata.xlsx"),
    gtfFile = file.path(
        "..",
        "annotations",
        "flybase",
        "FB2017_06",
        "dmel-all-r6.19.gtf.gz"
    )
)
saveData(blood3_2018_01_10, dir = file.path("data", Sys.Date()))

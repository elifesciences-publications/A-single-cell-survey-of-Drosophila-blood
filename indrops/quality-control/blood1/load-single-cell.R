library(bcbioSingleCell)
uploadDir <- "bcbio/2017-03-03"
blood1_2017_03_03 <- loadSingleCell(
    uploadDir = uploadDir,
    sampleMetadataFile = file.path(uploadDir, "sample_metadata.xlsx"),
    gtfFile = file.path(
        "..",
        "annotations",
        "flybase",
        "FB2017_01",
        "dmel-all-r6.14.gtf"
    )
)
saveData(blood1_2017_03_03, dir = file.path("data", Sys.Date())

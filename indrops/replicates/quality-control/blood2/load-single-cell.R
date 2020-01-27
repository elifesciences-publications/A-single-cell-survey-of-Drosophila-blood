library(bcbioSingleCell)

# 2017-07-19 ====
uploadDir <- "bcbio/2017-07-19"
blood2_2017_07_19 <- loadSingleCell(
    uploadDir = uploadDir,
    sampleMetadataFile = file.path(uploadDir, "sample_metadata.xlsx"),
    gtfFile = file.path(
        "..",
        "annotations",
        "flybase",
        "FB2017_03",
        "dmel-all-r6.16.gtf.gz"
    )
)



# 2017-08-01 ====
# Cellular barcode cutoff at 100 reads
uploadDir <- "bcbio/2017-08-01_cbcutoff_100"
blood2_2017_08_01_cbcutoff_100 <- loadSingleCell(
    uploadDir = uploadDir,
    sampleMetadataFile = file.path(uploadDir, "sample_metadata.xlsx"),
    gtfFile = file.path(
        "..",
        "annotations",
        "flybase",
        "FB2017_03",
        "dmel-all-r6.16.gtf.gz"
    )
)

# Cellular barcode cutoff at 1000 reads
uploadDir <- "bcbio/2017-08-01_cbcutoff_1000"
blood2_2017_08_01_cbcutoff_1000 <- loadSingleCell(
    uploadDir = uploadDir,
    sampleMetadataFile = file.path(uploadDir, "sample_metadata.xlsx"),
    gtfFile = file.path(
        "..",
        "annotations",
        "flybase",
        "FB2017_03",
        "dmel-all-r6.16.gtf.gz"
    )
)



# 2017-08-15 ====
uploadDir <- "bcbio/2017-08-15"
blood2_2017_08_15 <- loadSingleCell(
    uploadDir = uploadDir,
    sampleMetadataFile = file.path(uploadDir, "sample_metadata.xlsx"),
    gtfFile = file.path(
        "..",
        "annotations",
        "flybase",
        "FB2017_03",
        "dmel-all-r6.16.gtf.gz"
    )
)



# 2017-10-13 ====
uploadDir <- "bcbio/2017-10-13"
blood2_2017_10_13 <- loadSingleCell(
    uploadDir = uploadDir,
    sampleMetadataFile = file.path(uploadDir, "sample_metadata.xlsx"),
    gtfFile = file.path(
        "..",
        "annotations",
        "flybase",
        "FB2017_04",
        "dmel-all-r6.17.gtf.gz"
    )
)



# Save ====
saveData(
    blood2_2017_07_19,
    blood2_2017_08_01_cbcutoff_100,
    blood2_2017_08_01_cbcutoff_1000,
    blood2_2017_08_15,
    blood2_2017_10_13,
    dir = file.path("data", Sys.Date())
)
library(bcbioSingleCell)

# Run 1 ========================================================================
run1_2017_03_03 <- loadSingleCell(
    uploadDir = file.path(
        "data",
        "bcbio",
        "run1",
        "2017-03-03"),
    sampleMetadataFile = file.path(
        "data",
        "bcbio",
        "run1",
        "2017-03-03",
        "sample_metadata.xlsx"),
    gtfFile = file.path(
        "annotations",
        "flybase",
        "FB2017_01",
        "dmel-all-r6.14.gtf")
)
run1_2017_10_13 <- loadSingleCell(
    uploadDir = file.path(
        "data",
        "bcbio",
        "run1",
        "2017-10-13"),
    sampleMetadataFile = file.path(
        "data",
        "bcbio",
        "run1",
        "2017-10-13",
        "sample_metadata.xlsx"),
    gtfFile = file.path(
        "annotations",
        "flybase",
        "FB2017_04",
        "dmel-all-r6.17.gtf.gz")
)
saveData(
    run1_2017_03_03,
    run1_2017_10_13,
    dir = "data")

# Run 2 ========================================================================
run2_2017_07_19 <- loadSingleCell(
    uploadDir = file.path(
        "data",
        "bcbio",
        "run2",
        "2017-07-19"),
    sampleMetadataFile = file.path(
        "data",
        "bcbio",
        "run2",
        "2017-07-19",
        "sample_metadata.xlsx"),
    gtfFile = file.path(
        "annotations",
        "flybase",
        "FB2017_03",
        "dmel-all-r6.16.gtf.gz")
)
run2_2017_08_01_cbcutoff_100 <- loadSingleCell(
    uploadDir = file.path(
        "data",
        "bcbio",
        "run2",
        "2017-08-01_cbcutoff_100"),
    sampleMetadataFile = file.path(
        "data",
        "bcbio",
        "run2",
        "2017-08-01_cbcutoff_100",
        "sample_metadata.xlsx"),
    gtfFile = file.path(
        "annotations",
        "flybase",
        "FB2017_03",
        "dmel-all-r6.16.gtf.gz")
)
run2_2017_08_01_cbcutoff_1000 <- loadSingleCell(
    uploadDir = file.path(
        "data",
        "bcbio",
        "run2",
        "2017-08-01_cbcutoff_1000"),
    sampleMetadataFile = file.path(
        "data",
        "bcbio",
        "run2",
        "2017-08-01_cbcutoff_1000",
        "sample_metadata.xlsx"),
    gtfFile = file.path(
        "annotations",
        "flybase",
        "FB2017_03",
        "dmel-all-r6.16.gtf.gz")
)
run2_2017_08_15 <- loadSingleCell(
    uploadDir = file.path(
        "data",
        "bcbio",
        "run2",
        "2017-08-15"),
    sampleMetadataFile = file.path(
        "data",
        "bcbio",
        "run2",
        "2017-08-15",
        "sample_metadata.xlsx"),
    gtfFile = file.path(
        "annotations",
        "flybase",
        "FB2017_03",
        "dmel-all-r6.16.gtf.gz")
)
run2_2017_10_13 <- loadSingleCell(
    uploadDir = file.path(
        "data",
        "bcbio",
        "run2",
        "2017-10-13"),
    sampleMetadataFile = file.path(
        "data",
        "bcbio",
        "run2",
        "2017-10-13",
        "sample_metadata.xlsx"),
    gtfFile = file.path(
        "annotations",
        "flybase",
        "FB2017_04",
        "dmel-all-r6.17.gtf.gz")
)
saveData(
    run2_2017_07_19,
    run2_2017_08_01_cbcutoff_100,
    run2_2017_08_01_cbcutoff_1000,
    run2_2017_08_15,
    run2_2017_10_13,
    dir = "data")

# Run 3 ====
run3_2018_01_10 <- loadSingleCell(
    uploadDir = file.path(
        "data",
        "bcbio",
        "run3"),
    sampleMetadataFile = file.path(
        "meta",
        "run3",
        "sample_metadata.xlsx"),
    gtfFile = file.path(
        "annotations",
        "flybase",
        "FB2017_06",
        "dmel-all-r6.19.gtf.gz")
)
saveData(run3_2018_01_10, dir = "data")

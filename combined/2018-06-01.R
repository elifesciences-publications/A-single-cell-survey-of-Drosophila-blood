library(bcbioSingleCell)
library(Seurat)
data_dir <- file.path("data", Sys.Date())

loadDataAsName(
    bcb = bcb_filtered, dir = "data/2018-05-16"
)

# seurat 2018-05-16
loadDataAsName(
    seurat_20180516 = bcb_filtered_seurat, dir = "data/2018-05-16"
)
plotTSNE(
    seurat_20180516,
    interestingGroups = "sampleName"
)
plotTSNE(
    seurat_20180516,
    interestingGroups = "sampleName",
    dark = TRUE
)
plotTSNE(seurat_20180516, interestingGroups = "sampleName", dark = TRUE, pointsAsNumbers = TRUE)

plotTSNE(bcb_filtered_seurat, interestingGroups = "sampleName")

# Rename samples to simply "injured" and "uninjured"

# Drop "uninjured control 3"

# Are the colors off here? Need to check
#
TSNEPlot(

)

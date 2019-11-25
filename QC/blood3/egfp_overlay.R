# EGFP expression overlay script

library(bcbioSingleCell)
library(Seurat)
library(tidyverse)

slotNames(seurat)

# Load Sudhir's SEP (sepsis) sample
loadDataAsName(c(seurat = "lanepool_ATAGCCTT_seurat"))
# Double check the sample name
unique(seurat@meta.data$sampleName)
# [1] "SEP"

# Did we detect EGFP in this sample?
# Check the raw (`@raw.data`) and normalized (`@data`) counts
"EGFP" %in% rownames(seurat@raw.data)
"EGFP" %in% rownames(seurat@data)
# [1] TRUE
# Good, the FASTA spike-in worked, and it has been passed into Seurat correctly.

# First let's check how this looks with the normalized EGFP expression.
# We may want to go back and compare how the raw counts look instead.
# Sudhir would like these plotted on the tSNE, which I think we can do with
# our marker code already.

# If you want to click around and select cells, use a locator session

# This works with the Seurat code, but it doesn't number the clusters...
# Use do.identify = TRUE for locator session
FeaturePlot(
    seurat,
    features.plot = "EGFP",
    dark.theme = TRUE)

# Use our bcbio function instead
plotMarkerTSNE(seurat, genes = "EGFP", colorPoints = "expression")

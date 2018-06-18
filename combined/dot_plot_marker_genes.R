library(bcbioSingleCell)  # v0.1.15
library(Seurat)
library(readxl)
library(tidyverse)

# load("data/2018-06-15/seurat.rda")
load("~/Dropbox (HBC)/perrimon-blood-singlecell-fly/seurat.rda")
source("_setup.R")

PrintFindClustersParams(seurat)
dims_use <- seq(from = 1, to = 16)

# Lower the resolution setting of the seurat object to 0.6
seurat <- FindClusters(
    object = seurat,
    dims.use = dims_use,
    resolution = 0.2,
    save.SNN = TRUE,
    force.recalc = TRUE
)
seurat <- RunTSNE(
    object = seurat,
    dims.use = dims_use,
    tsne.method = "Rtsne",
    do.fast = TRUE
)

PrintFindClustersParams(seurat)
PrintTSNEParams(seurat)

plotMarkerTSNE(seurat, genes = "EGFP")

marker_genes_tbl <- read_excel("dot_plot_marker_genes.xlsx")
genes <- pull(marker_genes_tbl, geneName)
genes <- genes[genes %in% rownames(seurat)]
# Add EGFP expression to the end
genes <- c(genes, "EGFP")
print(genes)

# Check for cluster-specific expression of these markers
# ItgalphaPS4 not detected
# "eater"  "Hml"    "Pxn"    "N"      "PPO1"   "PPO2"   "atilla" "PPO3"

plotDot(seurat, genes = genes)

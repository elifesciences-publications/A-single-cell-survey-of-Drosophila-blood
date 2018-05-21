library(basejump)
library(Seurat)
library(readr)

data_dir <- file.path("data", Sys.Date())
results_dir <- file.path("results", Sys.Date(), "markers")

seurat_name <- load("data/2018-05-16/bcb_filtered_high_conf_seurat.rda")
seurat <- get(seurat_name, inherits = FALSE)

# MAST
library(MAST)
markers_mast <- FindAllMarkers(seurat, test.use = "MAST")
assignAndSaveData(
    name = paste0(seurat_name, "_markers_mast"),
    object = markers_mast,
    dir = data_dir
)
write_csv(
    markers_mast,
    path = file.path(
        results_dir,
        paste0(seurat_name, "_markers_mast.csv.gz")
    )
)

# Wilcoxon
markers_wilcoxon <- FindAllMarkers(seurat, test.use = "wilcox")
assignAndSaveData(
    name = paste0(seurat_name, "_markers_wilcoxon"),
    object = markers_wilcoxon,
    dir = data_dir
)
write_csv(
    markers_wilcoxon,
    path = file.path(
        results_dir,
        paste0(seurat_name, "_markers_wilcoxon.csv.gz")
    )
)

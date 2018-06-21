library(magrittr)
library(tools)
library(Seurat)  # v2.3.2
load("data/2018-06-19/seurat_files.rda")
stopifnot(all(file.exists(seurat_files)))
results_dir <- file.path("results", Sys.Date())
dir.create(results_dir, showWarnings = FALSE, recursive = TRUE)

# Loop across the seurat objects and save dimensional reduction coordinates
invisible(lapply(
    X = seurat_files,
    FUN = function(file) {
        stem <- file_path_sans_ext(basename(file))
        seurat <- load(file) %>% get()
        meta <- seurat@meta.data
        write.csv(
            x = meta,
            file = file.path(results_dir, paste(stem, "metadata.csv", sep = "_"))
        )
        reduced_dims <- FetchData(
            seurat,
            vars.all = c(
                "tSNE_1", "tSNE_2",
                "UMAP1", "UMAP2",
                "PC1", "PC2"
            )
        )
        write.csv(
            x = reduced_dims,
            file = file.path(results_dir, paste(stem, "reduced_dims.csv", sep = "_"))
        )
    }
))

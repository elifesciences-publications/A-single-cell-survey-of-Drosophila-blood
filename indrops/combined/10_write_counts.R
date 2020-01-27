# Write raw and normalized counts per seurat object
library(bcbioSingleCell)
library(Seurat)
load("data/2018-06-21/seurat_files.rda")
stopifnot(all(file.exists(seurat_files)))
results_dir <- file.path("results", Sys.Date(), "counts")
dir.create(results_dir, showWarnings = FALSE, recursive = TRUE)

# Loop across the seurat objects and save relative cell abundance calculations
invisible(lapply(
    X = seurat_files,
    FUN = function(file) {
        stem <- tools::file_path_sans_ext(basename(file))
        seurat <- load(file) %>% get()
        # Write to disk in dense CSV format
        # Raw counts
        seurat@raw.data %>%
            as.matrix() %>%
            write.csv(file = file.path(results_dir, paste0(stem, "_counts.csv")))
        # Log-normalized counts
        seurat@data %>%
            as.matrix() %>%
            write.csv(file = file.path(results_dir, paste0(stem, "_logcounts.csv")))
    }
))

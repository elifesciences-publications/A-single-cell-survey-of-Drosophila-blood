# Write raw and normalized counts per seurat object
library(Seurat)
load("data/2018-06-21/seurat_files.rda")
stopifnot(all(file.exists(seurat_files)))
results_dir <- file.path("results", Sys.Date(), "counts")
dir.create(results_dir, showWarnings = FALSE, recursive = TRUE)

# Loop across the seurat objects and save relative cell abundance calculations
invisible(lapply(
    X = seurat_files,
    FUN = function(file) {
        stem <- file_path_sans_ext(basename(file))
        seurat <- load(file) %>% get()

        per_sample <- clusterCellCountsPerSample(seurat)
        write.csv(
            x = per_sample,
            file = file.path(results_dir, paste(stem, "per_sample.csv", sep = "_"))
        )

        per_cluster <- cellCountsPerCluster(seurat)
        write.csv(
            x = per_cluster,
            file = file.path(results_dir, paste(stem, "per_cluster.csv", sep = "_"))
        )
    }
))

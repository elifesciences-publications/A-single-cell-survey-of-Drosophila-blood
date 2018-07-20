library(bcbioSingleCell)  # v0.1.16
library(Seurat)  # v2.3.2
library(tools)
load("data/2018-06-21/seurat_files.rda")
print(seurat_files)
stopifnot(all(file.exists(seurat_files)))
results_dir <- file.path("results", Sys.Date(), "high_resolution_figures")
dir.create(results_dir, showWarnings = FALSE, recursive = TRUE)

height <- 10
width <- 10
label_size <- 6

# Loop across the seurat objects and save high resolution vector versions
invisible(lapply(
    X = seurat_files,
    FUN = function(file) {
        stem <- file_path_sans_ext(basename(file))
        seurat <- load(file) %>% get()

        # tSNE ----
        pdf(
            file = file.path(results_dir, paste0(stem, "_tsne_ident.pdf")),
            width = width,
            height = height
        )
        show(plotTSNE(seurat, interestingGroups = "ident"))
        show(DimPlot(
            object = seurat,
            reduction.use = "tsne",
            group.by = "ident",
            do.label = TRUE,
            label.size = label_size,
            do.return = TRUE
        ))
        dev.off()

        pdf(
            file = file.path(results_dir, paste0(stem, "_tsne_sample_name.pdf")),
            width = width,
            height = height
        )
        show(plotTSNE(seurat, interestingGroups = "sampleName"))
        show(DimPlot(
            object = seurat,
            reduction.use = "tsne",
            group.by = "sampleName",
            do.label = TRUE,
            label.size = label_size,
            do.return = TRUE
        ))
        dev.off()

        pdf(
            file = file.path(results_dir, paste0(stem, "_tsne_treatment.pdf")),
            width = width,
            height = height
        )
        show(plotTSNE(seurat, interestingGroups = "treatment"))
        show(DimPlot(
            object = seurat,
            reduction.use = "tsne",
            group.by = "treatment",
            do.label = TRUE,
            label.size = label_size,
            do.return = TRUE
        ))
        dev.off()

        # UMAP ----
        pdf(
            file = file.path(results_dir, paste0(stem, "_umap_ident.pdf")),
            width = width,
            height = height
        )
        show(plotUMAP(seurat, interestingGroups = "ident"))
        show(DimPlot(
            object = seurat,
            reduction.use = "umap",
            group.by = "ident",
            do.label = TRUE,
            label.size = label_size,
            do.return = TRUE
        ))
        dev.off()

        pdf(
            file = file.path(results_dir, paste0(stem, "_umap_sample_name.pdf")),
            width = width,
            height = height
        )
        show(plotUMAP(seurat, interestingGroups = "sampleName"))
        show(DimPlot(
            object = seurat,
            reduction.use = "umap",
            group.by = "sampleName",
            do.label = TRUE,
            label.size = label_size,
            do.return = TRUE
        ))
        dev.off()

        pdf(
            file = file.path(results_dir, paste0(stem, "_umap_treatment.pdf")),
            width = width,
            height = height
        )
        show(plotUMAP(seurat, interestingGroups = "treatment"))
        show(DimPlot(
            object = seurat,
            reduction.use = "umap",
            group.by = "treatment",
            do.label = TRUE,
            label.size = label_size,
            do.return = TRUE
        ))
        dev.off()

        # PCA ----
        pdf(
            file = file.path(results_dir, paste0(stem, "_pca_ident.pdf")),
            width = width,
            height = height
        )
        show(plotPCA(seurat, interestingGroups = "ident"))
        show(DimPlot(
            object = seurat,
            reduction.use = "pca",
            group.by = "ident",
            do.label = TRUE,
            label.size = label_size,
            do.return = TRUE
        ))
        dev.off()

        pdf(
            file = file.path(results_dir, paste0(stem, "_pca_sample_name.pdf")),
            width = width,
            height = height
        )
        show(plotPCA(seurat, interestingGroups = "sampleName"))
        show(DimPlot(
            object = seurat,
            reduction.use = "pca",
            group.by = "sampleName",
            do.label = TRUE,
            label.size = label_size,
            do.return = TRUE
        ))
        dev.off()

        pdf(
            file = file.path(results_dir, paste0(stem, "_pca_treatment.pdf")),
            width = width,
            height = height
        )
        show(plotPCA(seurat, interestingGroups = "treatment"))
        show(DimPlot(
            object = seurat,
            reduction.use = "pca",
            group.by = "treatment",
            do.label = TRUE,
            label.size = label_size,
            do.return = TRUE
        ))
        dev.off()
    }
))

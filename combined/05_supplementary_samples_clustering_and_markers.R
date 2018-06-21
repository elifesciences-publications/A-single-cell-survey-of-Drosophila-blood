library(rmarkdown)

# Clustering
bcb_files <- c(
    facs = "data/2018-06-19/facs.rda",
    sepsis = "data/2018-06-19/sepsis.rda"
)
mapply(
    bcb_file = bcb_files,
    seurat_name = paste(names(bcb_files), "seurat", sep = "_"),
    FUN = function(bcb_file, seurat_name) {
        render(
            input = "seurat_clustering.Rmd",
            output_file = paste0(seurat_name, ".html"),
            output_format = "html_document",
            params = list(
                bcb_file = bcb_file,
                seurat_name = seurat_name
            )
        )
    }
)

# Markers
seurat_files <- c(
    facs = "data/2018-06-19/facs_seurat.rda",
    sepsis = "data/2018-06-19/sepsis_seurat.rda"
)
mapply(
    seurat_file = seurat_files,
    output_file = paste0(names(seurat_files), "_markers.html"),
    FUN = function(seurat_file, output_file) {
        render(
            input = "seurat_markers.Rmd",
            output_file = output_file,
            output_format = "html_document",
            params = list(
                seurat_file = seurat_file
            )
        )
    }
)

# Loop across the bcbioSingleCell subsets
# 2018-05-16
library(rmarkdown)

bcb_file_stem <- c(
    "bcb_filtered",
    "bcb_filtered_knee",
    "bcb_filtered_high_conf"
)
bcb_file <- paste0(bcb_file_stem, ".rda")
bcb_file <- file.path("data/2018-05-16", bcb_file)
stopifnot(all(file.exists(bcb_file)))

seurat_name <- paste(bcb_file_stem, "seurat", sep = "_")

mapply(
    bcb_file = bcb_file,
    seurat_name = seurat_name,
    FUN = function(bcb_file, seurat_name) {
        rmarkdown::render(
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

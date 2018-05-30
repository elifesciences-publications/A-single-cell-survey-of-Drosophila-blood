# 2018-05-29
library(bcbioSingleCell)  # v0.1.13
library(rmarkdown)

data_dir <- file.path("data", Sys.Date())

load("data/2018-05-16/bcb_filtered.rda")
sampleNames(bcb_filtered)

bcb_subsets <- subsetPerSample(
    object = bcb_filtered,
    assignAndSave = TRUE,
    dir = data_dir
)
print(bcb_subsets)

# Render R Markdown reports per bcbioSingleCell subset file
mapply(
    bcb_file = bcb_subsets,
    seurat_name = paste(names(bcb_subsets), "seurat", sep = "_"),
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

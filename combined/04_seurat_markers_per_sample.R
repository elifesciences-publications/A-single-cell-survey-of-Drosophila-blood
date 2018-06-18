library(bcbioSingleCell)
library(Seurat)
library(rmarkdown)

existing_data_dir <- "data/2018-06-18"
seurat_stems <- c(
    "blood2_CTTAATAG",
    "blood2_TAAGGCTC",
    "blood2_TCTTACGC",
    "blood3_ATAGCCTT",
    "blood3_CTTAATAG",
    "blood3_TAAGGCTC",
    "blood3_TCGCATAA",
    "injured",
    "uninjured"
) %>%
    paste("seurat", sep = "_")
seurat_files <- file.path(
    existing_data_dir,
    paste0(seurat_stems, ".rda")
)
names(seurat_files) <- seurat_stems
stopifnot(all(file.exists(seurat_files)))
print(seurat_files)

# Render R Markdown marker reports per seurat file
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

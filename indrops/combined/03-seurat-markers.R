library(bcbioSingleCell)
library(Seurat)
library(rmarkdown)

existing_data_dir <- "data/2018-06-18"
seurat_stems <- c(
    # per sample
    "blood2_CTTAATAG_seurat",
    "blood2_TAAGGCTC_seurat",
    "blood3_ATAGCCTT_seurat",
    "blood3_CTTAATAG_seurat",
    "blood3_TAAGGCTC_seurat",
    "blood3_TCGCATAA_seurat",
    # per treatment
    "injured_seurat",
    "uninjured_seurat",
    # all samples
    "seurat"
)
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

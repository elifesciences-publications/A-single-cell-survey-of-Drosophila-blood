library(bcbioSingleCell)
library(rmarkdown)

loadDataAsName(bcb = bcb_filtered, dir = "data/2018-06-18")
data_dir <- file.path("data", Sys.Date())
sampleNames(bcb)

# Per sample ===================================================================
per_sample_subsets <- subsetPerSample(bcb, assignAndSave = TRUE, dir = data_dir)
print(per_sample_subsets)

# Per treatment ================================================================
injured <- selectSamples(bcb, treatment = "injured")
uninjured <- selectSamples(bcb, treatment = "uninjured")
saveData(injured, uninjured, dir = data_dir)

# Render =======================================================================
bcb_files <- c(
    all_samples = "data/2018-06-18/bcb_filtered.rda",
    injured = "data/2018-06-18/injured.rda",
    uninjured = "data/2018-06-18/uninjured.rda",
    per_sample_subsets
)
stopifnot(all(file.exists(bcb_files)))
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

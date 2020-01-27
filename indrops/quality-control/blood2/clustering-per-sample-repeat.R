library(bcbioSingleCell)
library(pbapply)
library(rmarkdown)

source("setup.R")

# Enforce caching
opts_chunk[["set"]](
    audodep = TRUE,
    cache = TRUE,
    cache.lazy = FALSE)

loadDataAsName(c(bcb = "run2_2017_08_15"))

sampleIDs <- sampleMetadata(bcb) %>%
    pull(sampleID)
sampleSubsets <- pblapply(seq_along(sampleIDs), function(a) {
    sampleID <- sampleIDs[[a]]
    subset <- selectSamples(bcb, sampleID = sampleID)
    assignAndSaveData(name = sampleID, object = subset)
    sampleID
}) %>%
    unlist()

# Remove from analysis:
# "lanepool_TCGCATAA" PC2, failed sample.
# "lanepool_TCTTACGC" UNS OP, not of primary interest

sampleSubsets <- c(
    "lanepool_ATAGCCTT",  # SEP
    "lanepool_CTTAATAG",  # PC1
    "lanepool_TAAGGCTC"   # UC
)
saveData(sampleSubsets)

# Render RMarkdown reports per bcbioSingleCell subset file
pblapply(seq_along(sampleSubsets), function(a) {
    bcbName <- sampleSubsets[[a]]
    bcbFile <- file.path("data", paste0(bcbName, ".rda"))
    seuratName <- paste(bcbName, "seurat", sep = "_")
    render(input = "clustering.Rmd",
           output_file = paste0(bcbName, ".html"),
           output_format = "html_document",
           params = list(
               bcbFile = bcbFile,
               seuratName = seuratName
           ))
}) %>%
    invisible()

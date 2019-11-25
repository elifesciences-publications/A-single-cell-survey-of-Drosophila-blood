library(bcbioSingleCell)
library(pbapply)
library(rmarkdown)
library(tidyverse)

source("setup.R")

# Enforce caching
opts_chunk[["set"]](
    audodep = TRUE,
    cache = TRUE,
    cache.lazy = FALSE)

loadDataAsName(bcb = "data/R/2018-01-24/run3_2018_01_10_filtered.rda")
dataDir <- file.path("data", "R", Sys.Date())

sampleIDs <- sampleMetadata(bcb) %>%
    pull(sampleID)
sampleSubsets <- pblapply(seq_along(sampleIDs), function(a) {
    sampleID <- as.character(sampleIDs[[a]])
    subset <- selectSamples(bcb, sampleID = sampleID)
    assignAndSaveData(
        name = sampleID,
        object = subset,
        dir = dataDir)
    sampleID
}) %>%
    unlist()
saveData(sampleSubsets, dir = dataDir)

# Render RMarkdown reports per bcbioSingleCell subset file
pblapply(seq_along(sampleSubsets), function(a) {
    bcbName <- sampleSubsets[[a]]
    bcbFile <- file.path(dataDir, paste0(bcbName, ".rda"))
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


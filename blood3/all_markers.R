library(bcbioSingleCell)
source("setup.R")
loadData(sampleSubsets, cellTypeMarkers)

genes <- c(cellTypeMarkers$symbol)
# Add a marker gene (e.g. EGFP)
genes <- c("EGFP", genes)

lapply(seq_along(sampleSubsets), function(a) {
    seuratName <- paste(sampleSubsets[[a]], "seurat", sep = "_")
    loadDataAsName(c(seurat = seuratName))
    sampleName <- seurat@misc$bcbio$sampleMetadata$sampleName
    message(paste(
        seuratName,
        sampleName,
        sep = " : "
    ))
    pdf(file = paste(sampleName, "markers.pdf", sep = "_"),
        height = 14.5,
        width = 10)
    plotMarkers(seurat, genes = genes)
    dev.off()
}) %>%
    invisible()

plotMarkers(
    seurat,
    genes = "EGFP",
    dark = FALSE,
    color = scale_color_gradient(low = "lightgray", high = "purple")
)

# Compare FlyBase and Ensembl annotations

library(bcbioSingleCell)
load("data/2018-05-01/bcb.rda")

dir <- file.path("data", Sys.Date())

# Ensembl 92 requires Bioconductor 3.7
ensembl <- makeGRangesFromEnsembl(
    organism = "Drosophila melanogaster",
    release = 92L
)
saveData(ensembl, dir = dir)
ensembl_mcols <- mcols(ensembl)
# Use FlyBase for geneNames (symbols), not Ensembl
ensembl_mcols$geneName <- NULL
# ensembl_mcols %>% as.data.frame() %>% View()

flybase <- rowRanges(bcb)
flybase_mcols <- mcols(flybase)
# flybase_mcols %>% as.data.frame() %>% View()

flybase_only_genes <- setdiff(flybase_mcols$geneID, ensembl_mcols$geneID)
ensembl_only_genes <- setdiff(ensembl_mcols$geneID, flybase_mcols$geneID)
saveData(flybase_only_genes, ensembl_only_genes, dir = dir)

# Use Ensembl for biotype, not FlyBase
# These are okay to drop.
# The FlyBase only genes will be annotated as "other" broadClass from the GTF.
flybase_mcols$broadClass <- NULL

# Only `geneID` should intersect
stopifnot(identical(
    intersect(colnames(flybase_mcols), colnames(ensembl_mcols)),
    "geneID"
))

new_mcols <- merge(
    x = flybase_mcols,
    y = ensembl_mcols,
    by = "geneID",
    all.x = TRUE
)

# Make sure that no NAs are introduced during merge
stopifnot(identical(
    flybase_mcols$geneID,
    new_mcols$geneID
))

bcb_ensembl <- bcb
mcols(rowRanges(bcb_ensembl)) <- new_mcols
# Recalculate the metrics using Ensembl biotype information
rowData <- rowData(bcb_ensembl)
counts <- counts(bcb_ensembl)
colData <- metrics(counts, rowData = rowData) %>% as("DataFrame")
# FIXME This will drop the `nCount` column in metrics...
colData(bcb_ensembl) <- colData
interestingGroups(bcb_ensembl) <- "treatment"
saveData(bcb_ensembl, dir = dir)

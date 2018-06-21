# Write the filtered counts matrix to disk, for STREAM
library(bcbioSingleCell)
load("data/2018-06-15/bcb_filtered.rda")
show(bcb_filtered)

counts <- counts(bcb_filtered)
dim(counts)
c("EGFP", "gal4") %in% rownames(counts)

counts %>%
    as.matrix() %>%
    write.table(
        file = "counts.tsv",
        sep = "\t",
        quote = FALSE,
        col.names = NA
    )

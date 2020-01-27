# Write out logcounts for all samples combined
# Generate a heatmap of just the ribosomal genes
# Plot these out as markers on the t-SNE

library(bcbioSingleCell)
library(Seurat)
library(tidyverse)
library(ggplot2)

theme_set(
    theme_paperwhite(
        base_size = 14L,
        legend_position = "right"
    )
)

# Injured and uninjured samples combined
load("data/2018-06-18/seurat.rda")

data_dir <- file.path("data", Sys.Date())
dir.create(data_dir, recursive = TRUE, showWarnings = FALSE)

results_dir <- file.path("results", Sys.Date(), "all_samples")
dir.create(data_dir, recursive = TRUE, showWarnings = FALSE)

# Raw counts
seurat@raw.data %>%
    as.matrix() %>%
    write.csv(file.path(results_dir, "raw_counts.csv"))

# Log-normalized counts
seurat@data %>%
    as.matrix() %>%
    write.csv(file.path(results_dir, "log_counts.csv"))

# Write out sample metadata
sampleData(seurat) %>%
    as.data.frame() %>%
    write.csv(file.path(results_dir, "sample_metadata.csv"))

# Write out metrics
metrics(seurat) %>%
    write.csv(file.path(results_dir, "metrics.csv"))

# Write out gene annotations
rowRanges(seurat) %>%
    as.data.frame() %>%
    write.csv(file.path(results_dir, "gene_annotations.csv"))

colnames(sampleData(seurat))

# t-SNE plots
pdf(
    file = file.path(results_dir, "plot_tsne.pdf"),
    width = 10,
    height = 10
)
plotTSNE(seurat, interestingGroups = "ident")
plotTSNE(seurat, interestingGroups = "sampleName")
plotTSNE(seurat, interestingGroups = "treatment")
dev.off()

# UMAP plots
pdf(
    file = file.path(results_dir, "plot_umap.pdf"),
    width = 10,
    height = 10
)
plotUMAP(seurat, interestingGroups = "ident")
plotUMAP(seurat, interestingGroups = "sampleName")
plotUMAP(seurat, interestingGroups = "treatment")
dev.off()

# Ribosome genes: RpL, RpS
annotable <- as.data.frame(rowRanges(seurat))
ribosome_tbl <- annotable %>%
    filter(str_detect(geneName, "^Rp[LS]")) %>%
    arrange(geneName)
ribosome_genes <- pull(ribosome_tbl, "geneName")
saveData(ribosome_tbl, ribosome_genes, dir = data_dir)
stopifnot(all(ribosome_genes %in% rownames(seurat)))

# > ribosome_genes
#  [1] "RpL10"      "RpL10Ab"    "RpL11"      "RpL12"      "RpL13"
#  [6] "RpL13A"     "RpL14"      "RpL15"      "RpL17"      "RpL18"
# [11] "RpL18A"     "RpL19"      "RpL21"      "RpL22"      "RpL22-like"
# [16] "RpL23"      "RpL23A"     "RpL24"      "RpL24-like" "RpL26"
# [21] "RpL27"      "RpL27A"     "RpL28"      "RpL29"      "RpL3"
# [26] "RpL30"      "RpL31"      "RpL32"      "RpL34a"     "RpL34b"
# [31] "RpL35"      "RpL35A"     "RpL36"      "RpL36A"     "RpL37a"
# [36] "RpL37A"     "RpL38"      "RpL39"      "RpL4"       "RpL40"
# [41] "RpL41"      "RpL5"       "RpL6"       "RpL7"       "RpL7-like"
# [46] "RpL7A"      "RpL8"       "RpL9"       "RpLP0"      "RpLP0-like"
# [51] "RpLP1"      "RpLP2"      "RpS10a"     "RpS10b"     "RpS11"
# [56] "RpS12"      "RpS13"      "RpS14a"     "RpS14b"     "RpS15"
# [61] "RpS15Aa"    "RpS15Ab"    "RpS16"      "RpS17"      "RpS18"
# [66] "RpS19a"     "RpS19b"     "RpS2"       "RpS20"      "RpS21"
# [71] "RpS23"      "RpS24"      "RpS25"      "RpS26"      "RpS27"
# [76] "RpS27A"     "RpS28b"     "RpS29"      "RpS3"       "RpS30"
# [81] "RpS3A"      "RpS4"       "RpS5a"      "RpS5b"      "RpS6"
# [86] "RpS7"       "RpS8"       "RpS9"

# Marker t-SNE
pdf(
    file = file.path(results_dir, "ribosome_marker_tsne.pdf"),
    width = 10,
    height = 10
)
plotMarkerTSNE(
    seurat,
    genes = ribosome_genes,
    label = FALSE,
    title = "Ribosome genes"
)
dev.off()

# Dot plot
pdf(
    file = file.path(results_dir, "ribosome_dot_plot.pdf"),
    width = 20,
    height = 5
)
plotDot(seurat, genes = ribosome_genes)
dev.off()

# Heatmap (need to come back to this)
# stopifnot(all(ribosome_genes %in% seurat@var.genes))
# stopifnot(all(ribosome_genes %in% rownames(seurat@scale.data)))
# png(
#     file = file.path(results_dir, "ribosome_heatmap.png"),
#     width = 1000,
#     height = 1000
# )
# DoHeatmap(
#     object = seurat,
#     genes.use = ribosome_genes,
#     slim.col.label = TRUE,
#     do.plot = FALSE
# )
# dev.off()

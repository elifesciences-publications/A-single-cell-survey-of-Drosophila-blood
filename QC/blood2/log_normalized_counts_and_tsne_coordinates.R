# 2017-08-10 clustering results of run 2 samples
library(Seurat)

load("data/R/2017-08-10/pc1Seurat.rda")
load("data/R/2017-08-10/ucSeurat.rda")

results_dir <- file.path(
    "results",
    Sys.Date(),
    "run2_log_normalized_counts_and_tsne_coordinates")
dir.create(results_dir, recursive = TRUE)

# PC1
plotTSNE(pc1Seurat)
pc1_log_normalized_counts <- slot(pc1Seurat, "data") %>% as.matrix()
dim(pc1_normalized_counts)
write.csv(pc1_log_normalized_counts, file = file.path(results_dir, "pc1_log_normalized_counts.csv"))
pc1_tsne <- FetchData(pc1Seurat, vars.all = c("tSNE_1", "tSNE_2"))
write.csv(pc1_tsne, file = file.path(results_dir, "pc1_tsne.csv"))

# UC
plotTSNE(ucSeurat)
uc_log_normalized_counts <- slot(ucSeurat, "data") %>% as.matrix()
dim(uc_log_normalized_counts)
write.csv(uc_log_normalized_counts, file = file.path(results_dir, "uc_log_normalized_counts.csv"))
uc_tsne <- FetchData(ucSeurat, vars.all = c("tSNE_1", "tSNE_2"))
write.csv(uc_tsne, file = file.path(results_dir, "uc_tsne.csv"))

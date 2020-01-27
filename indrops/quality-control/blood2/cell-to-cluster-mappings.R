# Run 2 Seurat cell to cluster mappings
# Michael Steinbaugh
# 2018-12-15

library(Seurat)
library(tidyverse)

# 2017-08-10 clustering results of run 2 samples
load("data/R/2017-08-10/pc1Seurat.rda")
load("data/R/2017-08-10/ucSeurat.rda")

results_dir <- file.path(
    "results",
    Sys.Date(),
    "run2_cell_to_cluster_mappings")
dir.create(results_dir, recursive = TRUE)

pc1_ident <- pc1Seurat@ident
pc1_ident_tibble <- tibble(
    cell = names(pc1_ident),
    cluster = pc1_ident
)
write_csv(
    pc1_ident_tibble,
    path = file.path(results_dir, "pc1_ident_tibble.csv")
)

uc_ident <- ucSeurat@ident
uc_ident_tibble <- tibble(
    cell = names(uc_ident),
    cluster = uc_ident
)
write_csv(
    uc_ident_tibble,
    path = file.path(results_dir, "uc_ident_tibble.csv")
)

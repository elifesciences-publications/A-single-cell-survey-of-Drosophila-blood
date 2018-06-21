library(basejump)
seurat_files <- c(
    all_samples = "data/2018-06-18/seurat.rda",
    # per sample
    injured_1 = "data/2018-06-18/blood2_CTTAATAG_seurat.rda",
    injured_3 = "data/2018-06-18/blood3_CTTAATAG_seurat.rda",
    injured_4 = "data/2018-06-18/blood3_TCGCATAA_seurat.rda",
    uninjured_3 = "data/2018-06-18/blood2_TAAGGCTC_seurat.rda",
    uninjured_4 = "data/2018-06-18/blood3_ATAGCCTT_seurat.rda",
    uninjured_5 = "data/2018-06-18/blood3_TAAGGCTC_seurat.rda",
    # per treatment
    injured = "data/2018-06-18/injured_seurat.rda",
    uninjured = "data/2018-06-18/uninjured_seurat.rda",
    # supplementary
    facs = "data/2018-06-19/facs_seurat.rda",
    sepsis = "data/2018-06-19/sepsis_seurat.rda"
)
stopifnot(all(file.exists(seurat_files)))
saveData(seurat_files, dir = file.path("data", Sys.Date()))

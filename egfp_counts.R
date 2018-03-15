library(bcbioSingleCell)
library(tidyverse)

egfp <- assay(bcbFiltered) %>%
    .["EGFP", ] %>%
    as.data.frame() %>%
    setNames("egfp") %>%
    rownames_to_column() %>%
    cbind(metrics(bcbFiltered)) %>%
    filter(egfp > 0) %>%
    arrange(desc(egfp))
saveData(egfp)
dir.create("results")
write_csv(egfp, "results/egfp.csv.gz")

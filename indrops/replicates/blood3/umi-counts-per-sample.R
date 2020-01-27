library(bcbioSingleCell)
library(tidyverse)
load("data/R/2018-01-10/run3_2018_01_10.rda")

metrics <- metrics(run3_2018_01_10)
sample_summary <- metrics %>%
    select(sampleName, nUMI, nGene, nCoding) %>%
    group_by(sampleName) %>%
    summarize_all(sum)

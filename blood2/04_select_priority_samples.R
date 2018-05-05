source("setup.R")
data(bcbFiltered)
bcbFilteredPriority <- selectSamples(
    bcbFiltered,
    sampleName = c("PC1", "SEP", "UC"))
saveData(bcbFilteredPriority)

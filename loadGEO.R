# download data

if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("GEOquery")
library(GEOquery)
GSE156309 <- getGEO("GSE156309",destdir = 'data/')
save.image("data/images.RData")
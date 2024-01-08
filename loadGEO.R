# download data

if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("GEOquery")
library(GEOquery)
GSE193566 <-  getGEO("GSE193566",destdir = 'data/')
GSE173263 <- getGEO("GSE173263",destdir = 'data/')
GSE156309 <- getGEO("GSE156309",destdir = 'data/')
GSE212114 <- getGEO("GSE212114",destdir = 'data/')
save.image("data/images.RData")

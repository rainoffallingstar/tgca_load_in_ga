# download data
pak::pak("rainoffallingstar/erebor")
GSE_ID_methyl <- c("GSE25706","GSE29047","GSE29189",
                   "GSE40870","GSE42042","GSE44830",
                   "GSE58477","GSE62298","GSE63409",
                   "GSE78963","GSE79695","GSE80508",
                   "GSE80762","GSE86409","GSE89776")
fs::dir_create("data")
while(length(list.files("data")) + 1 <= 15) {
  for (i in 1:length(GSE_ID_methyl)){
    message(glue::glue("processing {GSE_ID_methyl[i]}"))
    if (!file.exists(paste0("data/",GSE_ID_methyl[i],".RDS"))){
      methydata <- erebor::MoriaClass$new(GSE_ID_methyl[i],"GEO")
      methydata <- methydata$download()
      saveRDS(methydata,file = paste0("data/",GSE_ID_methyl[i],".RDS"))
    }
  }
}

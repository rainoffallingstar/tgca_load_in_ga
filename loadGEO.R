# download data
get_metadata <- function(mine){
  fs::dir_create("temp")
  fs::dir_create("data")
  data <- GEOquery::getGEO(mine,destdir = 'temp')
  for (i in 1:1){
    metadata <- data.frame(
      gseid = mine,
      platform = data[[i]]@annotation,
      title = data[[i]]@experimentData@title,
      abstract = data[[i]]@experimentData@abstract,
      summary =  data[[i]]@experimentData@other$summary,
      overall_design = data[[i]]@experimentData@other$overall_design,
      type = data[[i]]@experimentData@other$type,
      samplenum = nrow(data[[i]]@phenoData@data)
    )
   saveRDS(metadata,paste0("data/",mine,".RDS"))
  }
  fs::dir_delete("temp")
}
amlRDS2 <- readRDS("amlrds.RDS")
for (i in 1:1400) {
  message(glue::glue("info:: {i}/1400"))
  get_metadata(amlRDS2[i])
}



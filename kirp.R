# download data
pak::pak("rainoffallingstar/erebor")
load("0427.RData")
tiny_download <- function(dir = "data",GSE_ID_expre){
  fs::dir_create(dir)
  for (i in 1:length(GSE_ID_expre)){
    message(glue::glue("processing {GSE_ID_expre[i]} {i}/{length(GSE_ID_expre)}"))
    if (!file.exists(paste0(dir,"/",GSE_ID_expre[i],".RDS"))){
      exprdata <- erebor::MoriaClass$new(GSE_ID_expre[i],"GEO")
      exprdata <- exprdata$download(sup = FALSE)
      saveRDS(exprdata,file = paste0(dir,"/",GSE_ID_expre[i],".RDS"))
    }
  }
}
mm_geo <- mm_geo[!grepl("GSE136400",mm_geo)]
mm_geo <- na.omit(mm_geo)
tiny_download("data",mm_geo[641:779])

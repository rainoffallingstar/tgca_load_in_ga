pak::pak("rainoffallingstar/erebor")
GSE_ID_expre <- c("GSE976","GSE1729","GSE7538","GSE7757",
                  "GSE8970","GSE9476","GSE10258","GSE11877",
                  "GSE12326","GSE12662","GSE14062","GSE14468",
                  "GSE14479","GSE14858","GSE14924","GSE15013",
                  "GSE15434","GSE16015","GSE17855","GSE18018",
                  "GSE18673","GSE19577","GSE19681","GSE21261",
                  "GSE22056","GSE22845","GSE23025","GSE27187",
                  "GSE29883","GSE30442","GSE33223","GSE34733",
                  "GSE34860","GSE35784","GSE38987","GSE39363",
                  "GSE39730","GSE42064","GSE43176","GSE45249",
                  "GSE110087","GSE111678","GSE169428","GSE46819",
                  "GSE50928","GSE52478","GSE52891", "GSE56237",
                  "GSE61804","GSE68172","GSE70124","GSE84334",
                  "GSE84881","GSE104099","GSE107465","GSE109179",
                  "GSE130753","GSE1427","GSE2191","GSE4119",
                  "GSE4608","GSE5122","GSE199452","GSE199451",
                  "GSE129094","GSE157633","GSE165430","GSE106291",
                  "GSE86506", "GSE84359","GSE71800","GSE62852",
                  "GSE48843","GSE199455","GSE142514","GSE108003",
                  "GSE30029","GSE31941","GSE34577","GSE34594",
                  "GSE67936","GSE68466","GSE71014","GSE76340",
                  "GSE127200","GSE19853")

fs::dir_create("data")
while(length(list.files("data")) + 1 <= 86) {
  for (i in 1:length(GSE_ID_expre)){
    message(glue::glue("processing {GSE_ID_expre[i]}"))
    if (!file.exists(paste0("data/",GSE_ID_expre[i],".RDS"))){
      exprdata <- erebor::MoriaClass$new(GSE_ID_expre[i],"GEO")
      exprdata <- exprdata$download()
      saveRDS(exprdata,file = paste0("data/",GSE_ID_expre[i],".RDS"))
    }
  }
}

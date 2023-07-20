# download data

library(TCGAbiolinks)
library(SummarizedExperiment)
library(dplyr)

### general gdc load_data workflow

get_gdc_data <- function(project,dataca = "Transcriptome Profiling",
                         data_type = "Gene Expression Quantification"){
  if (dataca == "Clinical") {
    query_result <- GDCquery(project = project,
                             data.category = dataca,
                             data.format = "bcr xml"
                             ) 
    
  } else {
    query_result <- GDCquery(
      project = project, 
      data.category = dataca,
      data.type = data_type,
      workflow.type = "STAR - Counts"
    ) # 查询数据
    process_query <- getResults(query_result ,cols = "cases") 
    index <- duplicated(process_query)
    process_query2 <- process_query[!index] # 去除重复的样本数据/患者数据
    query_result <- GDCquery(
      project = project, 
      data.category = dataca,
      data.type = data_type,
      workflow.type = "STAR - Counts",
      barcode = process_query2
      
    )
  }
  
  GDCdownload(query_result,method="api")
  if (dataca == "Clinical") {
    data_pre <- GDCprepare_clinic(query_result, clinical.info = "patient")
    
  } else {
    data_pre <- GDCprepare(query_result)
  }
  return(data_pre)
  
}

# load TGCA-LAML

tgca_laml_gene <- get_gdc_data("TCGA-KIRP")
tgca_laml_clinical <- get_gdc_data("TCGA-KIRP",dataca = "Clinical")
counts <- as.data.frame(assay(tgca_laml_gene))
data <- as.data.frame(rowRanges(tgca_laml_gene))#获取其它信息数据
#这里面就包括注释以及编码、非编码等等信息
expr_count = cbind(gene_type=data$gene_type,gene_name=data$gene_name,counts)
save.image("data/images.RData")
write.table(expr_count,"expr_count.csv")
write.table(tgca_laml_clinical,"clinical.csv")

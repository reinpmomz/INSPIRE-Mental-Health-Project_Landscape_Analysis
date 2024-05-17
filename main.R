######################################################################

### Start with a clean environment by removing objects in workspace
rm(list=ls())

### Setting work directory
working_directory <- base::setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
#working_directory <- base::setwd(".")

### Load Rdata
Rdata_files <- list.files(path = working_directory, pattern = "*.RData", full.names = T)

if ( length(Rdata_files) >0) {
  invisible(lapply(Rdata_files,load,.GlobalEnv))
} else {
  paste(c(".RData files", "do not exist"), collapse = " ")
}

### Install required packages
source("requirements.R")

### helper/customized functions
source("helperfuns_1.R")

### Load recode file
source("load_recode_file.R")

### Load IDAIR data 
#source("load_data_drive.R")
source("load_data_local.R")

### Data cleaning
source("cleaning.R")

### Inclusion/Exclusion Criteria
source("inclusion_exclusion.R")

### Inclusion criteria studies
source("inclusion_studies.R")

### Random Inclusion/Exclusion Data for QA/QC
source("qa_qc_data.R")

### DOI retrieval from API for inclusion longitudinal
source("doi_retrieval.R")

### Save Inclusion/Exclusion, inclusion longitudinal output
source("save_inclusion_exclusion_output.R")

######################################################################

### Load meta data for inclusion longitudinal quality checks 
source("load_meta_data.R")

### Flowchart
source("flowchart.R")

### Descriptives articles for final inclusion longitudinal
source("descriptive_articles_stats.R")

### Save descriptives articles output
source("save_descriptive_articles_output.R")

### Tools for final inclusion longitudinal
source("mh_tools_data.R")

### Descriptives Tools for final inclusion longitudinal
source("descriptive_tools_stats.R")

### Save Descriptives Tools output
source("save_descriptive_tools_output.R")

### Africa Map of articles
source("articles_map.R")

### Africa Map of tools
source("tools_map.R")

### Heat maps of tools - Africa
source("tools_heatmap.R")


######################################################################

## Save workspace at the end without working directory path

save(list = ls(all.names = TRUE)[!ls(all.names = TRUE) %in% c("working_directory", "mainDir", "subDir_output", "output_Dir",
                                                              "local_download", "file_id", "list_folders", "list_files",
                                                              "Rdata_files")],
     file = "landscape_idair.RData",
     envir = .GlobalEnv #parent.frame()
     )

######################################################################

## Run all files in Rstudio
source("main.R")

######################################################################


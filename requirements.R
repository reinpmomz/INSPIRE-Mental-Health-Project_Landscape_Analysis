## Setting work directory and output folder

#working_directory <- setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
working_directory

mainDir <- base::getwd()
subDir_data <- "data"
subDir_output <- "Output"

data_Dir <- base::file.path(mainDir, subDir_data)
output_Dir <- base::file.path(mainDir, subDir_output)

### create data folder
base::ifelse(!base::dir.exists(data_Dir), base::dir.create(data_Dir), "Sub Directory exists")

### create output folder
base::ifelse(!base::dir.exists(output_Dir), base::dir.create(output_Dir), "Sub Directory exists")

## Install required packages

### Install CRAN packages
required_packages <- c("tidyverse", "janitor", "knitr", "readxl", "writexl", "tibble",
                       "DiagrammeR", "DiagrammeRsvg", "rsvg", "jsonlite", "httr", "officer", "sf",
                       "rnaturalearth", "rnaturalearthdata", "giscoR")

installed_packages <- required_packages %in% base::rownames(utils::installed.packages())

if (base::any(installed_packages==FALSE)) {
  utils::install.packages(required_packages[!installed_packages], repos = "http://cran.us.r-project.org")
}

### load libraries
base::invisible(base::lapply(required_packages, library, character.only=TRUE))


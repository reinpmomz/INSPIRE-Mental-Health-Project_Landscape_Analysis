library(dplyr)
library(janitor)

working_directory

## Reading the IDAIR authors list data from local folder

authors <- read_excel_allsheets(filename = base::file.path(data_Dir, "African_authors_detailed_list (2) (1).xlsx")
                                )

df <- authors[["African_authors_detailed_list ("]] %>%
  janitor::clean_names() %>%
  dplyr::mutate( source_authors_country_name = gsub("^\\s|\\s$", "", source_authors_country_name) 
                 #Removing space at beginning and end of string
                 )


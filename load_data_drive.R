library(dplyr)
library(googledrive)
library(janitor)

working_directory

## Reading the data from google drive
drive_auth(#email = ""
  )

file_id <- drive_find(shared_drive = c(shared_drive_find(pattern = "Data Science Programs")$id),
                      q = c("name = 'Mental Health'",  "mimeType = 'application/vnd.google-apps.shortcut'")
                      #search for a specific set of shared drives, use the query string q
                      ) 

list_folders <- drive_ls(path = file_id$id, 
                         q = c("name = 'IDAIR List'", "mimeType = 'application/vnd.google-apps.folder'")
                         )

list_files <- drive_ls(path = list_folders$id,
                       q = c("name = 'African_authors_detailed_list (2) (1).xlsx'")
                       )

local_download <- drive_download(list_files$id, overwrite = TRUE)

## reading the authors list data
authors <- read_excel_allsheets(paste0(local_download$local_path))

df <- authors[["African_authors_detailed_list ("]] %>%
  janitor::clean_names() %>%
  dplyr::mutate( source_authors_country_name = gsub("^\\s|\\s$", "", source_authors_country_name) 
                 #Removing space at beginning and end of string
                 )


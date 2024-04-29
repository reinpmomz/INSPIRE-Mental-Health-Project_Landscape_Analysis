library(dplyr)
library(janitor)

working_directory

## reading the meta data from local folder
metadata_list <- read_excel_allsheets(filename = "Longitudinal Meta data.xlsx")
data_request_list <- read_excel_allsheets(filename = "Track_list of data request letters.xlsx")

df_track_list <- data_request_list[["inclusion_longitudinal_data_req"]]

df_africa_countries <- metadata_list[["african_countries"]]

df_mh_tools <- metadata_list[["mh_tools"]]

df_top_n <- metadata_list[["top_n_tools"]]

df_meta <- metadata_list[["inclusion_longitudinal"]] %>%
  janitor::clean_names() %>%
  dplyr::left_join(df_africa_countries %>%
                     dplyr::select(country, region), 
                   by = c("study_country" = "country")
                   )

## correctly identified
df_quality <- df_meta %>%
  dplyr::filter(correctly_identified == "Yes") %>%
  dplyr::left_join(df_track_list %>%
                     dplyr::select(number, request_letter_number, status_email_request, data_received),
                   by = c("number" = "number", 
                          "request_letter_number" = "request_letter_number")
                   ) %>%
  mutate(data_received = if_else(status_email_request != "Responded", NA, data_received ))

df_quality_request <- df_quality %>%
  dplyr::filter(availability_of_data_article == "yes")

df_quality_no_request <- df_quality %>%
  dplyr::filter(availability_of_data_article == "no")


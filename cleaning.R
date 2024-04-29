library(dplyr)
library(tidyr)
library(stringr)


working_directory

## Delete missing titles
df_missing <- df %>%
  tidyr::drop_na(source_title)

## Distinct titles
df_distinct <- df_missing %>%
  dplyr::mutate( source_title = str_to_title(source_title) 
                 , source_title = gsub("\\.$", "", source_title) #Removing period at end of string
  ) %>% 
  dplyr::distinct(source_title, .keep_all = TRUE)

## delete non-african authors  
df_africa <- df_distinct %>%
  dplyr::mutate( country = sapply(stringr::str_extract_all(paste(source_authors_affiliations_name, source_title,
                                                                 source_fields_of_study), world_country_words), toString)
                 , country = dplyr::if_else(is.na(country) | country == "", source_authors_country_name, country)
                 , country_new = stringr::str_extract(country, african_country_words)
                 , country_new = dplyr::if_else(is.na(country_new) | country_new == "", 
                                                source_authors_country_name, country_new)
                 , country_new = stringr::str_to_title(country_new)
                 , country_new = ifelse(str_detect(paste(source_authors_affiliations_name, source_title,
                                                         source_fields_of_study), nigeria_country_words) , "Nigeria",
                                        ifelse(str_detect(paste(source_authors_affiliations_name, source_title,
                                                                source_fields_of_study), south_korea_country_words) ,
                                               "South Korea", country_new))
                 ) %>%
  filter(str_detect(country, african_country_words), str_detect(country_new, african_country_words)
         ) %>%
  dplyr::relocate(country_new) %>%
  dplyr::select(-c(country, source_authors_country_name)
                ) %>%
  dplyr::rename(source_authors_country_name = country_new) %>%
  dplyr::arrange(source_authors_country_name) %>%
  dplyr::mutate(number= 1:n()
                )


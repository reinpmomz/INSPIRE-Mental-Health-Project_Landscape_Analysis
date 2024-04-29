library(dplyr)
library(tibble)
library(readxl)

working_directory

## Reading the recode file sheet

synthesis_recode_file <- read_excel_allsheets("synthesis_recode_file.xlsx")

### world countries
countries_world <- synthesis_recode_file[["countries_world"]]

countries_world <- ( countries_world %>%
                       dplyr::mutate( dplyr::across(c(country, continent), ~ gsub("^\\s|\\s$", "", .x) 
                                                    ) #Removing space at beginning and end of string
                                      , regex_country = paste0("\\b", country, "\\b")
                                      )
                     )

#### list of continents with countries
continents_countries <- sapply(unique(countries_world$continent), function(x) { 
  countries_world$country[countries_world$continent == x ]
}, simplify = FALSE
)

world_country_words <- regex(paste(c(countries_world$regex_country),  sep = "", collapse = '|'),
                             ignore_case = TRUE)

african_country_words <- regex(paste(c(countries_world$regex_country[countries_world$continent == "Africa"]),
                                     sep = "", collapse = '|'),
                               ignore_case = TRUE)

nigeria_country_words <- regex(paste(c("\\bbenin city\\b", "\\bbenin-city\\b"),  sep = "", collapse = '|'),
                               ignore_case = TRUE)

south_korea_country_words <- regex(paste(c("korea", "korean"),  sep = "", collapse = '|'),
                                   ignore_case = TRUE)

### Search Criteria
criteria <- synthesis_recode_file[["criteria"]]

criteria <- ( criteria %>%
                dplyr::mutate( criteria_words = gsub("^\\s|\\s$", "", criteria_words) 
                               #Removing space at beginning and end of string
                               , regex_criteria = base::ifelse(grepl("\\s+", criteria_words), # match 1 or more spaces
                                                               paste0("\\b", criteria_words, "\\b"), criteria_words)
                               )
              )

### Type of studies
study <- synthesis_recode_file[["study"]]

study <- ( study %>%
             dplyr::mutate( study_words = gsub("^\\s|\\s$", "", study_words) 
                            #Removing space at beginning and end of string
                            , regex_study = base::ifelse( study_words == "meta" | study_words == "review"
                                                          | study_words == "overview" | study_words == "literature" |
                                                            grepl("\\s+|[\\-]+", study_words), # match 1 or more spaces/hyphen
                                                          paste0("\\b", study_words, "\\b"), study_words)
                            )
           )



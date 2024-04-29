library(dplyr)
library(tidyr)
library(stringr)


working_directory

## Inclusion criteria
inclusion_words <- regex(paste(c(criteria$regex_criteria), sep = "", collapse = '|'),
                         ignore_case = TRUE)

longitudinal_words <- regex(paste(c(study$regex_study[study$type == "longitudinal"]),  sep = "", collapse = '|'),
                            ignore_case = TRUE)

review_words <- regex(paste(c(study$regex_study[study$type == "reviews"]),  sep = "", collapse = '|'),
                      ignore_case = TRUE)

control_trials_words <- regex(paste(c(study$regex_study[study$type == "control trials"]), sep = "", collapse = '|'),
                              ignore_case = TRUE)

psychosis_words <- regex(paste(c(criteria$regex_criteria[criteria$category == "psychosis"]),  sep = "", collapse = '|'),
                         ignore_case = TRUE)

depression_words <- regex(paste(c(criteria$regex_criteria[criteria$category == "depression"]), sep = "", collapse = '|'),
                          ignore_case = TRUE)

anxiety_words <- regex(paste(c(criteria$regex_criteria[criteria$category == "anxiety"]), sep = "", collapse = '|'),
                       ignore_case = TRUE)


df_inclusion <- df_africa %>%
  filter(str_detect(source_title, inclusion_words) |
           str_detect(source_fields_of_study, inclusion_words)
         ) %>%
  mutate(criteria = sapply(str_extract_all(paste(source_title, source_fields_of_study), inclusion_words), toString)
         , correctly_identified = NA
         , reason = NA
         )

## Exclusion criteria
df_exclusion <- df_africa %>%
  anti_join(df_inclusion, by = c("source_title", "source_fields_of_study")) %>% #return all rows from df_africa without a match in df_inclusion
  mutate(criteria = sapply(str_extract_all(paste(source_title, source_fields_of_study), inclusion_words), toString)
         , correctly_identified = NA
         , reason = NA
         )

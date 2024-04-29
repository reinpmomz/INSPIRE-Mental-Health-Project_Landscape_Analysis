library(dplyr)
library(tidyr)
library(stringr)


working_directory

## Inclusion control trials
df_inclusion_control_trials <- df_inclusion %>%
  filter(str_detect(source_title, control_trials_words) |
           str_detect(source_fields_of_study, control_trials_words )
  )

## Inclusion longitudinal studies
df_inclusion_longitudinal <- df_inclusion %>%
  filter(str_detect(source_title, longitudinal_words) |
           str_detect(source_fields_of_study, longitudinal_words )
  ) %>%
  anti_join(df_inclusion_control_trials, by = c("source_title", "source_fields_of_study"))

### control trials which are longitudinal
df_inclusion_longitudinal_control_trials <- df_inclusion %>%
  filter(str_detect(source_title, longitudinal_words) |
           str_detect(source_fields_of_study, longitudinal_words )
  ) %>%
  inner_join(df_inclusion_control_trials %>%
               dplyr::select(source_title, source_fields_of_study), by = c("source_title", "source_fields_of_study"))

## Inclusion systematic and literature reviews
df_inclusion_reviews <- df_inclusion %>%
  filter(str_detect(source_title, review_words) |
           str_detect(source_fields_of_study, review_words )
  ) %>%
  anti_join(df_inclusion_control_trials, by = c("source_title", "source_fields_of_study")) %>%
  anti_join(df_inclusion_longitudinal, by = c("source_title", "source_fields_of_study"))

### systematic and literature reviews which are longitudinal
df_inclusion_reviews_longitudinal <- df_inclusion %>%
  filter(str_detect(source_title, review_words) |
           str_detect(source_fields_of_study, review_words )
  ) %>%
  inner_join(df_inclusion_longitudinal %>%
               dplyr::select(source_title, source_fields_of_study), by = c("source_title", "source_fields_of_study"))

## Inclusion cross-sectional studies
df_inclusion_cross_sectional <- df_inclusion %>%
  anti_join(df_inclusion_control_trials, by = c("source_title", "source_fields_of_study")) %>%
  anti_join(df_inclusion_longitudinal, by = c("source_title", "source_fields_of_study")) %>%
  anti_join(df_inclusion_reviews, by = c("source_title", "source_fields_of_study"))


#### systematic and literature reviews - psychosis, depression, anxiety 
df_inclusion_reviews_psychosis <- df_inclusion_reviews %>%
  filter(str_detect(source_title, psychosis_words) |
           str_detect(source_fields_of_study,  psychosis_words )
         )

df_inclusion_reviews_depression <- df_inclusion_reviews %>%
  filter(str_detect(source_title, depression_words) |
           str_detect(source_fields_of_study,  depression_words )
         )

df_inclusion_reviews_anxiety <- df_inclusion_reviews %>%
  filter(str_detect(source_title, anxiety_words) |
           str_detect(source_fields_of_study,  anxiety_words )
         )

#### longitudinal studies - psychosis, depression, anxiety 
df_inclusion_longitudinal_psychosis <- df_inclusion_longitudinal %>%
  filter(str_detect(source_title, psychosis_words) |
           str_detect(source_fields_of_study,  psychosis_words )
         )

df_inclusion_longitudinal_depression <- df_inclusion_longitudinal %>%
  filter(str_detect(source_title, depression_words) |
           str_detect(source_fields_of_study,  depression_words )
         )

df_inclusion_longitudinal_anxiety <- df_inclusion_longitudinal %>%
  filter(str_detect(source_title, anxiety_words) |
           str_detect(source_fields_of_study,  anxiety_words )
         )


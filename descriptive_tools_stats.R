library(dplyr)
library(gtsummary)

working_directory

my_gtsummary_theme

gtsummary_compact_theme

## Descriptive statistics - Tools articles numeric

table_5 <- sapply(unique(df_tools_country_all$topic), function(x){
  nn <- x
  df <- df_tools_country_all %>%
    dplyr::mutate(study_country = as.factor(study_country)
                  ) %>%
    dplyr::filter(topic == nn) %>%
    dplyr::mutate(tools = as.factor(tools)
                  )
  
  out <- gtsummary::tbl_continuous(df
                                   ,variable = n
                                   ,include = tools
                                   ,by = study_country
                                   ,statistic = everything() ~ c("{sum}")
                                   ,digits = list(everything() ~ c(0)
                                                  )
                                   ) %>%
    gtsummary::add_overall(col_label = paste0("**Overall**", " N = ", length(unique(df$tools)))) %>%
    gtsummary::as_flex_table() 
  
}, simplify = FALSE
)

table_5

## Descriptive statistics - Tools articles proportion

table_6 <- sapply(unique(df_tools_country_all$topic), function(x){
  nn <- x
  df <- df_tools_country_all %>% 
    dplyr::slice(rep(seq(n()), times = n)) %>%
    dplyr::mutate(study_country = as.factor(study_country)
    ) %>%
    dplyr::filter(topic == nn) %>%
    dplyr::mutate(tools = as.factor(tools)
    )
  
  out <- tbl_summary(df,
                     include = tools,
                     by = study_country,
                     sort = all_categorical() ~ "frequency",
                     percent = "column",
                     type = list(
                       all_dichotomous() ~ "categorical")
                     , digits = list(all_categorical() ~ c(0, 1))
                     , missing = "ifany" #list missing data separately #ifany #no #always
                     ,missing_text = "Missing"
                     ) %>% 
    modify_header(label = "**Descriptives**") %>% # update the column header
    bold_labels() %>%
    italicize_levels() %>%
    gtsummary::add_overall() %>%
    gtsummary::as_flex_table()
  
}, simplify = FALSE
)

table_6

## Descriptive statistics - Tools articles proportion top n
table_7 <- sapply(unique(df_tools_country_top_n_all$topic), function(x){
  nn <- x
  
  df <- df_tools_country_top_n_all %>% 
    dplyr::slice(rep(seq(n()), times = n)) %>%
    dplyr::mutate(study_country = as.factor(study_country)
    ) %>%
    dplyr::filter(topic == nn) %>%
    dplyr::mutate(tools_new = as.factor(tools_new)
    )
  
  out <- tbl_summary(df,
                     include = tools_new,
                     by = study_country,
                     sort = all_categorical() ~ "frequency",
                     percent = "column",
                     type = list(
                       all_dichotomous() ~ "categorical")
                     , digits = list(all_categorical() ~ c(0, 1))
                     , missing = "ifany" #list missing data separately #ifany #no #always
                     ,missing_text = "Missing"
  ) %>% 
    modify_header(label = "**Descriptives**") %>% # update the column header
    bold_labels() %>%
    italicize_levels() %>%
    gtsummary::add_overall() %>%
    gtsummary::as_flex_table()
  
}, simplify = FALSE
)

table_7


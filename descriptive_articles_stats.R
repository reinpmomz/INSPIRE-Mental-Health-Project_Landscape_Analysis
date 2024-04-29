library(dplyr)
library(gtsummary)

working_directory

my_gtsummary_theme

gtsummary_compact_theme

## Descriptive statistics - Articles

### Quality check
table_1 <- tbl_summary(df_meta %>%
                         dplyr::select(correctly_identified, reason), 
                       type = list(
                         all_dichotomous() ~ "categorical")
                       , digits = list(all_categorical() ~ c(0, 1))
                       , missing = "ifany" #list missing data separately #ifany #no #always
                       ,missing_text = "Missing"
) %>% 
  modify_header(label = "**Descriptives**") %>% # update the column header
  bold_labels() %>%
  italicize_levels()%>%
  add_n( statistic = "{n}", col_label = "**n**", last = FALSE, footnote = FALSE)%>% # add column with total number of non-missing observations
  modify_caption(caption = "Quality Check") %>%
  as_flex_table() #covert gtsummary object to knitrkable object. also use as_flex_table() to maintain identation, footnotes, spanning headers

table_1


### Overall Descriptives

table_2 <- tbl_summary(df_quality %>%
                         dplyr::select(source_year_published, region, study_country, type_of_study, depression, anxiety, psychosis,
                                       availability_of_data_article, how_to_access_the_data, status_email_request, data_received), 
                       type = list(
                         all_dichotomous() ~ "categorical",
                         all_continuous() ~ "continuous2")
                       , statistic = list(
                         source_year_published ~ c(
                           "{min} - {max}" )
                       )
                       , digits = list(all_categorical() ~ c(0, 1),
                                       all_continuous() ~ 0
                       )
                       , missing = "ifany" #list missing data separately #ifany #no #always
                       ,missing_text = "Missing"
) %>% 
  modify_header(label = "**Descriptives**") %>% # update the column header
  bold_labels() %>%
  italicize_levels()%>%
  add_n( statistic = "{n}", col_label = "**n**", last = FALSE, footnote = FALSE)%>% # add column with total number of non-missing observations
  modify_caption(caption = "Correctly Identified Articles (N = {N})") 

table_2


### By Descriptives
table_3 <- sapply(c("type_of_study", "depression", "anxiety", "psychosis", 
                    "availability_of_data_article" ), function(x){
                      
                      nn <- x
                      out <- if (nn == "type_of_study") {
                        tbl_summary(df_quality %>%
                                      dplyr::select(source_year_published, region, study_country, type_of_study, depression, anxiety, psychosis,
                                                    availability_of_data_article, how_to_access_the_data, status_email_request, data_received),
                                    by = any_of(nn),
                                    type = list(
                                      all_dichotomous() ~ "categorical",
                                      all_continuous() ~ "continuous2")
                                    , statistic = list(
                                      source_year_published ~ c(
                                        "{min} - {max}" )
                                    )
                                    , digits = list(all_categorical() ~ c(0, 1),
                                                    all_continuous() ~ 0
                                    )
                                    , missing = "ifany" #list missing data separately #ifany #no #always
                                    ,missing_text = "Missing"
                        ) %>% 
                          modify_header(label = "**Descriptives**") %>% # update the column header
                          bold_labels() %>%
                          italicize_levels()%>%
                          add_n( statistic = "{n}", col_label = "**n**", last = FALSE, footnote = FALSE)%>% # add column with total number of non-missing observations
                          modify_caption(caption = paste0("Correctly Identified Articles", " - ", nn, " (N = {N})")) %>%
                          modify_header(all_stat_cols() ~ paste0("**", "{level}**, n = {n} ({style_percent(p)}%)"))
                      } else {
                        tbl_summary(df_quality %>%
                                      dplyr::select(source_year_published, region, study_country, type_of_study, depression, anxiety, psychosis,
                                                    availability_of_data_article, how_to_access_the_data, status_email_request, data_received),
                                    by = any_of(nn),
                                    type = list(
                                      all_dichotomous() ~ "categorical",
                                      all_continuous() ~ "continuous2")
                                    , statistic = list(
                                      source_year_published ~ c(
                                        "{min} - {max}" )
                                    )
                                    , digits = list(all_categorical() ~ c(0, 1),
                                                    all_continuous() ~ 0
                                    )
                                    , missing = "ifany" #list missing data separately #ifany #no #always
                                    ,missing_text = "Missing"
                        ) %>% 
                          modify_header(label = "**Descriptives**") %>% # update the column header
                          bold_labels() %>%
                          italicize_levels()%>%
                          add_n( statistic = "{n}", col_label = "**n**", last = FALSE, footnote = FALSE)%>% # add column with total number of non-missing observations
                          modify_caption(caption = paste0("Correctly Identified Articles", " - ", nn, " (N = {N})")) %>%
                          modify_header(all_stat_cols() ~ paste0("**", nn , " - ", "{level}**, n = {n} ({style_percent(p)}%)"))
                      }
                      
                    }, simplify = FALSE
                  )


table_4 <- sapply(c("status_email_request", "data_received"), function(x){
  
  nn <- x
  out <- tbl_summary(df_quality %>%
                       dplyr::select(source_year_published, region, study_country, type_of_study, depression, anxiety, psychosis,
                                     availability_of_data_article, how_to_access_the_data, status_email_request, data_received),
                     by = any_of(nn),
                     type = list(
                       all_dichotomous() ~ "categorical",
                       all_continuous() ~ "continuous2")
                     , statistic = list(
                       source_year_published ~ c(
                         "{min} - {max}" )
                     )
                     , digits = list(all_categorical() ~ c(0, 1),
                                     all_continuous() ~ 0
                     )
                     , missing = "ifany" #list missing data separately #ifany #no #always
                     ,missing_text = "Missing"
  ) %>% 
    modify_header(label = "**Descriptives**") %>% # update the column header
    bold_labels() %>%
    italicize_levels()%>%
    add_n( statistic = "{n}", col_label = "**n**", last = FALSE, footnote = FALSE)%>% # add column with total number of non-missing observations
    modify_caption(caption = paste0("Data Request Articles", " - ", nn, " (N = {N})")) %>%
    modify_header(all_stat_cols() ~ paste0("**", nn , " - ", "{level}**, n = {n} ({style_percent(p)}%)"))
  
}, simplify = FALSE
)

### Merge tables

table_merged1 <- tbl_merge(tbls= c(list(table_2),table_3),
                           tab_spanner = NULL) %>%
  as_flex_table()

table_merged1


table_merged2 <- tbl_merge(tbls= c(list(table_2),table_4),
                           tab_spanner = NULL) %>%
  as_flex_table()

table_merged2


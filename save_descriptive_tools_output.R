library(dplyr)
library(writexl)
library(flextable)
library(officer)

working_directory

## Saving descriptive tools output

writexl::write_xlsx(list(tools_all = df_tools_unique,
                         tools_depression = df_tools_all %>% dplyr::filter(topic == "depression"),
                         tools_anxiety = df_tools_all %>% dplyr::filter(topic == "anxiety"),
                         tools_psychosis = df_tools_all %>% dplyr::filter(topic == "psychosis"),
                         tools_all_country = df_tools_country_unique,
                         tools_depression_country = df_tools_country_all %>% dplyr::filter(topic == "depression"),
                         tools_anxiety_country = df_tools_country_all %>% dplyr::filter(topic == "anxiety"),
                         tools_psychosis_country = df_tools_country_all %>% dplyr::filter(topic == "psychosis")
                         ),
                    path = base::file.path(output_Dir, "tools_final.xlsx" )
                    )

writexl::write_xlsx(list(tools_depression = df_tools_top_n_all %>% dplyr::filter(topic == "depression"),
                         tools_anxiety = df_tools_top_n_all %>% dplyr::filter(topic == "anxiety"),
                         tools_psychosis = df_tools_top_n_all %>% dplyr::filter(topic == "psychosis"),
                         tools_depression_country = df_tools_country_top_n_all %>% dplyr::filter(topic == "depression"),
                         tools_anxiety_country = df_tools_country_top_n_all %>% dplyr::filter(topic == "anxiety"),
                         tools_psychosis_country = df_tools_country_top_n_all %>% dplyr::filter(topic == "psychosis")
                         ),
                    path = base::file.path(output_Dir, paste0("tools_top_", df_top_n$n ,"_final.xlsx") )
                    )


flextable::save_as_docx(values = table_5,
                        path = base::file.path(output_Dir, "descriptive_count_tools_stats.docx"),
                        align = "center", #left, center (default) or right.
                        pr_section = officer::prop_section(
                          page_size = officer::page_size(orient = "landscape"), #Use NULL (default value) for no content.
                          page_margins = officer::page_mar(), #Use NULL (default value) for no content.
                          type = "nextPage", # "continuous", "evenPage", "oddPage", "nextColumn", "nextPage"
                          section_columns = NULL, #Use NULL (default value) for no content.
                          header_default = NULL, #Use NULL (default value) for no content.
                          header_even = NULL, #Use NULL (default value) for no content.
                          header_first = NULL, #Use NULL (default value) for no content.
                          footer_default = NULL, #Use NULL (default value) for no content.
                          footer_even = NULL, #Use NULL (default value) for no content.
                          footer_first = NULL #Use NULL (default value) for no content.
                        )
                        )

flextable::save_as_docx(values = table_6,
                        path = base::file.path(output_Dir, "descriptive_proportion_tools_stats.docx"),
                        align = "center", #left, center (default) or right.
                        pr_section = officer::prop_section(
                          page_size = officer::page_size(orient = "landscape"), #Use NULL (default value) for no content.
                          page_margins = officer::page_mar(), #Use NULL (default value) for no content.
                          type = "nextPage", # "continuous", "evenPage", "oddPage", "nextColumn", "nextPage"
                          section_columns = NULL, #Use NULL (default value) for no content.
                          header_default = NULL, #Use NULL (default value) for no content.
                          header_even = NULL, #Use NULL (default value) for no content.
                          header_first = NULL, #Use NULL (default value) for no content.
                          footer_default = NULL, #Use NULL (default value) for no content.
                          footer_even = NULL, #Use NULL (default value) for no content.
                          footer_first = NULL #Use NULL (default value) for no content.
                        )
                        )

flextable::save_as_docx(values = table_7,
                        path = base::file.path(output_Dir, 
                                               paste0("descriptive_proportion_top_", df_top_n$n ,"_tools_stats.docx")
                                               ),
                        align = "center", #left, center (default) or right.
                        pr_section = officer::prop_section(
                          page_size = officer::page_size(orient = "landscape"), #Use NULL (default value) for no content.
                          page_margins = officer::page_mar(), #Use NULL (default value) for no content.
                          type = "nextPage", # "continuous", "evenPage", "oddPage", "nextColumn", "nextPage"
                          section_columns = NULL, #Use NULL (default value) for no content.
                          header_default = NULL, #Use NULL (default value) for no content.
                          header_even = NULL, #Use NULL (default value) for no content.
                          header_first = NULL, #Use NULL (default value) for no content.
                          footer_default = NULL, #Use NULL (default value) for no content.
                          footer_even = NULL, #Use NULL (default value) for no content.
                          footer_first = NULL #Use NULL (default value) for no content.
                        )
                        )



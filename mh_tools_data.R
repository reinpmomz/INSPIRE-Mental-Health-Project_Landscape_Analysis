library(dplyr)
library(tidyr)
library(gtsummary)

working_directory

my_gtsummary_theme

gtsummary_compact_theme

## Data - Tools

tools <- sapply(c("depression", "anxiety", "psychosis"), function(x){
  nn <- x
  df <- df_quality %>%
    tidyr::drop_na(other_tools_used) %>%
    dplyr::filter(.data[[nn]] == "Yes") %>%
    dplyr::select(other_tools_used) %>%
    mutate(split = str_split(other_tools_used, ";", simplify = FALSE))
  
  out <- tibble::tibble(tools = unlist(df$split)) %>%
    group_by(tools) %>%
    count() %>%
    ungroup() %>%
    dplyr::arrange(-n) %>%
    dplyr::mutate(topic = nn)
  
  return(out)
  
}, simplify = FALSE
)

df_tools_unique <- do.call("rbind", tools) %>%
  dplyr::select(tools) %>%
  dplyr::distinct(tools)

df_tools_all <- do.call("rbind", tools) %>%
  dplyr::left_join(df_mh_tools %>% 
                     dplyr::filter(tools != "other") %>%
                     dplyr::mutate(correct = "yes"),
                   by = c("tools", "topic")
                   ) %>%
  tidyr::drop_na(correct) %>%
  dplyr::select(-correct)

## Data - Top n Tools

tools_top_n <- sapply(unique(df_tools_all$topic), function(x){
  nn <- x
  
  top_n_tools <- df_top_n %>%
    dplyr::pull(n)
  
  top <- df_tools_all %>% 
    dplyr::filter(topic == nn) %>%
    dplyr::slice_max(n, n=top_n_tools, with_ties = FALSE) %>% 
    dplyr::pull(tools)
  
  df_top <- df_tools_all %>%
    dplyr::filter(topic == nn) %>%
    dplyr::mutate(tools_new = if_else(tools %in% top, tools, "others")) %>%
    dplyr::group_by(tools_new, topic) %>%
    dplyr::summarise(n = sum(n), .groups = "drop")
  
  return(df_top)

}, simplify = FALSE
)

df_tools_top_n_all <- do.call("rbind", tools_top_n)  

## Data- Tools by Country

tools_country <- sapply(c("depression", "anxiety", "psychosis"), function(x){
  nn <- x
  df <- df_quality %>%
    tidyr::drop_na(other_tools_used) %>%
    dplyr::filter(.data[[nn]] == "Yes")
  
  country <- sapply(unique(df$study_country), function(y){
    
    df_new <- df %>%
      dplyr::filter(study_country == y) %>%
      dplyr::select(other_tools_used) %>%
      mutate(split = str_split(other_tools_used, ";", simplify = FALSE))
    
    out <- tibble::tibble(tools = unlist(df_new$split)) %>%
      group_by(tools) %>%
      count() %>%
      ungroup() %>%
      dplyr::arrange(-n) %>%
      dplyr::mutate(topic = nn,
                    study_country = y)
    
    return(out)
  
  }, simplify = FALSE
  )
  
  out_ <- do.call("rbind", country)
  
}, simplify = FALSE
)

df_tools_country_unique <- do.call("rbind", tools_country) %>% 
  dplyr::select(tools, study_country) %>%
  dplyr::distinct(tools, study_country)

df_tools_country_all <- do.call("rbind", tools_country) %>%
  dplyr::left_join(df_mh_tools %>% 
                     dplyr::filter(tools != "other") %>%
                     dplyr::mutate(correct = "yes"),
                   by = c("tools", "topic")
                   ) %>%
  tidyr::drop_na(correct) %>%
  dplyr::select(-correct)


## Data - Top n Tools by country

tools_country_top_n <- sapply(unique(df_tools_country_all$topic), function(x){
  nn <- x
  
  top_n_tools <- df_top_n %>%
    dplyr::pull(n)
  
  top <- df_tools_all %>% 
    dplyr::filter(topic == nn) %>%
    dplyr::slice_max(n, n=top_n_tools, with_ties = FALSE) %>% 
    dplyr::pull(tools)
  
  df_top <- df_tools_all %>%
    dplyr::filter(topic == nn) %>%
    dplyr::mutate(tools_new = if_else(tools %in% top, tools, "others"))
  
  df_top_country <- df_tools_country_all %>%
    dplyr::filter(topic == nn) %>%
    dplyr::left_join(df_top %>%
                       dplyr::select(tools, topic, tools_new),
                     by = c("tools", "topic")) %>%
    dplyr::group_by(study_country, tools_new, topic) %>%
    dplyr::summarise(n = sum(n), .groups = "drop")
  
  return(df_top_country)
  
}, simplify = FALSE
)

df_tools_country_top_n_all <- do.call("rbind", tools_country_top_n)


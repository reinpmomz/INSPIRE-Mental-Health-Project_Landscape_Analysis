library(dplyr)
library(httr)
library(jsonlite)


working_directory

## DOI retrival function
get_doi <- function(reference) {
  query <- paste0("https://api.crossref.org/works?query=", URLencode(reference))
  response <- httr::RETRY("GET", query)
  data <- fromJSON(content(response, as = "text", encoding = "UTF-8"))
  doi <- if (is.null(data$message$items)) {
    NA
  } else {
    paste0("https://doi.org/",data$message$items$DOI[1])
    
  }
  doi
}

df_doi <- df_inclusion_longitudinal %>%
  dplyr::select(source_title, source_year_published, source_source_publisher, source_source_title) %>%
  mutate(search_terms = paste(source_title, source_year_published, source_source_publisher))

doi <- list()

for (i in seq(length(df_doi$search_terms))){
  doi[i] <- get_doi(reference = paste(df_doi$search_terms)[i])
  
  print(doi[i])
}

df_inclusion_longitudinal$link_doi <- as.data.frame(do.call(rbind, doi))$V1


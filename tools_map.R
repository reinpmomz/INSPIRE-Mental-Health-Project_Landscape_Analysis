library(dplyr)
library(giscoR)

working_directory

ggtheme_sf_plot()

## Africa Map - Tools

africa_map_valid <- giscoR::gisco_get_countries(
  year = "2016",
  epsg = "4326", #WGS84
  region = "Africa"
  ) %>%
  dplyr::filter(ISO3_CODE %in% africa_map$iso_a3) #Somaliland not in gisco map


print(st_is_valid(africa_map_valid)) #st for all countries are valid

tools_map <- sapply(c("depression", "anxiety", "psychosis"), function(x){
  set.seed(435)
  
  nn <- x
  
  bbox_list <- lapply(st_geometry(africa_map_valid), st_bbox 
  ) #Get geometry from sf object and Return bounding of a simple feature 
  
  #row wise bind bounding coordinates list
  maxmin <- as.data.frame(do.call("rbind", bbox_list)) %>%
    dplyr::mutate(geo_unit = africa_map_valid$NAME_ENGL)
  
  #joining tools country data frame with bounding coordinates then generating random x and y co-ordinates
  #for each tool used in a country
  df <- df_tools_country_top_n_all %>%
    dplyr::filter(topic == nn) %>%
    dplyr::mutate(study_country2 = study_country,
                  tools_new = factor(tools_new)
                  )
  
  map_df <- africa_map_valid %>%
    dplyr::mutate(NAME_ENGL = if_else(NAME_ENGL == "United Republic of Tanzania", CNTR_NAME , NAME_ENGL )) %>%
    dplyr::left_join(df,
                     by = c("NAME_ENGL" = "study_country")
                     )
  
  ## Create sample points in each polygon for each tool used in a country
  map_df_sample <- st_sample(map_df, rep(1, nrow(map_df)))
  
  map_df_sample_final <- as.data.frame(do.call("rbind", map_df_sample)) %>%
    dplyr::rename(xrand = V1, yrand = V2)
  
  map_df_final <- dplyr::bind_cols(map_df, map_df_sample_final) %>%
    dplyr::mutate(across(c(xrand, yrand), ~if_else(is.na(tools_new), NA, .x))
                  )
  
  plot <- ggplot(data = map_df_final) +
    geom_sf(aes(size= paste0("No ", nn, " Articles")) , fill = "grey") +
    geom_sf(aes(fill = study_country2), show.legend = FALSE) +
    geom_point(aes(x=xrand, y=yrand, colour=n, shape = tools_new), size = 2.5)+
    geom_sf_text(aes(label = study_country2), size = 2.5, colour = "black", fontface = "bold"
                 ) +
    scale_colour_viridis_c(option = "C") +
    scale_size_manual(name="",
                      breaks=c(paste0("No ", nn, " Articles")),
                      values = NA
                      ) +
    scale_fill_discrete(na.translate=FALSE) +
    scale_shape_manual(na.translate=FALSE,
                       values = c(16, 17, 15, 3, 7, 8, 13, 9, 18, 11, 4)
                       ) +
    labs(title = "", x = "", y = "", colour = "Frequency", shape = "Tools")+
    guides(size=guide_legend("", override.aes=list( colour = "grey", fill = "grey"))
           )

}, simplify = FALSE
)

print(tools_map)  

## Saving the tools map plots
for (j in seq(length(tools_map))) {
  ggsave(plot=tools_map[[j]], height = 7, width = 11,
         filename = paste0("tools_plot_",names(tools_map)[j],".png"),
         path = output_Dir, bg='white'
         )  
}



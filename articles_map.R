library(dplyr)
library(rnaturalearth)
library(rnaturalearthdata)
library(sf)

working_directory

ggtheme_sf_plot()

## Africa Map - Articles

africa_map <- rnaturalearth::ne_countries(scale = 110, returnclass = "sf", continent = "africa") 

print(st_is_valid(africa_map)) #st valid for Sudan is false

articles_map <- sapply(c("depression", "anxiety", "psychosis"), function(x){
  nn <- x
  df <- df_quality %>%
    dplyr::filter(.data[[nn]] == "Yes") %>%
    dplyr::group_by(study_country) %>%
    count() %>%
    ungroup() %>%
    dplyr::mutate(study_country2 = study_country)
  
  map_df <- africa_map %>%
    dplyr::left_join(df,
                     by = c("geounit" = "study_country")
                     )
  
  plot <- ggplot(data = map_df) +
    geom_sf(aes(colour= paste0("No ", nn, " Articles")) , fill = "grey") +
    geom_sf(aes(fill = study_country2), show.legend = FALSE) +
    geom_sf_text(aes(label = study_country2), size = 2.5, colour = "black", 
                 nudge_x = 0, nudge_y = -1.5, fontface = "bold"
                 ) +
    stat_sf_coordinates(aes(size = n), colour = "black") +
    scale_colour_manual(name="",
                        breaks=c(paste0("No ", nn, " Articles")),
                        values = NA
                        )+
    scale_fill_discrete(na.translate=FALSE) + 
    labs(title = "", x = "", y = "", size = "No. of Articles", fill = "Countries") +
    guides(colour=guide_legend("", override.aes=list( colour = "grey", fill = "grey"))
           ) 
  
}, simplify = FALSE
)

print(articles_map)  

## Saving the articles map plots
for (j in seq(length(articles_map))) {
  ggsave(plot=articles_map[[j]], height = 6, width = 7,
         filename = paste0("articles_plot_",names(articles_map)[j],".png"),
         path = output_Dir, bg='white')  
}


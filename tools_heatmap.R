library(dplyr)
library(forcats)
library(ggplot2)

working_directory

ggtheme_heat_plot()

## Africa Heat Map - Tools

tools_heatmap <- sapply(c("depression", "anxiety", "psychosis"), function(x){
  nn <- x
  heatmap_low = "turquoise4"
  heatmap_mid = "cornsilk1"
  heatmap_high = "brown3"
  heatmap_gap_colour = "white"
  
  tools_ordering = df_tools_all %>%
    dplyr::filter(topic == nn) %>% 
    dplyr::arrange(n) %>%
    dplyr::pull(tools)
  
  heatmap_df <- df_tools_country_all %>%
    dplyr::filter(topic == nn) %>%
    dplyr::group_by(study_country) %>%
    dplyr::mutate( total = n(),
            tools = factor(tools, levels=tools_ordering)
            ) %>%
    dplyr::ungroup()
  
  plot <- ggplot(heatmap_df, aes(x=reorder(study_country,-total), y=tools, fill=n)) + 
    geom_raster() +
    scale_fill_gradient2(low=heatmap_low, mid=heatmap_mid, high=heatmap_high, na.value = heatmap_gap_colour) + 
    scale_x_discrete(expand = c(0, 0)) + 
    scale_y_discrete(expand=c(0,0)
                     ,labels = function(x) stringr::str_wrap(x, width = 80)
                     ) +
    labs(fill = "", x=NULL, y=NULL)
  
}, simplify = FALSE
)

print(tools_heatmap)  

## Saving the tools heat map plots
for (j in seq(length(tools_heatmap))) {
  ggsave(plot=tools_heatmap[[j]], height = 8.5, width = 13.5,
         filename = paste0("tools_heatmap_plot_",names(tools_heatmap)[j],".png"),
         path = output_Dir, bg='white'
         )  
}


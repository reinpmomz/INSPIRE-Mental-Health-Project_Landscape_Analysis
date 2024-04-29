library(dplyr)
library(readxl)
library(gtsummary)
library(flextable)

working_directory

## read all sheets in excel file
read_excel_allsheets <- function(filename) {
  sheets <- readxl::excel_sheets(filename) #List all sheets in an excel spreadsheet
  out <- base::lapply(sheets, function(x) {
    readxl::read_excel(filename, sheet = x)
  }
  )
  base::names(out) <- sheets
  out
}

## Setting gt summary theme
my_gtsummary_theme <- gtsummary::set_gtsummary_theme(
  list(
    ## round large p-values to three places
    #"pkgwide-fn:pvalue_fun" = function(x) gtsummary::style_pvalue(x, digits = 3),
    ## report mean (sd) and n (percent) as default stats in `tbl_summary()`
    #"tbl_summary-fn:percent_fun" = function(x) gtsummary::style_percent(x, digits = 1), 
    ## less than 10% are rounded to digits + 1 places
    #"tbl_summary-str:continuous_stat" = "{mean} ({sd})",
    "style_number-arg:big.mark" = "",
    "tbl_summary-str:categorical_stat" = "{n} ({p}%)" #"{n} / {N} ({p}%)"
  )
)

### Setting `Compact` theme
gtsummary_compact_theme <- gtsummary::theme_gtsummary_compact()

### ggplot themes
ggtheme_sf_plot <- function(){
  theme_set(#theme_minimal() +
              theme(
                rect = element_blank(),
                #plot.background = element_blank(),
                #panel.background = element_rect(fill = "white"),
                #legend.position="bottom",
                #legend.text = element_text(size = 8),
                #legend.title = element_text(size = 8, color = "red", face = "bold", hjust = 0.5),
                #axis.line.y = element_line(colour = "grey",inherit.blank = FALSE),
                #axis.line.x = element_line(colour = "grey",inherit.blank = FALSE),
                axis.ticks.y = element_blank(),
                axis.ticks.x = element_blank(),
                axis.text.y = element_blank(),
                axis.text.x = element_blank(),
                plot.title = element_text(hjust = 0.5, face = "bold", size = 10),
                plot.caption = element_text(angle = 0, size = 10, face = "italic"),
                axis.title.x = element_text(size = 10, face = "bold"),
                axis.title.y = element_text(size = 10, face = "bold"),
                panel.grid.major.y = element_blank(),
                panel.grid.major.x = element_blank(),
                panel.grid.minor.x = element_blank(),
                panel.grid.minor.y = element_blank(),
              )
  )
}


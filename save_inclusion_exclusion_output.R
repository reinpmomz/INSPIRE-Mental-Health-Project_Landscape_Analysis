library(dplyr)
library(writexl)

working_directory

## Saving inclusion exclusion Output

writexl::write_xlsx(list(criteria = criteria[, c("criteria_words", "category")],
                         study = study[, c("study_words", "type")],
                         inclusion = df_inclusion,
                         exclusion = df_exclusion,
                         exclusion_random = df_exclusion_random,
                         inclusion_random = df_inclusion_random, 
                         inclusion_longitudinal = df_inclusion_longitudinal,
                         inclusion_reviews_longitudinal = df_inclusion_reviews_longitudinal,
                         inclusion_longitudinal_depression = df_inclusion_longitudinal_depression,
                         inclusion_longitudinal_anxiety = df_inclusion_longitudinal_anxiety,
                         inclusion_longitudinal_psychosis = df_inclusion_longitudinal_psychosis,
                         inclusion_crosssectional = df_inclusion_cross_sectional
                         ),
                    path = base::file.path(output_Dir, "mental_health_publications_inclusion_exclusion_final.xlsx" )
                    )



library(dplyr)
library(DiagrammeR)
library(DiagrammeRsvg)
library(rsvg)

working_directory

## creating the flowchart

data_list <- list( a = df,
                   b = df_missing,
                   c = df_distinct,
                   d = df_africa,
                   e = df_inclusion ,
                   f = df_inclusion_control_trials,
                   g = df_inclusion_cross_sectional,
                   h = df_inclusion_longitudinal,
                   i = df_inclusion_reviews,
                   j = df_quality,
                   k = df_quality_request,
                   l = df_quality_no_request,
                   p = df_inclusion_reviews_longitudinal
)

data <- list(nrow_list = lapply(data_list, function(x) nrow(x)),
             oldest = sapply(names(data_list), function(x) min(data_list[[x]]$source_year_published, na.rm = TRUE),
                             simplify = FALSE),
             newest = sapply(names(data_list), function(x) max(data_list[[x]]$source_year_published, na.rm = TRUE),
                             simplify = FALSE)
)

g1 <- DiagrammeR::grViz("
digraph graph2 {

graph [layout = dot]

# node definitions
node [shape = rectangle, width = 6, fillcolor = Linen, fontsize=22]

data1 [label = 'I-DAIR GRM Data Map', fillcolor = Beige]
a [label = '@@1']
b [label = '@@2']
c [label = '@@3']
d [label = '@@4']

compound=true;
subgraph cluster_filter {
node [shape=box];
label = 'Filter Data set';
 fontsize=20;
        fontname = 'helvetica-bold';
style=dashed;
{{ rank = same; filterby1 filterby2}}
  
filterby1 [label = 'Filter Title by\n Psychosis(es) or Psychotic or Bipolar or\n Schizophrenia or Antidepressant or\n Depression 
or Depressive or Depressed\n or Anxiety or Phobia or Panic Disorder or\n Mental Health Disorder(s) or\n Mental 
Disorder(s) or Mental Problem(s)\n or Mental Health Problem(s)\n or Mental illness or Mental Health illness\n or Mental 
Health Conditions\n or Mental Health or Psychiatric illness\n or Psychiatric Disorder(s)\n or Psychiatric Conditions', width = 6,
fontsize=22]
filterby2 [label = 'Filter Field of Study by\n Psychosis(es) or Psychotic or Bipolar or\n Schizophrenia or Antidepressant or\n Depression
or Depressive or Depressed\n or Anxiety or Phobia or Panic Disorder or\n Mental Health Disorder(s) or\n Mental 
Disorder(s) or Mental Problem(s)\n or Mental Health Problem(s)\n or Mental illness or Mental Health illness\n or Mental Health 
Conditions\n or Mental Health or Psychiatric illness\n or Psychiatric Disorder(s)\n or Psychiatric Conditions', width = 6, 
fontsize=22]
}

e [label = '@@5', shape = rectangle, width = 6]
f [label = '@@6', width = 5.5, shape=box]
g [label = '@@7', width = 5.5, shape=box]
h [label = '@@8', width = 5.5, shape=box]
i [label = '@@9', width = 5.5, shape=box]
j [label = '@@10', width = 5.5, shape=box]
k [label = '@@11', width = 5.5, shape=box]
l [label = '@@12', width = 5.5, shape=box]

p [label = '@@13', width = 5.5, shape=plaintext, fontname = 'helvetica-bold', fontsize=19]

# edge definitions with the node IDs

data1 -> a -> b -> c -> d

d -> filterby2 [lhead = cluster_filter]

filterby1 -> filterby2 [style = dashed, minlen=1.5, label = 'or', dir=both, fontsize=22 ]

filterby2 -> e [ltail = cluster_filter]

e -> {h, i}[minlen=2]

f -> e[minlen=2, dir=back];
{{ rank = same; f e }}
  
e -> g[minlen=2];
{{ rank = same; e g }}
  
h -> i[minlen=2, dir=back, style = dashed, label = '@@14', fontsize=22];
  {{ rank = same; h i }}

h -> j[minlen=2]

j -> k[minlen=2];
{{ rank = same; j k }}

l -> j[minlen=2, dir=back];
{{ rank = same; l j }}

i -> p[style=invis];
  {{ rank = same; i p }}

}

[1]: paste0('Extracted African Authors List (n = ', data$nrow_list$a, ')', '\\n', '\\n', '(oldest=', data$oldest$a, ', newest=', data$newest$a, ')')
[2]: paste0('Remove Missing Titles (n = ', data$nrow_list$b, ')', '\\n' , '\\n', '(oldest=', data$oldest$b, ', newest=', data$newest$b, ')')
[3]: paste0('Remove Dupliates on Title (n = ', data$nrow_list$c, ')', '\\n' , '\\n', '(oldest=', data$oldest$c, ', newest=', data$newest$c, ')')
[4]: paste0('Remove Non-African Papers (n = ', data$nrow_list$d, ')', '\\n' , '\\n', '(oldest=', data$oldest$d, ', newest=', data$newest$d, ')')
[5]: paste0('Inclusion papers (n = ', data$nrow_list$e, ')', '\\n' , '\\n', '(oldest=', data$oldest$e, ', newest=', data$newest$e, ')')
[6]: paste0('Control Trials (n = ', data$nrow_list$f, ')', '\\n' , '\\n', '(oldest=', data$oldest$f, ', newest=', data$newest$f, ')')
[7]: paste0('Cross-Sectional  (n = ', data$nrow_list$g, ')', '\\n' , '\\n', '(oldest=', data$oldest$g, ', newest=', data$newest$g, ')')
[8]: paste0('Longitudinal  (n = ', data$nrow_list$h, ')', '\\n' , '\\n', '\\n', '(oldest=', data$oldest$h, ', newest=', data$newest$h, ')')
[9]: paste0('Reviews(Systemic & Literature)/\\n Meta Analysis/Case Reports (n = ', data$nrow_list$i, ')' , '\\n', '\\n', '(oldest=', data$oldest$i, ', newest=', data$newest$i, ')')
[10]: paste0('Quality Assessment (n = ', data$nrow_list$j, ')' , '\\n', '\\n', '(oldest=', data$oldest$j, ', newest=', data$newest$j, ')')
[11]: paste0('Data availability statement (n = ', data$nrow_list$k, ')' , '\\n', '\\n', '(oldest=', data$oldest$k, ', newest=', data$newest$k, ')')
[12]: paste0('No data availability statement (n = ', data$nrow_list$l, ')' , '\\n', '\\n', '(oldest=', data$oldest$l, ', newest=', data$newest$l, ')')
[13]: paste0(data$nrow_list$p, ' - Excluded in Reviews(Systemic &\\n Literature)/Meta Analysis/Case Reports\\n and included in Longitudinal')
[14]: paste0(data$nrow_list$p)

")

g1

##saving flowchart as png

g1 %>%
  export_svg %>% charToRaw %>% rsvg_png(file = base::file.path(output_Dir, "landscape_flowchart.png" ))


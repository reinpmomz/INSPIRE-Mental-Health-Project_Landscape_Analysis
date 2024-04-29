library(dplyr)

working_directory

## Set seed for reproducibility
set.seed(1111)

## Select 10 random numbers 50 times
nreps = 50
nsamples = 10

### Resample function
resamplefun <- function(df, nsamples) {
  title_df <- dplyr::slice_sample(df, n = nsamples, replace = FALSE)
  return(title_df)
}

repfun <- function(df, nreps, nsamples) {
  out <- sapply(1:nreps, function(x){
    out <- resamplefun(df, nsamples)
    out$draw <- x
    return(out)
  }, simplify = FALSE)
  out <- do.call("rbind", out)
  return(out)
}

df_inclusion_random <- repfun(df_inclusion, nreps, nsamples)

df_exclusion_random <- repfun(df_exclusion, nreps, nsamples)


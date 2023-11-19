# rank aic and bic
model_rank = function(x) {
  y = x %>% mutate(rank_aic = rank(AIC),
                   rank_bic = rank(BIC)) %>% as.data.frame()
  y = y %>% mutate(AIC = paste0(AIC, '(', rank_aic, ')'),
                   BIC = paste0(BIC, '(', rank_bic, ')')) %>%
    dplyr::select(-rank_aic,-rank_bic)
  names(y) = c('Model', "-2 log L", 'AIC(rank)', 'BIC(rank)')
  # return(y)
  # return(assign(paste('model_rank', deparse(
  #   substitute(x)
  # ), sep = "_"), y, envir = .GlobalEnv))
  return(y)
}

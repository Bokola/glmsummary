model_print = function(model) {
  if (!grepl("gee", deparse(substitute(model)))) {
    x <- model %>%
      mutate(., estimate = paste0(estimate, "(",
                                  se, ")", " ", `signif code`), )
  } else {
    x <- model %>%
      mutate(., estimate = paste0(estimate, "(",
                                  se, ")"))

  }

  x <- x %>%
    dplyr::select(variable, estimate)
  return(x)
}

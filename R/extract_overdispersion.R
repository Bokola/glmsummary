extract_overdispersion = function(model) {
  y <- tibble(variable = "overdispersion", estimate = "None")
  y <- y %>%
    mutate(., estimate = !!paste0("param", "=",
                                  round(working_corr(model), 4)))
  return(y)
}

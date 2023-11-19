extract_aic_bic <- function(model,
                           model_name) {
  aic_bic <- tibble(
    Model = c(model_name),
    `-2 log L` = -2 * stats::logLik(model),
    AIC = round(VGLM::AICvlm(model), 2),
    BIC = round(VGLM::BICvlm(model), 2)
  )

  return(aic_bic)
}

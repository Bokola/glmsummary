#' Extract AIC, BIC and -2loglik of a glm/glmm model
#'
#' @param model model object
#'  you wish to extract its AIC, BIC
#'
#' @return a data frame
#' @export
#'
#' @examples
#' \dontrun{
#' extract_aic_bic()
#' }
extract_aic_bic <- function(model) {
  aic_bic <- tibble::tibble(
    `-2 log L` = -2 * stats::logLik(model),
    AIC = round(VGAM::AICvlm(model), 2),
    BIC = round(VGAM::BICvlm(model), 2)
  )

  return(aic_bic)
}


#' Rank a data frame of models with respective AIC, BIC values
#'
#' @param x a data frame of model AIC, BIC, assumed to have many models to compare
#'
#' @return a ranked data frame of the models in terms of AIC, BIC
#' @export
#'
#' @examples
#' \dontrun{
#' model_rank()
#' }
model_rank <- function(x) {
  rank_aic <- rank_bic <- NULL # bind the global variables
  y <- x |> (\(.){dplyr::mutate(rank_aic = rank(AIC),
                   rank_bic = rank(BIC))})() |> as.data.frame()
  y <- y |> (\(.){dplyr::mutate(AIC = paste0(AIC, '(', rank_aic, ')'),
                   BIC = paste0(BIC, '(', rank_bic, ')'))})() |>
    dplyr::select(-rank_aic,-rank_bic)
  names(y) <- c('Model', "-2 log L", 'AIC(rank)', 'BIC(rank)')
  # return(y)
  # return(assign(paste('model_rank', deparse(
  #   substitute(x)
  # ), sep = "_"), y, envir = .GlobalEnv))
  return(y)
}

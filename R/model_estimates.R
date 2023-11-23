

# extract coefficients

#' Get model estimates, standard error and p-values
#'
#' @param model an R object of the model
#'
#' @return a data frame of model coefficients, standard error and p-value
#' @export
#'
#' @examples
#' \dontrun{
#' model_estimates()
#' }
model_estimates <- function(model) {
  `p value` <- . <- NULL
  options(digits = 4)
  if (class(model)[1] %in% c("glm", "lm",
                             "LORgee")) {
    coefs <- coefficients(summary(model)) |>
      as.data.frame()
    coefs <- tibble::rownames_to_column(coefs)
    coefs <- coefs |>
      `colnames<-`(c("variable", "estimate", "se",
                     "z value", "p value"))
    coefs <- coefs |>
      dplyr::mutate(., `significance code` = ifelse(
        `p value` <
          0.001,
        "***",
        ifelse(`p value` < 0.01,
               "**", ifelse(`p value` < 0.05, "*",
                            ""))
      ))
    # coefs = coefs |> dplyr::mutate(., estimate =
    # paste0(estimate, ' (', se,')'), `p
    # value` = paste0(`p value`, ' ', `significance
    # code`)) coefs = coefs |>
    # dplyr::select(-se, - `significance code`)
    coefs <- coefs |>
      dplyr::mutate(dplyr::across(dplyr::where(is.numeric), round,
                    4))
  }
  if (class(model)[1] %in% c("gee")) {
    coefs <- coefficients(summary(model)) |>
      as.data.frame() |>
      tibble::rownames_to_column() |>
      dplyr::select(!!c(1:2, 6)) |>
      `colnames<-`(c("variable", "estimate", "se"))
    coefs <- coefs |>
      dplyr::mutate(dplyr::across(dplyr::where(is.numeric), round,
                    4))
  }

  return(coefs)
}

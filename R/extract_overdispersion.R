#' Extract overdispersion parameter for a glm/glmm model
#'
#' @param model a glm/glmm model object
#'
#' @return a data frame
#' @export
#'
#' @examples
#' \dontrun{
#' extract_overdispersion()
#' }
extract_overdispersion = function(model) {
  y <- tibble::tibble(variable = "overdispersion parameter", estimate = "None")
  y <- y |>
    (\(.){dplyr::mutate(., estimate = round(working_corr(model), 4))})()
  return(y)
}

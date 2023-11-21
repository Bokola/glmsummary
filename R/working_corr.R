#' Get working correlation of a gee/glmm model
#'
#' @param model a gee/glmm model object
#'
#' @return a vector
#' @export
#'
#' @examples
#' \dontrun{
#' working_corr()
#' }
working_corr = function(model) {
  if (class(model)[1] %in% 'gee'){
    y <- summary(model)$working.correlation[1,2]

  }

  if (class(model)[1] %in% "glimML"){
    y <- summary(model)@Phi[1,1]

  }
  return(y)
}

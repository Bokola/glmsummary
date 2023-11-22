#' Check for availability of required packages, install and load
#'
#' @param pkg a character vector of packages you wish to install
#'
#' @return NULL
#' @export
#'
#' @examples
#' \dontrun{
#' install_load_packages()
#' }
install_load_packages <- function(pkg){
  for (i in seq(pkg)){
    if (!require(pkg[[i]], character.only = TRUE)) install.packages(
      pkg[[i]], dependencies = TRUE, repos = "https://cran.rstudio.org"
    )
  }
  require(pkg[[i]], character.only = TRUE)
}

install_load_packages <- function(pkg){
  for (i in seq(pkg)){
    if (!require(pkg[[i]], character.only = TRUE)) install.packages(
      pkg[[i]], dependencies = TRUE, repos = "https://cran.rstudio.org"
    )
  }
  require(pkg[[i]], character.only = TRUE)
}

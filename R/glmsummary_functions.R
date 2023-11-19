
# install and load packages

install_load_packages <- function(pkg){
  for (i in seq(pkg)){
    if (!require(pkg[[i]], character.only = TRUE)) install.packages(
      pkg[[i]], dependencies = TRUE, repos = "https://cran.rstudio.org"
    )
  }
  require(pkg[[i]], character.only = TRUE)
}

# pks <- c(
#   "devtools", "roxygen2", "knitr", "testthat", "pkgdown"
# )
#
# install_load_packages(pks)

# extract coefsficients

model_estimates <- function(model){
    options(digits = 4)
    if (class(model)[1] %in% c("glm", "lm", "vglm",
        "LORgee")) {
        coefs <- coefs(summary(model)) %>%
            as.data.frame() %>%
           dplyr::add_rownames()
        coefs <- coefs %>%
            `colnames<-`(c("variable", "estimate", "se",
                "z value", "p value"))
        coefs <- coefs %>%
            mutate(., `signif code` = ifelse(`p value` <
                0.001, "***", ifelse(`p value` < 0.01,
                "**", ifelse(`p value` < 0.05, "*",
                  ""))))
        # coefs = coefs %>% mutate(., estimate =
        # paste0(estimate, ' (', se,')'), `p
        # value` = paste0(`p value`, ' ', `signif
        # code`)) coefs = coefs %>%
        # dplyr::select(-se, - `signif code`)
        coefs <- coefs %>%
            mutate(across(where(is.numeric), round,
                4))
    }
    if (class(model)[1] %in% c("glimML")) {
        coefs <- summary(model)@coefs %>%
            as.data.frame() %>%
           dplyr::add_rownames()
        coefs <- coefs %>%
            `colnames<-`(c("variable", "estimate", "se",
                "z value", "p value"))
        coefs <- coefs %>%
            mutate(., `signif code` = ifelse(`p value` <
                0.001, "***", ifelse(`p value` < 0.01,
                "**", ifelse(`p value` < 0.05, "*",
                  ""))))
        # coefs = coefs %>% mutate(., estimate =
        # paste0(estimate, ' (', se,')'), `p
        # value` = paste0(`p value`, ' ', `signif
        # code`)) coefs = coefs %>%
        # dplyr::select(-se, - `signif code`)
        coefs <- coefs %>%
            mutate(across(where(is.numeric), round,
                4))
    }


    if (class(model)[1] %in% c("gee")) {
        coefs <- coefs(summary(model)) %>%
            as.data.frame() %>%
           dplyr::add_rownames() %>%
            dplyr::select(!!c(1:2, 6)) %>%
            `colnames<-`(c("variable", "estimate", "se"))
        coefs <- coefs %>%
            mutate(across(where(is.numeric), round,
                4))
    }

  return(coefs)
}

# get working correlation for gee models
working_corr <- function(model) {
  if (class(model)[1] %in% "gee") {
    y <- summary(model)$working.correlation[1, 2]

  }

  if (class(model)[1] %in% "glimML") {
    y <- summary(model)@Phi[1, 1]

  }
  return(y)
}


# modify output

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
  return(assign(paste("print", deparse(substitute(model)),
                      sep = "_"), x, envir = .GlobalEnv))
}

# overdispersion

extract_overdispersion = function(model) {
  y <- tibble(variable = "overdispersion", estimate = "None")
  y <- y %>%
    mutate(., estimate = !!paste0("param", "=",
                                  round(working_corr(model), 4)))
  return(y)
}

# function for aic and bic extraction
extract_aic_bic = function(model,
                           model_name) {
  aic_bic = tibble(
    Model = c(model_name),
    `-2 log L` = -2 * logLik(model),
    AIC = round(AICvlm(model), 2),
    BIC = round(BICvlm(model), 2)
  )

  return(aic_bic)
}


# rank aic and bic
model_rank = function(x) {
  y = x %>% mutate(rank_aic = rank(AIC),
                   rank_bic = rank(BIC)) %>% as.data.frame()
  y = y %>% mutate(AIC = paste0(AIC, '(', rank_aic, ')'),
                   BIC = paste0(BIC, '(', rank_bic, ')')) %>%
    dplyr::select(-rank_aic,-rank_bic)
  names(y) = c('Model', "-2 log L", 'AIC(rank)', 'BIC(rank)')
  # return(y)
  # return(assign(paste('model_rank', deparse(
  #   substitute(x)
  # ), sep = "_"), y, envir = .GlobalEnv))
  return(y)
}

# bin_fit = glm(ord_binary ~ dose + weight + litsz + dose2, data = dyme)
# model_estimates(bin_fit)
# model_print(coef_bin_fit)




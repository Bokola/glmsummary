
# extract coefficients

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

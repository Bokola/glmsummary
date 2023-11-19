# x <- rep(0:1, c(10, 20))
# class(x)
#
# # defining a new class
# myx <- x
# class(myx) <- "myvector"
#
# # Generic functions in S3 take a look at the class of their first argument and do method dispatch
# # based on a naming convention: foo() methods for objects of class "bar" are called foo.bar()
#
# print.myvector <- function(x, ...){
#   cat("This is my vector\n")
#   cat(paste(x[1:15]), "...\n")
# }
#
# myx
#
#
#
# # add later ---------------------------------------------------------------
#
# # get working correlation for gee models
# working_corr <- function(model) {
#   if (class(model)[1] %in% "gee") {
#     y <- summary(model)$working.correlation[1, 2]
#
#   }
#
#   if (class(model)[1] %in% "glimML") {
#     y <- summary(model)@Phi[1, 1]
#
#   }
#   return(y)
# }
#
#
# # modify output
#
# model_print = function(model) {
#   if (!grepl("gee", deparse(substitute(model)))) {
#     x <- model %>%
#       mutate(., estimate = paste0(estimate, "(",
#                                   se, ")", " ", `signif code`), )
#   } else {
#     x <- model %>%
#       mutate(., estimate = paste0(estimate, "(",
#                                   se, ")"))
#
#   }
#
#   x <- x %>%
#     dplyr::select(variable, estimate)
#   return(assign(paste("print", deparse(substitute(model)),
#                       sep = "_"), x, envir = .GlobalEnv))
# }
#
# # overdispersion
#
# extract_overdispersion = function(model) {
#   y <- tibble(variable = "overdispersion", estimate = "None")
#   y <- y %>%
#     mutate(., estimate = !!paste0("param", "=",
#                                   round(working_corr(model), 4)))
#   return(y)
# }
#
# # function for aic and bic extraction
# extract_aic_bic = function(model,
#                            model_name) {
#   aic_bic = tibble(
#     Model = c(model_name),
#     `-2 log L` = -2 * logLik(model),
#     AIC = round(AICvlm(model), 2),
#     BIC = round(BICvlm(model), 2)
#   )
#
#   return(aic_bic)
# }
#
#
# # rank aic and bic
# model_rank = function(x) {
#   y = x %>% mutate(rank_aic = rank(AIC),
#                    rank_bic = rank(BIC)) %>% as.data.frame()
#   y = y %>% mutate(AIC = paste0(AIC, '(', rank_aic, ')'),
#                    BIC = paste0(BIC, '(', rank_bic, ')')) %>%
#     dplyr::select(-rank_aic,-rank_bic)
#   names(y) = c('Model', "-2 log L", 'AIC(rank)', 'BIC(rank)')
#   # return(y)
#   # return(assign(paste('model_rank', deparse(
#   #   substitute(x)
#   # ), sep = "_"), y, envir = .GlobalEnv))
#   return(y)
# }

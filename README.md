
<!-- README.md is generated from README.Rmd. Please edit that file -->

# glmsummary

<!-- badges: start -->

[![R-CMD-check](https://github.com/Bokola/glmsummary/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Bokola/glmsummary/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of glmsummary is to make it easy extracting model coefficients
from generalized linear models and generalized linear mixed models in a
tabular output that you can then format appropriately per your
publication needs.

## Installation

You can install the development version of glmsummary from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Bokola/glmsummary")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(glmsummary)
required_pks <- c("gee")
suppressWarnings(install_load_packages(required_pks))
#> Loading required package: gee
## basic example code

df <- glmsummary::df
# general estimating equations (independent correlation structure)
mfit_1 = gee(ord_binary ~ dose + weight + litsz + dose2, family = binomial(link = 'logit'),
id = id, corstr = 'independence', data = df)
#> Beginning Cgee S-function, @(#) geeformula.q 4.13 98/01/27
#> running glm to get initial regression estimate
#>   (Intercept)          dose        weight         litsz         dose2 
#>  2.537455e+00  6.880983e-03 -4.971600e+00 -9.148153e-02  1.055418e-06
# general estimating equations (exchangeable correlation structure)
mfit_2 = gee(ord_binary ~ dose + weight + litsz + dose2, family = binomial(link = 'logit'),
id = id, corstr = 'exchangeable', data = df)
#> Beginning Cgee S-function, @(#) geeformula.q 4.13 98/01/27
#> running glm to get initial regression estimate
#>   (Intercept)          dose        weight         litsz         dose2 
#>  2.537455e+00  6.880983e-03 -4.971600e+00 -9.148153e-02  1.055418e-06
# get coefficients
(coef_1 <- model_estimates(mfit_1))
#>      variable estimate      se
#> 1 (Intercept)   2.5375  1.5636
#> 2        dose   0.0069  2.2193
#> 3      weight  -4.9716 -3.3634
#> 4       litsz  -0.0915 -1.5371
#> 5       dose2   0.0000  0.1603
```

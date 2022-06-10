
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dqtools

<!-- badges: start -->
<!-- badges: end -->

TAF data users often need to assess the feasibility of specific data
analytic tasks. One typical workflow is to first specify the TAF file
types, states, years, and variables of interest, and then check the
fantastic [DQ Atlas](https://www.medicaid.gov/dq-atlas/welcome) site for
potential data quality (DQ) concerns.

The goal of `dqtools` is to simplify the second step for experienced TAF
users by providing a state-year-variable level assessment for different
TAF file types made available by DQ Atlas.

## Installation

You can install the development version of `dqtools` like so:

``` r
# install.packages("remotes")
remotes::install_github("jjchern/dqtools")
```

## Example

``` r
library(tidyverse)
#> ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──
#> ✔ ggplot2 3.3.6     ✔ purrr   0.3.4
#> ✔ tibble  3.1.7     ✔ dplyr   1.0.9
#> ✔ tidyr   1.2.0     ✔ stringr 1.4.0
#> ✔ readr   2.1.2     ✔ forcats 0.5.1
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()

# List all available datasets
# data(package = "dqtools") %>% 
#     pluck("results") %>% 
#     as_tibble() %>% 
#     select(Package, Item)
```

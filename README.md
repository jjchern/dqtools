
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dqtools

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
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
library(dplyr)

dqtools::dq_ip_file
#> # A tibble: 1,113 × 5
#>    State   `Data Year` Variable      Topic               `DQ Assessment`
#>    <chr>         <dbl> <chr>         <chr>               <chr>          
#>  1 Alabama        2020 ADMTG_DGNS_CD Diagnosis Code - IP Low concern    
#>  2 Alabama        2020 DGNS_CD_1     Diagnosis Code - IP Low concern    
#>  3 Alabama        2020 DGNS_CD_2     Diagnosis Code - IP Low concern    
#>  4 Alabama        2020 DGNS_CD_3     Diagnosis Code - IP Low concern    
#>  5 Alabama        2020 DGNS_CD_4     Diagnosis Code - IP Low concern    
#>  6 Alabama        2020 DGNS_CD_5     Diagnosis Code - IP Low concern    
#>  7 Alabama        2020 DGNS_CD_6     Diagnosis Code - IP Low concern    
#>  8 Alabama        2020 DGNS_CD_7     Diagnosis Code - IP Low concern    
#>  9 Alabama        2020 DGNS_CD_8     Diagnosis Code - IP Low concern    
#> 10 Alabama        2020 DGNS_CD_9     Diagnosis Code - IP Low concern    
#> # … with 1,103 more rows

dqtools::dq_ip_file |> count(Variable)
#> # A tibble: 21 × 2
#>    Variable          n
#>    <chr>         <int>
#>  1 ADMSN_DT         53
#>  2 ADMTG_DGNS_CD    53
#>  3 DGNS_CD_1        53
#>  4 DGNS_CD_10       53
#>  5 DGNS_CD_11       53
#>  6 DGNS_CD_12       53
#>  7 DGNS_CD_2        53
#>  8 DGNS_CD_3        53
#>  9 DGNS_CD_4        53
#> 10 DGNS_CD_5        53
#> # … with 11 more rows

dqtools::dq_ip_file |> count(Topic)
#> # A tibble: 4 × 2
#>   Topic                    n
#>   <chr>                <int>
#> 1 Admission Date - IP     53
#> 2 Diagnosis Code - IP    689
#> 3 Procedure Codes - IP   318
#> 4 Type of Service - IP    53

dqtools::dq_ip_file |> count(Topic, `DQ Assessment`)
#> # A tibble: 7 × 3
#>   Topic                `DQ Assessment`     n
#>   <chr>                <chr>           <int>
#> 1 Admission Date - IP  Low concern        52
#> 2 Admission Date - IP  Medium concern      1
#> 3 Diagnosis Code - IP  High concern       13
#> 4 Diagnosis Code - IP  Low concern       676
#> 5 Procedure Codes - IP Low concern       312
#> 6 Procedure Codes - IP Medium concern      6
#> 7 Type of Service - IP Low concern        53
```

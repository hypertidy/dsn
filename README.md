
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dsn

<!-- badges: start -->

[![R-CMD-check](https://github.com/hypertidy/dsn/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/hypertidy/dsn/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of dsn is to provide simple helpers for GDAL data source name
prefixes and related string handling.

## Installation

You can install the development version of dsn from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("hypertidy/dsn")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(dsn)
vsicurl("https://netcdf-r-us.org/f.nc")
#> [1] "/vsicurl/https://netcdf-r-us.org/f.nc"

driver("somefile.h5", "HDF5")
#> [1] "HDF5:somefile.h5"

unvsicurl("/vsicurl/https://netcdf-r-us.org/f.nc")
#> [1] "https://netcdf-r-us.org/f.nc"

unprefix("NETCDF:/u/user/somefile.nc")
#> [1] "/u/user/somefile.nc"
```

## Code of Conduct

Please note that the dsn project is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

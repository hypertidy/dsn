
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dsn

<!-- badges: start -->

[![R-CMD-check](https://github.com/hypertidy/dsn/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/hypertidy/dsn/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of dsn is to provide simple helpers for GDAL data source name
prefixes and related string handling.

Please note that dsn is not doing anything *with GDAL*, this is pure
string handling for things commonly use for GDAL:

- prepending ‘/viscurl/’ to an online data source url for [GDAL’s
  Virtual File System](https://gdal.org/user/virtual_file_systems.html)
- prepending a driver declaration to a data source,
  e.g. “HDF5:/my/files/data.h5” or “NETCDF:C:/temp/nc/afile.nc”

Please see `vapour::vapour_vrt()` for actual use of GDAL to extend a
data source name by opening the source and augmenting available
information. dsn is intended to support that usage, and will probably
add helpers for the ‘vrt://’ connection syntax as well.

## Installation

You can install the development version of dsn from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("hypertidy/dsn")
```

## Example

This is a basic example, add in the prefix for a vsicurl

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

NetCDF is a very common source and occasionally requires explicit driver
declaration, so we have a simple `driver()` wrapper for that.

``` r
(nc <- netcdf("/u/user/somfile.nc"))
#> [1] "NETCDF:/u/user/somfile.nc"

unprefix(nc)
#> [1] "/u/user/somfile.nc"
```

## Code of Conduct

Please note that the dsn project is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

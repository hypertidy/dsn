
#' Prefix handlers for GDAL data source names
#'
#' Add required prefixes, or remove them.
#'
#' @param x character vector, of data source names (file paths, urls, database connection strings, or GDAL dsn)
#' @param driver character vector of appropriate GDAL driver name
#' @return character vector
#'
#' @name prefix
#' @export
#'
#' @examples
#' vsicurl("https://netcdf-r-us.org/f.nc")
#'
#' driver("somefile.h5", "HDF5")
#'
#' unvsicurl("/vsicurl/https://netcdf-r-us.org/f.nc")
#'
#' unprefix("NETCDF:/u/user/somefile.nc")
vsicurl <- function(x) {
  sprintf("/vsicurl/%s", x)
}

#' @name prefix
#' @export
driver <- function(x, driver = "") {
  if (nchar(driver) < 1) x else sprintf("%s:%s", driver, x)
}

#' @name prefix
#' @export
netcdf <- function(x) {
  driver(x, "NETCDF")
}

#' @name prefix
#' @export
unprefix <- function(x) {
  gsub(".*:", "", x)
}

#' @name prefix
#' @export
unvsicurl <- function(x) {
  gsub("/vsicurl/", "", x)
}

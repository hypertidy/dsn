#' Wrapping handlers for GDAL data source names
#'
#' Subdataset and VRT connection strings.
#'
#' @param x character vector, of data source names (file paths, urls, database connection strings, or GDAL dsn)
#' @param varname named of variable in DSN
#' @param driver driver to use, e.g. "NETCDF", "HDF5"
#'
#' @return character string of the form "DRIVER:%s:varname"
#' @export
#'
#' @examples
#' f <- "myfile.nc"
#' sds(f, "variable", "NETCDF", quote = FALSE)
sds <- function(x, varname, driver, quote = TRUE) {
  if (quote) {
    template <- "%s:\"%s\":%s"
  }  else {
    template <- "%s:%s:%s"
  }
  sprintf(template, driver, x, varname)
}

#' VRT connection
#'
#' Create a vrt connection from an input string and named arguments.
#'
#' As of writing (GDAL 3.7.0DEV 2022-12-12) the only available named arguments
#' are 'a_srs', 'bands', 'a_ullr' but that doesn't stop this function.
#'
#' @export
#'
#' @return character string in the form "vrt://%s?arg1&arg2"
#' @examples
#'
#' vrtcon("myfile.nc", a_ullr = "0,90,360,-90", bands="1,2,1")
vrtcon <- function(x, ...) {
  args <- list(...)
  nms <- names(args)
  suff <- "?"
  if (length(args) < 1) suff <- ""
  extra <- ""
  for (i in seq_along(args)) {
    if (i > 1) extra <- "&"
    suff <- paste0(suff, extra, nms[i], "=", args[i])
  }
  sprintf("vrt://%s%s", x, suff)
}

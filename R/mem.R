ext_dim <- function (x, dim)
{
  px <- c(diff(x[1:2])/dim[1L], -diff(x[3:4])/dim[2L])
  geo_transform0(px, c(x[1L], x[4L]))
}

geo_transform0 <- function (px, ul, sh = c(0, 0))
{
  c(xmin = ul[[1L]], xres = px[[1L]], yskew = sh[[2L]], ymax = ul[[2L]],
    xskew = sh[[1L]], yres = px[[2L]])
}

#' Generate a data source name (DSN) for the GDAL MEM driver
#'
#' An array in memory can be referenced by a GDAL data source.
#'
#'
#' This DSN will only work in R, and is only for use with GDAL read and query tools (so terra, sf, gdalcubes, vapour, etc.).
#'
#' @param x an R array, must be of numeric type (integer is converted to double)
#' @param extent optional extent of the data in x,y c(xmin, xmax, ymin, ymax)
#' @param projection projection string (optional, sets the SPATIALREFERENCE of the MEM driver since GDAL 3.7)
#' @return character string, a DSN for use by GDAL
#' @export
#' @importFrom lobstr obj_addr
#' @examples
#' m <- matrix(as.integer(c(0L, 0, 0, 1)), 5L, 4L)
#' mem(m)
#' mem(volcano)
#'
mem <- function(x, extent = NULL, projection = "") {
  ## can't get Byte or Int32 to work
  type <- "Float64"
  x <- x * 1.0  ## make sure it's double haha

  dimension <- dim(x)
  if (is.null(extent)) extent <- c(0, dimension[1L], 0, dimension[2L])
  d3 <- 1
  if (length(dimension) > 2L) d3 <- dimension[3L]


  # type <-  switch(typeof(x),
  #                 integer = "Int32",
  #                double = "Float64",
  #                 raw = "Byte")
  offset <- c(Int32 = 4, Float64 = 8, Byte = 1)[type]
  gt <- ext_dim(extent, dimension)

  addr <- as.double(lobstr::obj_addr(x)) + 6 * offset

  spatialref <- ""

  dsn <- sprintf(
  "MEM:::DATAPOINTER=\"%s\",PIXELS=%i,LINES=%i,BANDS=%i,DATATYPE=%s,GEOTRANSFORM=%s,PIXELOFFSET=0,LINEOFFSET=0,BANDOFFSET=1",
   addr, dimension[1L], dimension[2L], d3, type, paste(gt, collapse = "/"))
  if (!is.null(projection) && length(projection) > 0 && !is.na(projection) && is.character(projection) && nzchar(projection)) {
    spatialref <- sprintf("SPATIALREFERENCE=\"%s\"", projection[1L])
    dsn <- sprintf("%s,%s", dsn, spatialref)
  }
  dsn

}

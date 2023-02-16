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
#'
#' @return character string, a DSN for use by GDAL
#' @export
#'
#' @examples
#' m <- matrix(c(0, 0, 0, 1), 5L, 4L)
#' mem(m)
#' mem(volcano)
#'
mem <- function(x, extent = NULL, bandoff = 0) {
  x <- x * 1.0  ## make sure it's double haha
#print(typeof(x))
  dimension <- dim(x)
  if (is.null(extent)) extent <- c(0, dimension[1L], 0, dimension[2L])
  d3 <- 1
  if (length(dimension) > 2L) d3 <- dimension[3L]
  type <- "Float64"
  # switch(typeof(x),
  #                integer = "Int32",
  #                double = "Float64",
  #                raw = "Byte")
  gt <- ext_dim(extent, dimension)
  addr <- as.double(pryr::address(x)) + 48

out <- sprintf(
  "MEM:::DATAPOINTER=\"%s\",PIXELS=%i,LINES=%i,BANDS=%i,DATATYPE=%s,GEOTRANSFORM=%s,PIXELOFFSET=0,LINEOFFSET=0,BANDOFFSET=1",
   addr, dimension[1L], dimension[2L], d3, type, paste(gt, collapse = "/"))
#print(out)
out
}

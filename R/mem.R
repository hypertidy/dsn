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
#' An array in memory can be referenced by a GDAL data source. The DSN points
#' directly at the memory of `x`, no copy is made.
#'
#' The DSN is only valid while `x` is alive and unmodified: keep a reference
#' to `x` for as long as the DSN is in use, or R's garbage collector may free
#' or reuse that memory. For the same reason `x` must already be a double
#' array (`storage.mode(x) <- "double"` to convert beforehand); `mem()` will
#' not convert it for you, because converting makes a temporary copy whose
#' memory does not survive this function returning.
#'
#' This DSN only works in the current R session, with GDAL read and query
#' tools (terra, sf, gdalcubes, vapour, gdalraster, etc.). Since GDAL 3.10,
#' opening a `MEM:::DATAPOINTER` DSN is disabled by default for security
#' reasons: set the configuration option `GDAL_MEM_ENABLE_OPEN=YES` (e.g.
#' `Sys.setenv(GDAL_MEM_ENABLE_OPEN = "YES")`) to allow it.
#'
#' `dimension` defaults to `dim(x)`; for an R matrix that is `(nrow, ncol)`
#' used as `(PIXELS, LINES)`, so GDAL scanlines run down the columns of the R
#' matrix (memory order is preserved, orientation is transposed relative to
#' the on-screen orientation of [graphics::image()]).
#'
#' @param x an R array of numeric (double) type, see Details
#' @param extent optional extent of the data in x,y c(xmin, xmax, ymin, ymax)
#' @param dimension size in pixels c(PIXELS, LINES), defaults to `dim(x)`, see Details
#' @param PIXELOFFSET pixel offset
#' @param LINEOFFSET line offset
#' @param BANDOFFSET band offset
#' @param projection projection string (optional, sets the SPATIALREFERENCE of the MEM driver since GDAL 3.7)
#'
#' @return character string, a DSN for use by GDAL
#' @export
#' @examples
#' mem(volcano)
#'
#' m <- matrix(c(0, 0, 0, 1), 5L, 4L)
#' mem(m)
mem <- function(x, extent = NULL, projection = "", dimension = NULL, PIXELOFFSET = NULL, LINEOFFSET  = NULL, BANDOFFSET = NULL) {
  if (!is.double(x)) {
    stop("'x' must be a double array ('storage.mode(x) <- \"double\"' to convert first);\n mem() does not copy or convert, the DSN references the memory of 'x' directly")
  }
  type <- "Float64"
  if (is.null(dimension)) {
    dimension <- dim(x)
  }
  if (is.null(extent)) extent <- c(0, dimension[1L], 0, dimension[2L])
  d3 <- 1
  if (length(dimension) > 2L) d3 <- dimension[3L]
  offset <- c(Int32 = 4, Float64 = 8, Byte = 1)[type]


  if (is.null(PIXELOFFSET)) PIXELOFFSET <- 0
  if (is.null(LINEOFFSET)) LINEOFFSET <- 0
  if (is.null(BANDOFFSET)) BANDOFFSET <- offset * prod(dimension[1:2])

  gt <- ext_dim(extent, dimension)

  ## address of the data of x (not the SEXP), as a decimal string
  addr <- addr(x)

  dsn <- sprintf(
  "MEM:::DATAPOINTER=%s,PIXELS=%i,LINES=%i,BANDS=%i,DATATYPE=%s,GEOTRANSFORM=%s,PIXELOFFSET=%i,LINEOFFSET=%i,BANDOFFSET=%i",
   addr, dimension[1L], dimension[2L], d3, type, paste(gt, collapse = "/"), PIXELOFFSET, LINEOFFSET, BANDOFFSET)
  if (!is.null(projection) && length(projection) > 0 && !is.na(projection) && is.character(projection) && nzchar(projection)) {
    dsn <- sprintf("%s,SPATIALREFERENCE=\"%s\"", dsn, projection[1L])
  }
  dsn

}



#' Get address of the data of an object
#'
#' This is primarily for use by mem(). Returns the address of the data
#' payload of a vector (not the SEXP header) as a decimal string.
#'
#' @param x object to get address of
#'
#' @return address as a decimal string
#'
#' @noRd
addr <- function(x) {
    .Call("C_addr", x = x, PACKAGE = "dsn")
}

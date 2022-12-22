#' ext_dim <- function (x, dim)
#' {
#'   px <- c(diff(x[1:2])/dim[1L], -diff(x[3:4])/dim[2L])
#'   geo_transform0(px, c(x[1L], x[4L]))
#' }
#'
#' geo_transform0 <- function (px, ul, sh = c(0, 0))
#' {
#'   c(xmin = ul[[1L]], xres = px[[1L]], yskew = sh[[2L]], ymax = ul[[2L]],
#'     xskew = sh[[1L]], yres = px[[2L]])
#' }
#'
#' #' Title
#' #'
#' #' @param x
#' #' @param extent
#' #'
#' #' @return
#' #' @export
#' #'
#' #' @examples
#' #' m <- rep(1, 4)
#' #' #vapour::vapour_raster_info(mem(m))
#' #' vapour::vapour_read_raster(mem(m, dimension = c(2, 2)), native = TRUE)
#' mem <- function(x, dimension = NULL, extent = NULL, bandoff = 0) {
#'   x <- force(x)
#'
#'   if (is.null(extent)) extent <- c(0, dimension[1L], 0, dimension[2L])
#'   d3 <- 1
#'   if (length(dimension) > 2L) d3 <- dimension[3L]
#'   type <- switch(typeof(x),
#'                  integer = "Int32",
#'                  double = "Float64",
#'                  raw = "Byte")
#'   gt <- ext_dim(extent, dimension)
#'   addr <- as.double(pryr::address(x)) + bandoff
#'
#' out <- sprintf(
#'   "MEM:::DATAPOINTER=%s,PIXELS=%i,LINES=%i,BANDS=%i,DATATYPE=%s,GEOTRANSFORM=%s",
#'    addr, dimension[1L], dimension[2L], d3, type, paste(gt, collapse = "/"))
#' print(out)
#' out
#' }

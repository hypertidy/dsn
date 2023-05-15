## extent here is the centres of the corner cells
#' Create a set of GCPs (ground control points) from dimension, extent
#'
#' @param dimension
#' @param extent
#'
#' @return `gcp_extent` returns the col,row,x,y values, `gcp_extent_arg` returns
#' formatted as a GDAL 'vrt://' connection string
#' @export
#'
#' @examples
#' gcp_extent(c(10, 20))
#' dsn <- sprintf("vrt://%s?%s", mem(volcano), gcp_extent_arg(dim(volcano)))
#' gcp <- gcp_extent(dim(volcano))
#' gcp_extent_arg(gcp)
gcp_extent <- function(dimension, extent = NULL) {

  if (is.null(extent)) extent <- c(0, dimension[1L], 0, dimension[2L])
  ## extent is the corners so lets set them to the centres
  offs <- 0.5 * diff(extent)[c(1, 3)]/dimension
#  #print(offs)
  extent <- extent + c(1, -1, 1, -1) * rep(offs, each = 2L)

  stopifnot(length(dimension) == 2L)
  stopifnot(length(extent) == 4L)
  stopifnot(all(!is.na(dimension)))
  stopifnot(all(!is.na(extent)))

  index <- as.matrix(expand.grid(col = c(1, dimension[1]), row = c(1, dimension[2])))
  coords <- as.matrix(expand.grid(x = extent[1:2], y = extent[3:4]))
  return(cbind(index, coords))
}

#' @name gcp_extent
#' @export
gcp_extent_arg <- function(gcp) {

  args <- unlist(lapply(split(t(gcp), rep(1:nrow(gcp), each = 4)),
                        \(.x) sprintf("gcp=%s", paste0(.x, collapse = ","))))
  paste(args, collapse = "&")
}

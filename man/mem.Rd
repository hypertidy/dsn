% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mem.R
\name{mem}
\alias{mem}
\title{Generate a data source name (DSN) for the GDAL MEM driver}
\usage{
mem(
  x,
  extent = NULL,
  projection = "",
  PIXELOFFSET = 0L,
  LINEOFFSET = 0L,
  BANDOFFSET = 1L
)
}
\arguments{
\item{x}{an R array, must be of numeric type (integer is converted to double)}

\item{extent}{optional extent of the data in x,y c(xmin, xmax, ymin, ymax)}

\item{projection}{projection string (optional, sets the SPATIALREFERENCE of the MEM driver since GDAL 3.7)}
}
\value{
character string, a DSN for use by GDAL
}
\description{
An array in memory can be referenced by a GDAL data source.
}
\details{
This DSN will only work in R, and is only for use with GDAL read and query tools (so terra, sf, gdalcubes, vapour, etc.).
}
\examples{
m <- matrix(as.integer(c(0L, 0, 0, 1)), 5L, 4L)
mem(m)
mem(volcano)

}

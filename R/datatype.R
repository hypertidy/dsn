#' @name datatype
#' @export
gdal_datatypes <- function() {
  ## from gdal.h
#   enum  	GDALDataType {
#   GDT_Unknown = 0 , GDT_Byte = 1 , GDT_Int8 = 14 , GDT_UInt16 = 2 ,
#   GDT_Int16 = 3 , GDT_UInt32 = 4 , GDT_Int32 = 5 , GDT_UInt64 = 12 ,
#   GDT_Int64 = 13 , GDT_Float32 = 6 , GDT_Float64 = 7 , GDT_CInt16 = 8 ,
#   GDT_CInt32 = 9 , GDT_CFloat32 = 10 , GDT_CFloat64 = 11 , GDT_TypeCount = 15
# }

  c(
  GDT_Unknown = 0 , GDT_Byte = 1 , GDT_Int8 = 14 , GDT_UInt16 = 2 ,
  GDT_Int16 = 3 , GDT_UInt32 = 4 , GDT_Int32 = 5 , GDT_UInt64 = 12 ,
  GDT_Int64 = 13 , GDT_Float32 = 6 , GDT_Float64 = 7 , GDT_CInt16 = 8 ,
  GDT_CInt32 = 9 , GDT_CFloat32 = 10 , GDT_CFloat64 = 11 , GDT_TypeCount = 15
)
}

#' Return the type name of the GDAL data type.
#'
#'
#'
#' @param x integer as returned by GDAL, or osgeo.gdal.Open().GetDatatype()
#'
#' @return character string of the type name (the name of the constant in GDAL, e.g. GDT_Byte)
#' @export
#' @aliases gdal_datatypes
#' @examples
#' datatype(1)
#' names(gdal_datatypes())
datatype <- function(x) {
  types <- gdal_datatypes()
  if (!as.integer(x) %in% types) stop(sprintf("unknown gdal raster data type %s", x))
  names(types)[match(x, types)]
}

readbin_ <- function(x) {
  type <- datatype(x)
  switch(type,
         GDT_Unknown = NULL,
         GDT_Byte = function(x) x,
         GDT_Int8 = function(x, n = 1L) readBin(x, "raw", n = n),
         GDT_UInt16 = function(x, n = 1L) readBin(x, "integer", n = n, size = 2, signed = FALSE, endian  = "little"),
         GDT_Int16 = function(x, n = 1L) readBin(x, "integer", n = n, size = 2, signed = TRUE, endian  = "little"),
         GDT_UInt32 = function(x, n = 1L) readBin(x, "integer", n = n, size = 4, signed = FALSE, endian  = "little"),
         GDT_Int32 = function(x, n = 1L) readBin(x, "integer", n = n, size = 4, signed = TRUE, endian  = "little"),
         ## this won't work we'll have to ask GDAL to read as double
         #GDT_UInt64 = function(x, n = 1L) readBin(x, "integer", n = n, size = 8, signed = FALSE, endian = "little"),
         #GDT_Int64 = function(x, n = 1L) readBin(x, "integer", n = n, size = 8, signed = TRUE, endian = "little"),
         GDT_Float32 = function(x, n = 1L) readBin(x, "numeric", n = n, size = 4, endian = "little"),
         GDT_Float64 = function(x, n = 1L) readBin(x, "numeric", n = n, size = 8, endian = "little"),
         ## can't change size for complex
        ## GDT_CFloat32 = function(x, n = 1L) readBin(x, "numeric", n = n, size = 4, endian = "little"),
         GDT_CFloat64 = function(x, n = 1L) readBin(x, "complex", n = n, size = 8, endian = "little")
         )
}

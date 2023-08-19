rds <- function(x, compress = "xz") {
  tf <- tempfile(fileext = ".RData")
  save(x, file = tf, compress = compress, version = 2)

  tf
}

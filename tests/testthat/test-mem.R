test_that("mem requires double and does not copy", {
  m <- matrix(1L, 2, 2)
  expect_error(mem(m), "double")
  expect_silent(mem(matrix(1.0, 2, 2)))
})

test_that("mem DSN is well formed with a decimal DATAPOINTER", {
  d <- mem(volcano)
  expect_match(d, "^MEM:::DATAPOINTER=[0-9]+,PIXELS=87,LINES=61,")
  expect_match(d, "DATATYPE=Float64")
  ## the address is the caller's own data, stable across calls
  expect_identical(mem(volcano), d)
})

test_that("projection appends SPATIALREFERENCE", {
  expect_match(mem(volcano, projection = "EPSG:4326"),
               "SPATIALREFERENCE=\"EPSG:4326\"$")
  expect_no_match(mem(volcano), "SPATIALREFERENCE")
})

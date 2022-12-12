test_that("wrapping works", {
  expect_equal(vrtcon("C:/myfile.nc", a_ullr = "0,1,1,0"), "vrt://C:/myfile.nc?a_ullr=0,1,1,0")

  expect_equal(vrtcon("C:/myfile.nc", bands="5,4,3,2,1", a_ullr = "0,1,1,0"), "vrt://C:/myfile.nc?bands=5,4,3,2,1&a_ullr=0,1,1,0")

  expect_equal(vrtcon("C:/myfile.nc"), "vrt://C:/myfile.nc")

  expect_equal(sds("myfile.nc", "varisable", "HDF5"), "HDF5:\"myfile.nc\":varisable")
  expect_equal(sds("myfile.nc", "varisable", "HDF5", quote = FALSE), "HDF5:myfile.nc:varisable")


})

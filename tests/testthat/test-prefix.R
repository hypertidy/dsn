ncurl <- "https://netcdf-r-us.org/f.nc"
hdffile <- "somefile.h5"

vsiu <- "/vsicurl/https://netcdf-r-us.org/f.nc"
pfnc <- "NETCDF:/u/user/somefile.nc"

test_that("prefix works", {
  expect_equal(vsicurl(ncurl), "/vsicurl/https://netcdf-r-us.org/f.nc")
  expect_equal(driver(vsicurl(ncurl)), "/vsicurl/https://netcdf-r-us.org/f.nc")
  expect_equal(driver(vsicurl(ncurl), "GMT"), "GMT:/vsicurl/https://netcdf-r-us.org/f.nc")

  expect_equal(netcdf("/viscurl/https://netcdf.rules"), "NETCDF:/viscurl/https://netcdf.rules")
  expect_equal(driver("C:/some/files/a.grd", "NETCDF"), "NETCDF:C:/some/files/a.grd")
})


test_that("unprefix works", {
  expect_equal(unvsicurl(vsiu), "https://netcdf-r-us.org/f.nc")
  expect_equal(unprefix(pfnc), "/u/user/somefile.nc")
})

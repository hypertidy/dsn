ncurl <- "https://netcdf-r-us.org/f.nc"
hdffile <- "somefile.h5"

vsiu <- "/vsicurl/https://netcdf-r-us.org/f.nc"
pfnc <- "NETCDF:/u/user/somefile.nc"

test_that("prefix works", {
  expect_equal(vsicurl(ncurl), "/vsicurl/https://netcdf-r-us.org/f.nc")
  expect_equal(driver(vsicurl(ncurl)), "/vsicurl/https://netcdf-r-us.org/f.nc")
  expect_equal(driver(vsicurl(ncurl), "GMT"), "GMT:/vsicurl/https://netcdf-r-us.org/f.nc")

  expect_equal(netcdf("/vsicurl/https://netcdf.rules"), "NETCDF:/vsicurl/https://netcdf.rules")
  expect_equal(driver("C:/some/files/a.grd", "NETCDF"), "NETCDF:C:/some/files/a.grd")
})


test_that("unprefix works", {
  expect_equal(unvsicurl(vsiu), "https://netcdf-r-us.org/f.nc")
  expect_equal(unprefix(pfnc), "/u/user/somefile.nc")
})

test_that("vsi prefixes use their own scheme", {
  expect_equal(vsicurl("x"), "/vsicurl/x")
  expect_equal(vsizip("x"),  "/vsizip/x")
  expect_equal(vsis3("x"),   "/vsis3/x")
  expect_equal(vsitar("x"),  "/vsitar/x")
  expect_equal(vsigzip("x"), "/vsigzip/x")
})

test_that("vsi prefixes chain", {
  ## the property sds depends on
  expect_equal(vsizip(vsicurl("x")), "/vsizip//vsicurl/x")
  expect_equal(vsis3(vsizip("x")),   "/vsis3//vsizip/x")
})

test_that("vsicurl signing", {
  expect_equal(vsicurl("u", sign = TRUE),
               "/vsicurl?pc_url_signing=yes&url=u")
})

test_that("un-prefix round trips", {
  expect_equal(unvsicurl(vsicurl("https://h/f.nc")), "https://h/f.nc")
})

test_that("unprefix strips one leading driver prefix only", {
  expect_equal(unprefix("NETCDF:/u/user/somefile.nc"), "/u/user/somefile.nc")
  expect_equal(unprefix("NETCDF:\"a.nc\":var"), "\"a.nc\":var")
  ## Windows drive letters survive
  expect_equal(unprefix("C:/foo.tif"), "C:/foo.tif")
})

test_that("unvsicurl is anchored", {
  expect_equal(unvsicurl("/vsicurl/https://h/f.tif"), "https://h/f.tif")
  expect_equal(unvsicurl("https://h/vsicurl/decoy.tif"), "https://h/vsicurl/decoy.tif")
})

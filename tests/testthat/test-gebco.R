test_that("gebco ice vs bedrock is differentiated", {
  expect_true(grepl("sub_ice", gebco23_bedrock()))
  expect_true(grepl("land_cog", gebco23()))

})

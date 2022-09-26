library(testthat)

precipDeviation <- terra::rast(system.file("extdata/precipDeviation.asc",
                                           package = "climateStability"))

test_that("rescale0to1 works", {
  expect_error(climateStability::rescale0to1())
  expect_warning(climateStability::rescale0to1("a"))

  testResult <- climateStability::rescale0to1(precipDeviation)
  expect_equal(class(testResult)[[1]], "SpatRaster")
  expect_true(minmax(testResult)[[2]] >= 1)
})

library(testthat)

precipDeviation <- terra::rast(system.file("extdata/precipDeviation.asc",
                                           package = "climateStability"))

test_that("rescale0to1 works", {
  expect_error(climateStability::stabilityCalc())
  expect_warning(climateStability::stabilityCalc("a"))

  testResult <- climateStability::stabilityCalc(precipDeviation)
  expect_equal(class(testResult)[[1]], "SpatRaster")
  expect_true(minmax(testResult)[[2]] >= 1)
})

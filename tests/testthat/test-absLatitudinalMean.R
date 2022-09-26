library(testthat)

precipDeviation <- terra::rast(system.file("extdata/precipDeviation.asc",
                                           package = "climateStability"))

test_that("absLatitudinalMean works", {
  expect_error(climateStability::absLatitudinalMean())
  expect_warning(climateStability::absLatitudinalMean("a"))

  testResult <- climateStability::absLatitudinalMean(precipDeviation)
  expect_equal(class(testResult)[[1]], "matrix")
  expect_length(testResult, 72)
  expect_equal(ncol(testResult), 2)
})

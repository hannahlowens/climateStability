library(testthat)

precipDeviation <- terra::rast(system.file("extdata/precipDeviation.asc",
                                           package = "climateStability"))

test_that("absLatitudinalMean works", {
  expect_error(climateStability::latitudinalMean())
  expect_warning(climateStability::latitudinalMean("a"))

  testResult <- climateStability::latitudinalMean(precipDeviation)
  expect_equal(class(testResult)[[1]], "matrix")
  expect_length(testResult, 144)
  expect_equal(ncol(testResult), 2)
})

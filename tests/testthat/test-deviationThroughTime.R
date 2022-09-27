library(testthat)
library(terra)

# Set up dataset for test
td <- tempdir()

write(x = "Check incompatible file extension.", file = paste0(td ,"/badFile.txt"))
write(x = "Check incompatible file extension.", file = paste0(td ,"/badFile2.txt"))
write(x = "Check incompatible file extension.", file = paste0(td ,"/badFile3.txt"))

suppressWarnings(x <- rast(nrows=20, ncols=20, xmin=0, xmax=10, ymin=0, ymax=10, vals = c(10,10,10,10,20)))
x2 <- x * 1.01
suppressWarnings(x3 <- rast(nrows=20, ncols=20, xmin=0, xmax=10, ymin=0, ymax=10, vals = c(10,10,10,10,10)))
x4 <- x * 1.1
rastStack <- c(x, x2, x3, x4, x)

writeRaster(rastStack, filename = paste0(td, "/raster", 1:nlyr(rastStack), ".tif"), overwrite = TRUE)

test_that("devationThroughTime general tests", {
  expect_error(climateStability::deviationThroughTime())
  expect_error(climateStability::deviationThroughTime("a"))
  expect_error(climateStability::deviationThroughTime(variableDirectory = td,
                                                      timeSlicePeriod = "a"))
  expect_error(climateStability::deviationThroughTime(variableDirectory = td,
                                                      timeSlicePeriod = 100,
                                                      fileExtension = "cheese"))
  expect_warning(climateStability::deviationThroughTime(variableDirectory = td,
                                                      timeSlicePeriod = 100,
                                                      fileExtension = "txt"))
})



# Evenly spaced vectors ----

test_that("devationThroughTime evenly spaced", {
  testResult <- climateStability::deviationThroughTime(td,
                                                       timeSlicePeriod = 100,
                                                       fileExtension = "tif")
  expect_equal(class(testResult)[[1]], "SpatRaster")
})

# Unevenly spaced vectors ----

test_that("devationThroughTime unevenly spaced", {
  expect_error(climateStability::deviationThroughTime(variableDirectory = td,
                                                       timeSlicePeriod = c(100, 50),
                                                       fileExtension = "tif"))

  testResult <- climateStability::deviationThroughTime(variableDirectory = td,
                                                       timeSlicePeriod = c(50, 50, 100, 100),
                                                       fileExtension = "tif")
  expect_equal(class(testResult)[[1]], "SpatRaster")
})

# Delete test files ----
unlink(paste0(td), recursive = T)

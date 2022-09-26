library(climateStability)

precipDeviation <- deviationThroughTime("data-raw/precipfiles/", 1000)
terra::writeRaster(precipDeviation, "inst/extdata/precipDeviation.asc")
#save(precipDeviation, file = "data/precipDeviation.RData")
#tools::resaveRdaFiles(precipDeviation, paths = "data/precipDeviation.RData", compress = "auto")

temperatureDeviation <- deviationThroughTime("data-raw/tempfiles/", 1000)
terra::writeRaster(temperatureDeviation, "inst/extdata/temperatureDeviation.asc")
#save(temperatureDeviation, file = "data/temperatureDeviation.RData")
#tools::resaveRdaFiles(temperatureDeviation, paths = "data/temperatureDeviation.RData", compress = "auto")

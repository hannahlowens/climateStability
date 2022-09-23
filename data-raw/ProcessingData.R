library(terra)
library(climateStability)

precipDeviation <- deviationThroughTime("data-raw/precipfiles/", 1000)
save(precipDeviation, file = "data/precipDeviation.RData")

temperatureDeviation <- deviationThroughTime("data-raw/tempfiles/", 1000)
save(temperatureDeviation, file = "data/temperatureDeviation.RData")

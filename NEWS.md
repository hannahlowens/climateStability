# climateStability 0.1.4

* Added error checking and documentation to emphasize that `deviationThroughTime()` needs at least two
raster layers
* Updated the process of calculating stability from `deviationThroughTime()` so that it only requires
one step, via the function `stabilityCalc()`. This calculation is more robust to 0 values in the 
raster that results from `deviationThroughTime`.
* Updated functions to use `terra` package instead of `raster`.

# climateStability 0.1.3

* Fix typos in vignettes
* `deviationThroughTime()` does not change your working directory anymore
* add a `fileExtension` argument in `deviationThroughTime` to support more file extensions
* allow the use of all formats supported in `raster::writeFormats()` in `deviationThroughTime()` through the `fileExtension` argument
* The package now follows most of `goodpractice` recommendations 

# climateStability 0.1.2

* Fixed algorithmic error in deviationThroughTime().

# climateStability 0.1.2

* The package now works.

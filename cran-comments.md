## Update
This is a package update. In this version I have:

* Added error checking and documentation to emphasize that `deviationThroughTime()` needs at least two
raster layers
* Updated the process of calculating stability from `deviationThroughTime()` so that it only requires
one step, via the function `stabilityCalc()`. This calculation is more robust to 0 values in the 
raster.
* Updated functions to use `terra` package instead of `raster`.
* Broader range of allowable filetypes for `deviationThroughTime()` and enhanced error handling to 
return informative errors.
* Unit tests and test coverage added.

## Test environments
* local OS X 12.6 install, R 4.1.2

* win-builder (devel and release), R 4.2.0
* ubuntu 20.04 (devel and release, on GitHub Actions), R 4.2.1
* windows-latest (on GitHub Actions), R 4.2.1
* macOS-latest (on GitHub Actions), R 4.2.1
* rhub

## R CMD check results
There were no ERRORs or WARNINGs. 

There were 0 NOTES.

## Downstream dependencies
I have also run a devtools::revdep() check on downstream dependencies of 
`climateStability`. 

All packages that I could install passed with no ERRORs or WARNINGs.

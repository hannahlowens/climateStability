#' @title Rescale raster from 0 to 1
#'
#' @description A function to rescale a raster from 0 to 1. This is done using the formula (value-min)/(max-min).
#'
#' @param rasterForCalculation A `SpatRaster` that contains data to be rescaled
#'
#' @return A raster that has been rescaled from 0 to 1
#'
#' @keywords manip
#'
#' @references
#' Owens, H.L., Guralnick, R., 2019. climateStability: An R package to estimate
#' climate stability from time-slice climatologies. Biodiversity Informatics
#' 14, 8–13. https://doi.org/10.17161/bi.v14i0.9786
#'
#' @importFrom terra minmax
#'
#' @examples
#' precipDeviation <- terra::rast(system.file("inst/extdata/precipDeviation.asc",
#'                                            package = "climateStability"))
#' precipStability <- 1/precipDeviation
#' relativeClimateStability <- rescale0to1(precipStability)
#'
#' @export
rescale0to1 <- function(rasterForCalculation){
  if (class(rasterForCalculation) != "SpatRaster"){
    warning("Supplied argument is not a SpatRaster./n", sep = "")
    return(NULL)
  }
  rasterMinMax <- minmax(rasterForCalculation)
  rescaledRaster <- (rasterForCalculation - rasterMinMax[1])/(rasterMinMax[2] - rasterMinMax[1])
  return(rescaledRaster)
}

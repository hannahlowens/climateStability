#' @title Calculate stability from deviation
#'
#' @description A function to calculate stability based on the results of `deviationThroughTime`.
#'
#' @param rasterForCalculation A raster that contains data from which stability is to be calculated.
#'
#' @details This formula takes the inverse of the raster and rescales it from 0 to 1.This function is
#' necessary in cases where there is no deviation in some cells. If time slices are very close
#' together, it's possible that some cells may have values equal to zero, at which point if you
#' simply divide 1 by the raster and rescale the result, you can end up with a raster full of zeroes.
#'
#' @return A raster
#'
#' @keywords manip
#'
#' @references
#' Owens, H.L., Guralnick, R., 2019. climateStability: An R package to estimate
#' climate stability from time-slice climatologies. Biodiversity Informatics
#' 14, 8–13. https://doi.org/10.17161/bi.v14i0.9786
#' @examples
#'
#' data(precipDeviation)
#' precipStability <- stabilityCalc(precipDeviation)
#'
#' @export
stabilityCalc <- function(rasterForCalculation){
  if (class(rasterForCalculation) != "RasterLayer"){
    warning("Supplied argument is not a raster./n", sep = "")
    return(NULL)
  }

  #Replace 0s with NAs
  temp <- rasterForCalculation
  temp[rasterForCalculation == 0] <- NA

  #Do inversion
  temp <- 1/temp
  temp <- rescale0to1(temp)

  #Replace NAs with 1s
  temp[is.na(temp)] <- 1

  #Mask to extent of original file
  finalRaster <- raster::mask(temp, rasterForCalculation)

  return(finalRaster)
}

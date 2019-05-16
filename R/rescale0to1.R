library(raster);

#' @title Rescale raster from 0 to 1
#'
#' @description A function to rescale a raster from 0 to 1. This is done using the formula (value-min)/(max-min).
#'
#' @param rasterForCalculation A raster that contains data to be rescaled
#'
#' @return A raster that has been rescaled from 0 to 1
#'
#' @keywords manip
#'
#' @references Owens, HL, and RP Guralnick. *Submitted*. *Biodiversity Informatics*.
#'
#' @examples
#'
#' data(precipDeviation);
#' precipStability <- 1/precipDeviation;
#' relativeClimateStability <- rescale0to1(precipStability);
#'
#' @export

rescale0to1 <- function(rasterForCalculation){
  if (class(rasterForCalculation) != "RasterLayer"){
    warning("Supplied argument is not a raster./n", sep = "");
    return(NULL);
  }
  rescaledRaster <- (rasterForCalculation - rasterForCalculation@data@min)/(rasterForCalculation@data@max - rasterForCalculation@data@min)
  return(rescaledRaster);
}

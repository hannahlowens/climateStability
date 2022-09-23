#' @title absLatitudinalMean
#'
#' @description A function to calculate mean values of a raster at the absolute value of latitude, at the resolution of a given raster layer.
#'
#' @param rasterForCalculation A raster that contains data for plotting according to latitudinal value
#'
#' @return A vector of mean raster values for each absolute value of latitude.
#'
#' @keywords manip
#'
#' @references
#' Owens, H.L., Guralnick, R., 2019. climateStability: An R package to estimate
#' climate stability from time-slice climatologies. Biodiversity Informatics
#' 14, 8–13. https://doi.org/10.17161/bi.v14i0.9786
#'
#' @seealso \code{\link{latitudinalMean}} for calculating mean values of rasters for all latitudinal bands.
#'
#' @examples
#'
#' precipDeviation <- terra::rast(system.file("data/precipDeviation.asc",
#'                                            package = "climateStability"))
#' precipStability <- 1/precipDeviation
#' alm <- absLatitudinalMean(rasterForCalculation = precipStability)
#' plot(alm, main = "Precipitation Stability by Absolute Latitude",
#' ylab = "Relative Stability", type = "l")
#'
#' @export
absLatitudinalMean <- function(rasterForCalculation){
  spatVect <- terra::as.points(rasterForCalculation)
  pointExtData <- cbind(as.data.frame(crds(spatVect)),
                        as.data.frame(spatVect))
  latData <- matrix(nrow = length(unique(abs(pointExtData$y))), ncol = 2)
  latData[,1] <- sort(unique(abs(pointExtData$y)))
  colnames(latData) <- c("Latitude",  "Value")
  lat <- sort(unique(abs(pointExtData$y)))
  count <- 1
  while(count <= length(lat)){
    latData[latData[,1]==lat[[count]],][2] <- c(
      mean(pointExtData[abs(pointExtData$y)==lat[[count]],3]))
    count <- count + 1
  }
  return(latData)
}

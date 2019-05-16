library(raster);

#' @title latitudinalMean
#'
#' @description A function to calculate mean values of a raster at every line of latitude, at the resolution of a given raster layer. Put another way, for each row in the raster, it calculates a mean.
#'
#' @param rasterForCalculation A raster that contains data for plotting according to latitudinal value
#'
#' @return A vector of raster values for each absolute value of latitude.
#'
#' @keywords manip
#'
#' @references Owens, HL, and RP Guralnick. *Submitted*. *Biodiversity Informatics*.
#'
#' @seealso \code{\link{absLatitudinalMean}} to calculate mean value for each absolute value of latitude.
#'
#' @examples
#'
#' data(precipDeviation);
#' precipStability <- 1/precipDeviation;
#' latMean <- absLatitudinalMean(rasterForCalculation = precipStability);
#' plot(latMean, main = "Precipitation Stability by Latitude",
#' ylab = "Relative Stability", type = "l");
#'
#' @export

latitudinalMean <- function(rasterForCalculation){
  pointExt <- as.data.frame(raster::rasterToPoints(rasterForCalculation)[,1:3]);
  pointExtData <- as.data.frame(pointExt);
  latData <- matrix(nrow = length(unique(pointExtData$y)), ncol = 2);
  latData[,1] <- sort(unique(pointExtData$y));
  colnames(latData) <- c("Latitude",  "Value");
  lat <- sort(unique(pointExtData$y));
  count <- 1
  while(count <= length(lat)){
    latData[latData[,1]==lat[[count]],][2] <- c(
      mean(pointExtData[pointExtData$y==lat[[count]],3]));
    count <- count + 1
  }
  return(latData);
}

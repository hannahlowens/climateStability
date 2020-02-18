#' @title Calculating deviation through time
#'
#' @description A function that reads time-slice rasters of data for a given climate (typically processed data from a climate model run, such as the results of an analysis using PaleoView (Fordham, *et al.* 2017, Ecography)) in a given directory and calculates average deviation per year across time slices.
#'
#' @param variableDirectory A directory containing at least two time slice rasters for a given climate variable.
#'
#' @param timeSlicePeriod Either a single number, in years, representing the time period elapsed between temporally-even climate variable raster slices, or a vector corresponding to periods, in years, between temporally-uneven time slices.
#'
#' @param fileExtension a character that describes the fileExtension corresponding to the all suported formats in \code{\link[raster]{writeFormats}}
#'
#' @details Make sure that files in the `variableDirectory` are read into `R` in order.
#'
#' If you are specifying temporally-uneven time slices with `timeSlicePeriod`, make sure that each number corresponds to the number of years elapsed *between* time slices, *in the same order as the files were read into `R`*. There should be one less number than the number of files, and you must have at least three files in the directory.
#'
#' @return A raster showing the geographic distribution of climate deviation through time for a particular climate variable.
#'
#' @keywords manip
#'
#' @references
#' Owens, H.L., Guralnick, R., 2019. climateStability: An R package to estimate
#' climate stability from time-slice climatologies. Biodiversity Informatics
#' 14, 8–13. https://doi.org/10.17161/bi.v14i0.9786
#'
#' @seealso \code{\link{precipDeviation}} and \code{\link{temperatureDeviation}} for examples of data produced using this function.
#'
#' @examples
#' \donttest{
#' #Even time slices
#' precipDeviation <- deviationThroughTime("precipfiles/", 1000)
#'
#' #Uneven time slices
#' precipDeviationUneven <- deviationThroughTime("unevenPrecipFiles",
#'                                               c(1000, 1000, 1000, 1000, 5000, 5000, 6000))
#'}
#'
#' @importFrom stats sd
#'
#' @export
deviationThroughTime <- function(variableDirectory, timeSlicePeriod,
                                 fileExtension = "asc"){

  fileExtension <- tolower(fileExtension)
  match.arg(fileExtension, c("grd", "asc", "sdat", "rst", "nc", "tif", "envi",
                             "bil", "img"))

  if (!dir.exists(variableDirectory)){
    stop(variableDirectory, " is not a directory that exists.")
  }
  if(!is.numeric(timeSlicePeriod)){
      stop(timeSlicePeriod, " is not numeric.")
  }

  rastList <- list.files(path = variableDirectory,
                         pattern = paste0(".", fileExtension, "$"), full.names = T)

  if(!length(rastList) > 2){
    stop(variableDirectory, " must contain at least three raster layers.")
  }

  if(length(timeSlicePeriod) != 1 && length(timeSlicePeriod) != (length(rastList) - 1)){
    stop("The specified timeSlicePeriod object is not of expected length (1 or one less than the number of .asc files in variableDirectory)")
  }
  print(rastList)
  varStack <- raster::stack(rastList)
  intervalDev <- varStack[[-1]]
  count <- 2
  while (count <= length(rastList)){
    if(length(timeSlicePeriod) == 1){
      intervalDev[[(count - 1)]] <- raster::calc(varStack[[(count-1):count]], sd)/timeSlicePeriod[[1]]
    }
    else{
      intervalDev[[(count - 1)]] <- raster::calc(varStack[[(count-1):count]], sd)/timeSlicePeriod[[(count-1)]]
    }
    count <- count + 1
  }
  if (length(timeSlicePeriod) == 1){
    deviation <- sum(intervalDev)/(timeSlicePeriod*(length(rastList)-1))
  }
  else{
    deviation <- sum(intervalDev)/sum(timeSlicePeriod)
  }

  return(deviation)
}

library(raster);

#' @title Calculating Deviation Through Time
#'
#' @description A function that reads time-slice rasters of data for a given climate (typically processed data from a climate model run, such as the results of an analysis using PaleoView (Fordham, *et al.* 2017, Ecography)) in a given directory and calculates average deviation per year across time slices.
#'
#' @param variableDirectory A directory containing at least two time slice rasters for a given climate variable.
#'
#' @param timeSlicePeriod Either a single number, in years, representing the time period elapsed between temporally-even climate variable raster slices, or a vector corresponding to periods, in years, between temporally-uneven time slices.
#'
#' @details Make sure that files in the `variableDirectory` are read into `R` in order.
#'
#' If you are specifying temporally-uneven time slices with `timeSlicePeriod`, make sure that each number corresponds to the number of years elapsed *between* time slices, *in the same order as the files were read into `R`*. There should be one less number than the number of files.
#'
#' @return A raster showing the geographic distribution of climate deviation through time for a particular climate variable.
#'
#' @keywords manip
#'
#' @references Owens, HL, and RP Guralnick. *Submitted*. *Biodiversity Informatics*.
#'
#' @seealso \code{\link{precipDeviation}} and \code{\link{temperatureDeviation}} for examples of data produced using this function.
#'
#' @examples
#' \dontrun{
#' #Even time slices
#' precipDeviation <- deviationThroughTime("precipfiles/", 1000);
#'
#' #Uneven time slices
#' precipDeviationUneven <- deviationThroughTime("unevenPrecipFiles",
#'                                               c(1000, 1000, 1000, 1000, 5000, 5000, 6000))
#'}
#'
#' @import raster
#'
#' @importFrom stats sd
#'
#' @export

deviationThroughTime <- function(variableDirectory, timeSlicePeriod){
  homeDir <- getwd();
  if (!file.exists(variableDirectory)){
    setwd(homeDir);
    warning(paste(variableDirectory, " is not a directory that exists.", sep = ""));
    return(NULL);
  }
  if(!is.numeric(timeSlicePeriod)){
      setwd(homeDir);
      warning(paste(timeSlicePeriod, " is not numeric.", sep = ""));
      return(NULL);
  }

  setwd(variableDirectory);
  rastList <- list.files(pattern = ".asc$")

  if(length(timeSlicePeriod) != 1 && length(timeSlicePeriod) != (length(rastList) - 1)){
    setwd(homeDir);
    warning(paste("The specified timeSlicePeriod object is not of expected length (1 or one less than the number of .asc files in variableDirectory)"));
    return(NULL);
  }

  varStack <- stack(rastList);
  intervalDev <- varStack[[-1]];
  count <- 2
  while (count <= length(rastList)){
    if(length(timeSlicePeriod) == 1){
      intervalDev[[(count - 1)]] <- raster::calc(varStack[[(count-1):count]], sd)/timeSlicePeriod[[1]];
    }
    else{
      intervalDev[[(count - 1)]] <- raster::calc(varStack[[(count-1):count]], sd)/timeSlicePeriod[[(count-1)]];
    }
    count <- count + 1;
  }

  deviation <- sum(intervalDev)/length(timeSlicePeriod)

  setwd(homeDir);
  return(deviation);
}

library(raster);

#' @title deviationThroughTime
#'
#' @description A function that reads time-slice rasters of data for a given climate (typically processed data from a climate model run, suceh as the results of an analysis using PaleoView (Fordham, *et al*. 2017, Ecography)) in a given directory and calculates standard deviation in that climate variable through time.
#'
#' @param variableDirectory A directory containing at least two time slice rasters for a given climate variable.
#'
#' @param timePeriod A number, in years, representing time elapsed between climate variable raster slices.
#'
#' @return A raster showing the geographic distribution of standard deviations through time in a particular climate variable.
#'
#' @examples
#' \dontrun{
#' precipDeviation <- deviationThroughTime("precipfiles/", 20000);
#'}
#'
#' @import raster
#'
#' @importFrom stats sd
#'
#' @export

deviationThroughTime <- function(variableDirectory, timePeriod){
  homeDir <- getwd();
  if (!file.exists(variableDirectory)){
    setwd(homeDir);
    warning(paste(variableDirectory, " is not a directory that exists.", sep = ""));
    return(NULL);
  } else{
    if(!is.numeric(timePeriod)){
      setwd(homeDir);
      warning(paste(timePeriod, " is not a valid number.", sep = ""));
      return(NULL);
    } else{
      setwd(variableDirectory);
      rastList <- list.files(pattern = ".asc$")
      varStack <- stack(unlist(rastList));
      deviation <- calc(varStack, fun = sd); #Standard deviation in time slices
      devThroughTime <- deviation/timePeriod;
      plot(devThroughTime);
      setwd(homeDir);
      return(devThroughTime);
    }
  }
}

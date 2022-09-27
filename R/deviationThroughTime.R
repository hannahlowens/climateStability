#' @title Calculating deviation through time
#'
#' @description A function that reads time-slice rasters of data for a given climate (typically processed data from a
#' climate model run, such as the results of an analysis using PaleoView (Fordham, *et al.* 2017, Ecography)) in a given
#' directory and calculates average deviation per year across time slices.
#'
#' @param variableDirectory A directory containing at least two time slice rasters for a given climate variable.
#'
#' @param timeSlicePeriod Either a single number, in years, representing the time period elapsed between temporally-even
#' climate variable raster slices, or a vector corresponding to periods, in years, between temporally-uneven time slices.
#'
#' @param fileExtension a character that describes a fileExtension corresponding to one of the suported drivers in
#' \code{\link[terra]{gdal}}
#'
#' @details Make sure that files in the `variableDirectory` are read into `R` in order.
#'
#' If you are specifying temporally-uneven time slices with `timeSlicePeriod`, make sure that each number corresponds to the
#' number of years elapsed *between* time slices, *in the same order as the files were read into `R`*. There should be one
#' less number than the number of files, and you must have at least three files in the directory.
#'
#' See `precipDeviation.asc` and `temperatureDeviation.asc` for examples of rasters created using this function. See reference
#' for data source details.
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
#' @examples
#' # Generate sample data
#' td <- tempdir()
#' suppressWarnings(x <- terra::rast(nrows=20, ncols=20,
#'                                   xmin=0, xmax=10, ymin=0, ymax=10,
#'                                   vals = c(10,10,10,10,20)))
#' x2 <- x * 1.01
#' rastStack <- c(x, x2, x)
#' terra::writeRaster(rastStack, filename = paste0(td, "/raster",
#'                                                 1:terra::nlyr(rastStack), ".tif"),
#'                    overwrite = TRUE)
#'
#' # Even time slices
#' testResult <- deviationThroughTime(td, timeSlicePeriod = 100,
#'                                    fileExtension = "tif")
#'
#' # Uneven time slices
#' testResult <- deviationThroughTime(variableDirectory = td,
#'                                    timeSlicePeriod = c(25, 100),
#'                                    fileExtension = "tif")
#' # Delete temporary files
#' unlink(td)
#'
#' @importFrom terra rast stdev
#'
#' @export
deviationThroughTime <- function(variableDirectory, timeSlicePeriod,
                                 fileExtension = "asc"){

  fileExtension <- tolower(fileExtension)

  if (!dir.exists(variableDirectory)){
    stop(variableDirectory, " is not a directory that exists.")
  }
  if(!is.numeric(timeSlicePeriod)){
      stop(timeSlicePeriod, " is not numeric.")
  }

  rastList <- list.files(path = variableDirectory,
                         pattern = paste0(".", fileExtension, "$"), full.names = T)

  if(!length(rastList) > 0){
    stop(variableDirectory, " does not contain any files with ", fileExtension,
    " file extension.")
  }

  if(!length(rastList) > 2){
    stop(variableDirectory, " must contain at least three raster layers.")
  }

  if(length(timeSlicePeriod) != 1 && length(timeSlicePeriod) != (length(rastList) - 1)){
    stop("Specified timeSlicePeriod object is not of expected length \n(1 or one less than number of .asc files in variableDirectory)")
  }

  print(rastList)

  varStack <- try(suppressWarnings(terra::rast(rastList)),
                  silent = TRUE)
  if("try-error" %in% class(varStack)){
    warning(message(fileExtension, " is not a supported file extension.\n"))
    return(NULL)
  } else{
    intervalDev <- varStack[[-1]]
    count <- 2
    while (count <= length(rastList)){
      if(length(timeSlicePeriod) == 1){
        intervalDev[[(count - 1)]] <- terra::stdev(varStack[[(count-1):count]],
                                                   na.rm = TRUE)/timeSlicePeriod[[1]]
      } else{
        intervalDev[[(count - 1)]] <- terra::stdev(varStack[[(count-1):count]],
                                                   na.rm = TRUE)/timeSlicePeriod[[(count-1)]]
      }
      count <- count + 1
    }
    if (length(timeSlicePeriod) == 1){
      deviation <- sum(intervalDev)/(timeSlicePeriod*(length(rastList)-1))
    } else{
      deviation <- sum(intervalDev)/sum(timeSlicePeriod)
    }

    return(deviation)
  }
}

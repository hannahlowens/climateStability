#' Worldwide deviation in mean annual temperature over the last 21,000 years
#'
#' Using *PaleoView* version 1.1 (Fordham, *et al.* 2017), 20 100-year climatological
#' means of mean annual temperature were generated over 1,000-year time slices from
#' the TRaCE21ka experiments implemented using the CCSM 3.0 climate model.
#'
#' @docType data
#'
#' @usage data(temperatureStandardDeviation)
#'
#' @format An object of class \code{"raster"}
#'
#' @keywords datasets
#'
#' @references OWENS BIODIVERSITY INFORMATICS CITATION GOES HERE
#'
#' @examples
#' data(temperatureStandardDeviation)
#' tempStability <- 1/temperatureDeviation; #calculate stability from deviation
#'
"temperatureDeviation"

#' Worldwide deviation in mean annual temperature over the last 21,000 years
#'
#' Using *PaleoView* version 1.1 (Fordham, *et al.* 2017), 20 100-year climatological
#' means of mean annual temperature were generated over 1,000-year time slices from
#' the TRaCE21ka experiments implemented using the CCSM 3.0 climate model. We then
#' calculated deviation through time as the mean of standard deviations between time
#' slices divided by the time elapsed between time slices. This calculation was
#' performed using the `deviationThroughTime()` function in the `climateStability`
#' package.
#'
#' @docType data
#'
#' @usage data(temperatureDeviation)
#'
#' @format An object of class \code{"raster"}
#'
#' @keywords datasets
#'
#' @references
#' Owens, H.L., Guralnick, R., 2019. climateStability: An R package to estimate
#' climate stability from time-slice climatologies. Biodiversity Informatics
#' 14, 8–13. https://doi.org/10.17161/bi.v14i0.9786
#'
#' @seealso \code{\link{deviationThroughTime}} for details on the calculation.
#'
#' @examples
#' data(temperatureDeviation)
#' tempStability <- 1/temperatureDeviation #calculate stability from deviation
#'
"temperatureDeviation"

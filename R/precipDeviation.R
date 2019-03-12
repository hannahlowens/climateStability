#' Worldwide deviation in annual precipitation over the last 21,000 years
#'
#' Using *PaleoView* version 1.1 (Fordham, *et al.* 2017), 20 100-year climatological
#' means of annual precipitation were generated over 1,000-year time slices from the
#' TRaCE21ka experiments implemented using the CCSM 3.0 climate model.
#'
#' @docType data
#'
#' @usage data(precipitationStandardDeviation)
#'
#' @format An object of class \code{"raster"}
#'
#' @keywords datasets
#'
#' @references OWENS BIODIVERSITY INFORMATICS CITATION GOES HERE
#'
#' @examples
#' data(precipitationStandardDeviation)
#' precipStability <- 1/precipDeviation; #calculate stability from deviation
#'
"precipDeviation"

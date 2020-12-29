#' Clean images
#'
#' @param x a magick-image
#' @return a picture
#' @import magick
#' @import grDevices
#' @import stats

image_clean <- function(x){
  x <- image_convert(x, "png", matte=TRUE)
  x <- image_trim(x)
  x <- image_transparent(x, "	#FFFFFF", fuzz = 10)
}

#' Generate a list of picture sizes
#'
#' @param x an image
#' @return a vector of imagesizes
#' @import magick
#' @import grDevices
#' @import stats

picture_size_generate <- function(x){
  format = image_info(x)
  ratio = format$width / format$height
  size1=runif(1.4,1.8,2.8)
  if (format$width > format$height){
    widthsize=size1
    size2= size1 / ratio
    heightsize= size2
  }else{
    heightsize=size1
    size2= size1 * ratio
    widthsize= size2
  }
sizevectors <- c(widthsize, heightsize)
return(sizevectors)
}

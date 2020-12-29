#' Load and apply some transformations to the images
#'
#' This function generates one dobble card with the help of the circlize package.
#' @param x a vector of image numbers
#' @param infolder the folder to read the files from
#' @param file_list
#' @return a picture
#' @import magick
#' @import grDevices
#' @import stats

image_load_transform <- function(x, infolder, file_list){
  pic <- image_read(paste0(infolder,"/",file_list[x]))
  pic <- image_convert(pic, "png", matte=TRUE)
  pic <- image_trim(pic)
  pic <- image_rotate(pic, degrees = sample(c(0,90,180,270),1))
  pic <- image_transparent(pic, "	#FFFFFF", fuzz = 10)
}

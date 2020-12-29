#' Generate one card with ggplot
#'
#' This function generates one dobble card with the help of the circlize package.
#' @param x a vector of card numbers
#' @param infolder the folder to read the files from
#' @param file_list
#' @param positions a dataframe of positions for the images on the graph
#' @return one dobble card as ggplot object
#' @import magick
#' @import ggplot2
#' @import ggforce
#' @import grDevices
#' @import stats
#' @export

generate_one_card <- function(x, infolder, file_list, positions){

  x <- lapply(x, image_load_transform, infolder=infolder, file_list=file_list)

  #randomize the order of the pictures
  x <- sample(x)

  sizevectors <- lapply(x, picture_size_generate)

  circles <- data.frame(x0 = 5.5, y0 = 5.5, r = 5.5)
  rasterlist <- list()
  for(i in 1:8){
    rasterlement <- annotation_raster(x[[i]], xmin=positions$V1[i], xmax = positions$V1[i]+sizevectors[[i]][1], ymin=positions$V2[i], ymax=positions$V2[i]+sizevectors[[i]][2])
    rasterlist <-  append(rasterlist, rasterlement)
  }

  #try with image graph
  pic<- image_graph(width = 800, height = 800, res = 720)
  g<- ggplot(circles) +
    geom_circle(aes(x0 = x0, y0 = y0, r = r))+
    rasterlist[[1]]+
    rasterlist[[2]]+
    rasterlist[[3]]+
    rasterlist[[4]]+
    rasterlist[[5]]+
    rasterlist[[6]]+
    rasterlist[[7]]+
    rasterlist[[8]]+
    theme_void()
  print(g)
  dev.off()
  return(pic)
}

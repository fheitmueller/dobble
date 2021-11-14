#' Generate one card with ggplot
#'
#' This function generates one dobble card with the help of the circlize package.
#' @param x a vector of card numbers
#' @param image_list a list of 57 images
#' @param positions a dataframe of positions for the images on the graph
#' @param shape defines the shape of the card: can be "circle"  (default), "blank" or "rectangle"
#' @return one dobble card as ggplot object
#' @import magick
#' @import ggplot2
#' @import ggforce
#' @import grDevices
#' @import stats
#' @export

generate_one_card <- function(x, image_list, positions, shape="circle"){

  x <- image_list[x]
  # turn the image randomly around
  for (i in seq_along(x)){
    x[[i]] <- image_rotate(x[[i]], degrees = sample(c(0,90,180,270),1))
  }

  #randomize the order of the pictures
  x <- sample(x)

  #generate random sizes for the pictures
  sizevectors <- lapply(x, picture_size_generate)

  rasterlist <- list()
  for(i in 1:8){
    rasterlement <- annotation_raster(x[[i]], xmin=positions$V1[i], xmax = positions$V1[i]+sizevectors[[i]][1], ymin=positions$V2[i], ymax=positions$V2[i]+sizevectors[[i]][2])
    rasterlist <-  append(rasterlist, rasterlement)
  }

  #try with image graph
  if(shape == "circle"){
    circles <- data.frame(x0 = 5.5, y0 = 5.5, r = 5.5)
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
  }

  if (shape == "blank"){
    blank <- data.frame(x=c(1,11), y=c(1,11))
    pic<- image_graph(width = 800, height = 800, res = 720)
    g<- ggplot(blank, aes(x=x, y=y)) +
      geom_blank()+
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
  }

  if (shape == "rectangle"){
    rectangle <- data.frame(x=c(1,11), y=c(1,11))
    pic<- image_graph(width = 800, height = 800, res = 720)
    g<- ggplot(rectangle, aes(xmin =0, xmax = x[2], ymin = 0, ymax= y[2])) +
      geom_rect(color = "black", fill = NA)+
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
  }


  return(pic)
}

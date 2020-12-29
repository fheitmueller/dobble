#' Generate all cards
#'
#' This function generates all dobble cards with the help of the generate one card function
#' @param infolder
#' @param outfolder is the path of a folder in which the 57 created cards are saved
#' @param x is a list of dobble card templates
#' @return a set of dobble cards saved in the outfolder
#' @import magick
#' @import grDevices
#' @import stats
#' @export


generate_all_cards <- function(infolder, saving=FALSE, outfolder){
file_list <- list.files(path=infolder)

  # warnings and errors

  if (length(file_list) < 57){
    stop("Number of pictures is smaller than 57. Make sure that 57 images are in the specified folder")
  }

  if (length(file_list) > 57){
    warning("More than 57 images were supplied. The first 57 images in the folder are used")
  }

  ##create a list of different possible positions within the cell
  positions <- as.data.frame(rbind(
    c(6, 8.5),
    c(8.5, 6),
    c(5.5, 5.5),
    c(7, 4),
    c(5, 2),
    c(3, 1.3),
    c(1.5, 3),
    c(1.5, 6)))
cardlist <- dobble_template()
cardlist <- list(c(1:8), (9:16))

all_cards <- lapply(cardlist, generate_one_card,infolder=infolder, file_list=file_list, positions=positions)

if(saving==TRUE){
  lapply(seq_along(all_cards), function(y, i){image_write(y[[i]], path=paste0(outfolder, "card",i, ".png"))}, y=all_cards)
}

return(all_cards)
}

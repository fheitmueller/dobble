#' Generate all cards
#'
#' This function generates all dobble cards with the help of the generate one card function
#' @param image_list
#' @return a set of dobble cards saved in the outfolder
#' @export


generate_all_cards <- function(image_list){

  # warnings and errors

  if (length(image_list) < 57){
    stop("Number of pictures is smaller than 57. Make sure that 57 images are in the list")
  }

  if (length(image_list) > 57){
    warning("More than 57 images were supplied. The first 57 images in the folder are used")
  }

image_list <- lapply(image_list, image_clean)

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


all_cards <- lapply(cardlist, generate_one_card,image_list=image_list, positions=positions)


return(all_cards)
}

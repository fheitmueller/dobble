#' Folder to cards
#'
#' @param infolder
#' @param outfolder
#' @param output specifies whether each individual card should be saved or whether DINA4 sheets with six cards on each should be saved
#' @return a set of dobble cards saved in the outfolder
#' @import magick
#' @export


folder_to_cards <- function(infolder, outfolder, output="SINGLE"){


file_list <- list.files(path=infolder)

if (length(file_list) < 57){
  stop("Number of pictures is smaller than 57. Make sure that 57 images are in the specified folder")
}


image_list <- lapply(file_list, function(x, y) image_read(paste0(infolder,"/",x[y])))

# turn images into dobble cards
card_list <- generate_all_cards(image_list)

if(output=="SINGLE"){
  lapply(seq_along(all_cards), function(y, i){image_write(y[[i]], path=paste0(outfolder, "card",i, ".png"))}, y=all_cards)
}

if(output=="DINA4"){
sheet_list <- cards_to_A4(card_list)
lapply(seq_along(sheet_list), function(y, i){image_write(y[[i]], path=paste0(outfolder, "sheet",i, ".pdf"), format="pdf")}, y=sheet_list)
}
}

#' Assembling cards on DINA4 sheets
#'
#'@param cardfolder is a folder containing the 57 individual cards
#'@param outfolder is the folder in which the final DIN A4 pdf sheets are saved
#'@return a set of DINA4 sheets with 6 cards on each
#'@import magick
#'@export

cards_to_A4 <- function(cardfolder, outfolder){

  finalcard_list <- list.files(cardfolder)

  for (j in 0:8){
    i <- j*6
    for (k in 1:6){
      pic <- image_read(paste0(cardfolder, "/", finalcard_list[i+k]))
      pic <- image_trim(pic)
      assign(paste('pic',k,sep=''),pic)
    }
    out1 <- image_append(c(pic1,pic2))
    out2 <- image_append(c(pic3,pic4))
    out3 <- image_append(c(pic5,pic6))
    sheet <- image_append(c(out1,out2,out3), stack=TRUE)
    name <- paste0(outfolder,"sheet",j,".pdf")
    image_write(sheet, path=name, format="pdf")
  }
  ##the last three cards
  for (k in 1:3){
    pic <- image_read(paste0(cardfolder, "/", finalcard_list[54+k]))
    pic <- image_trim(pic)
    assign(paste('pic',k,sep=''),pic)
  }
  out1 <- image_append(c(pic1,pic2))
  out2 <- image_append(c(pic3,pic1))
  out3 <- image_append(c(pic2,pic3))
  sheet <- image_append(c(out1,out2,out3), stack=TRUE)
  image_write(sheet, path=paste0(outfolder, "sheet9.pdf"), format="pdf")

}

###join pdfs

#pdf_combine(c("sheet0.pdf", "sheet1.pdf", "sheet2.pdf", "sheet3.pdf", "sheet4.pdf", "sheet5.pdf", "sheet6.pdf", "sheet7.pdf","sheet8.pdf","sheet9.pdf"), output = "joined.pdf")

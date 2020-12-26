
#' dobble_template
#'
#' Creates a list of dobble cards using numbers instead of images
#' @return vector
#' @export
#' @examples
#' dobble_template()

dobble_template <- function(){

n <- 8 ##probably n needs to be 8
listlength <- (n-1)*(n-1)+n
cardlist <- vector(mode = "list", length = listlength)

## first card
card1 <- integer(n)
for (i in 1:n) {
  card1[i] <- i
}
cardlist[[1]] <- card1

## following cards
for (j in 1:(n-1)) {
  card <- integer(n)
  for (k in 0:(n-1)) {
    part <- (n +(n-1)*(j-1) + k)
    card[1]<- 1
    card[k+1]<- part
  }
  cardlist[[j+1]]<- card
}
##following cards afterwards

for (i in 0:(n-2)){
  for (j in 0:(n-2)) {
    card <- integer(n)
    for (k in 0:(n-2)) {
      part <- (n + 1+ (n-1)*k + (i*k+j)%%(n-1)); # Good for n = prime number
      card[1] <- i+2
      card[k+2]<- part
    }
    cardnumber <- n+1+j+((n-1)*i)
    cardlist[[cardnumber]] <- card
  }
}
return(cardlist)
}

#' Create cards
#' @param infolder is the path of a folder which contains 57 images that are used for the creation of the cards
#' @param outfolder is the path of a folder in which the 57 created cards are saved
#' @return a set of dobble cards saved in the outfolder
#' @import magick
#' @import circlize
#' @import png
#' @import grDevices
#' @import stats
#' @export

create_cards <- function(infolder, outfolder){

file_list <- list.files(path=infolder)

if (length(file_list) < 57){
  stop("Number of pictures is smaller than 57. Make sure that 57 images are in the specified folder")
}

if (length(file_list) > 57){
  warning("More than 57 images were supplied. The first 57 images in the folder are used")
}

cardlist <- dobble_template()

##insert until 57
for (i in 1:57){
vec <- cardlist[[i]]
len <- length(vec)
picturelist <- vector(mode = "list", length = len)
for (j in 1:len){
  num <- vec[j]
  picturelist[[j]] <- image_read(file_list[num])
  picturelist[[j]] <- image_convert(picturelist[[j]], "png", matte=TRUE)
  rotation <- sample(c(0,90,180,270),1)
  picturelist[[j]] <- image_trim(picturelist[[j]])
  picturelist[[j]] <- image_rotate(picturelist[[j]], rotation)
  picturelist[[j]] <- image_transparent(picturelist[[j]], "	#FFFFFF", fuzz = 10)
  }

##randomize the order of the pictures
picturelist <- sample(picturelist)

##create a list of different possible positions within the cell
positions<- as.data.frame(cbind(c(0,1.5,2.5,4,5,6.5,8,10), c(0,4, 7, 5, 7, 4, 7, 7)))

pathname <- paste0(outfolder,i,".jpg")
jpeg(file=pathname, width=11, height=11, units="cm", res=800)

circos.par(start.degree = 90)
circos.initialize(letters[1:1], xlim = c(0, 10))
circos.track(ylim = c(0, 10), panel.fun = function(x, y) {
  for (m in 1:8){
    im = picturelist[[m]]
    format = image_info(im)
    ratio = format$width / format$height
    size1=runif(1,1.65,2.3)
    if (format$width > format$height){
widthsize=paste0(size1, "cm")
size2= size1 / ratio
heightsize= paste0(size2, "cm")
    }else{
      heightsize=paste0(size1, "cm")
      size2= size1 * ratio
      widthsize= paste0(size2, "cm")
      }
    circos.raster(im, facing = "downward", positions$V1[m], positions$V2[m], width=widthsize, height=heightsize)
  }
  }, track.height=0.97, bg.border=NA)
draw.sector(0, 360, border = "black")
circos.clear()

dev.off()
}
}

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
        pic <- image_read(finalcard_list[i+k])
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
  pic <- image_read(finalcard_list[54+k])
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

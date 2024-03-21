############### NDVI perception

# Local data: ~/Downloads/sent_cblind/S2A_MSIL2A_20230821T100601_N0509_R022_T32TQS_20230821T163000.SAFE/GRANULE/L2A_T32TQS_A042633_20230821T101414/IMG_DATA/R10m

# Idea for a figure:
# Something simple like an image of a small area – perhaps showing NDVI or temperature? There are many standard visualization colour bars used and the image would look different in each. So for NDVI or thermal could have grey scale, blue-red, brown-green etc etc. Such a simple visualisation might help

library(imageRy)
library(terra)

setwd("~/Downloads/sent_cblind/S2A_MSIL2A_20230821T100601_N0509_R022_T32TQS_20230821T163000.SAFE/GRANULE/L2A_T32TQS_A042633_20230821T101414/IMG_DATA/R10m")
b2 <- rast("T32TQS_20230821T100601_B02_10m.jp2")
b3 <- rast("T32TQS_20230821T100601_B03_10m.jp2")
b4 <- rast("T32TQS_20230821T100601_B04_10m.jp2")
b8 <- rast("T32TQS_20230821T100601_B08_10m.jp2")

sent <- c(b2, b3, b4, b8)
plotRGB(sent[[2]], sent[[4]], sent[[3]])

ndvi <- im.ndvi(sent, 4, 3)
plot(ndvi)

# grey scale, blue-red, brown-green etc etc.
clgr <- colorRampPalette(c("black","dark grey","light grey"))(100)
clbr <- colorRampPalette(c("blue","white","red"))(100)
clbg <- colorRampPalette(c("brown","yellow","green"))(100)

par(mfrow=c(1,3))
plot(ndvi, col=clgr)
plot(ndvi, col=clbr)
plot(ndvi, col=clbg)

############### Color vision simulation - Emma Donini

library(RStoolbox)
library(patchwork)
library(ggplot2)
library(raster)

# Working directory
setwd("~/Documents/cblindplot/paper2")

# Caricare immagini
list <- list.files(pattern="LC09_")
imp <- lapply(list, raster)
imm <- stack(imp)

# Impostare palettes con 8 colori
palraw <- rev(colorRampPalette(c("red", "orange", "yellow", "chartreuse", "cyan",
                             "blue", "deeppink", "red"))(100))
palraw_grey <- rev(colorRampPalette(c("darkgrey", "orange", "yellow", "darkgrey",
                                  "cyan", "blue", "dark green", "darkgrey"))(100))

# Plot

ext <- c(203000, 287000, 69000, 161000)
imm.c <- crop(imm, imm.c <- crop(imm, ext)
plot(imm.c[[4]])  

par(mfrow=c(1, 2))
plot(imm.c[[4]], col=palraw, main="Normal vision")
plot(imm.c[[4]], col=palraw_grey, main="Protanopia")


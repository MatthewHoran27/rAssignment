install.packages("readxl")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("tidyr")
install.packages("treemapify")
install.packages("extrafont")

library("readxl")
library("ggplot2")
library("dplyr")
library("tidyr")
library("treemapify")
library("extrafont")

#A Magma
#B Inferno
#C Plasma
#D Viridis
#E Cividis
#F Rocket
#G Mako
#H Turbo
fill <- "F" #Turbo

#Light theme
ds1_lightBg <- "#fff"
ds1_lightMain <- "#000"

lightTheme_ds1 <- theme(
  plot.background = element_rect(fill = ds1_lightBg),
  panel.background = element_rect(fill = ds1_lightBg),
  legend.background = element_rect(fill = ds1_lightBg),
  
  axis.line = element_line(colour = ds1_lightMain, size = 1.5),
  #axis.title = element_text(colour = ds1_lightMain),
  axis.ticks = element_line(colour = ds1_lightMain),
  
  text = element_text(colour = ds1_lightMain, family = "Comic Sans MS"),
  
  legend.text = element_text(colour = ds1_lightMain, size = 10, face = "bold"),
  legend.title = element_text(colour = ds1_lightMain, size = 12, face = "bold"),
  
  plot.title = element_text(face = "bold"),
  plot.subtitle = element_text(face = "bold")
)

#Dark theme
ds1_darkBg <- "grey45"
ds1_darkMain <- "#fff"

darkTheme_ds1 <- theme(
  plot.background = element_rect(fill = ds1_darkBg),
  panel.background = element_rect(fill = ds1_darkBg),
  legend.background = element_rect(fill = ds1_darkBg),
  
  axis.line = element_line(colour = ds1_darkMain, size = 1.5),
  #axis.title = element_text(colour = ds1_darkMain),
  axis.ticks = element_line(colour = ds1_darkMain),
  
  text = element_text(colour = ds1_darkMain, family = "Comic Sans MS"),
  
  legend.text = element_text(colour = ds1_darkMain, size = 10, face = "bold"),
  legend.title = element_text(colour = ds1_darkMain, size = 12, face = "bold"),
  
  plot.title = element_text(face = "bold"),
  plot.subtitle = element_text(face = "bold")
)

#Select theme
theme_ds1 <- darkTheme_ds1


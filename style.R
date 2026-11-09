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

# Colours
ds1_BG <- "grey45"
ds1_MAIN <- "#cf0"

# The theme, and no, I'm NOT removing the Comic Sans
theme_ds1 <- theme(
  plot.background = element_rect(fill = ds1_BG),
  panel.background = element_rect(fill = ds1_BG),
  legend.background = element_rect(fill = ds1_BG),
  
  axis.line = element_line(colour = ds1_MAIN, size = 1.5),
  #axis.title = element_text(colour = ds1_MAIN),
  axis.ticks = element_line(colour = ds1_MAIN),
  
  text = element_text(colour = ds1_MAIN, family = "Comic Sans MS"),
  
  #legend.text = element_text(colour = ds1_MAIN, size = 10, face = "bold"),
  #legend.title = element_text(colour = ds1_MAIN, size = 12, face = "bold"),
  
  plot.title = element_text(face = "bold"),
  plot.subtitle = element_text(face = "bold")
)

ds1_BG
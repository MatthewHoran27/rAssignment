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
v4_theme_clr_bg <- "grey45"
v4_theme_clr_main <- "#cf0"

# The theme, and no, I'm NOT removing the Comic Sans
theme_v4 <- theme(
  plot.background = element_rect(fill = v4_theme_clr_bg),
  panel.background = element_rect(fill = v4_theme_clr_bg),
  legend.background = element_rect(fill = v4_theme_clr_bg),
  axis.line = element_line(colour = v4_theme_clr_main, size = 1.5),
  #axis.title = element_text(colour = v4_theme_clr_main),
  axis.ticks = element_line(colour = v4_theme_clr_main),
  text = element_text(colour = v4_theme_clr_main, family = "Comic Sans MS"),
  #legend.text = element_text(colour = v4_theme_clr_main, size = 10, face = "bold"),
  #legend.title = element_text(colour = v4_theme_clr_main, size = 12, face = "bold"),
  plot.title = element_text(face = "bold"),
  plot.subtitle = element_text(face = "bold")
)

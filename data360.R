install.packages("readxl")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("tidyr")
install.packages("treemapify")
install.packages("extrafont")
install.packages("OECDdata")
font_import()
loadfonts()
#windowsFonts(`Comic Sans MS` = windowsFont("Comic Sans MS"))

library(readxl)
library(ggplot2)
library(dplyr)
library(tidyr)
library(treemapify)
library(extrafont)
library(OECDdata)


setwd("C:/Users/20093995/Documents/rAssignment/datasets")
ds2 <- read.csv('WB_LPI.csv')


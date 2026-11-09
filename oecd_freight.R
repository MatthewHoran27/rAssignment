install.packages("readxl")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("tidyr")
install.packages("treemapify")
install.packages("extrafont")
install.packages("OECDdata")

library(readxl)
library(ggplot2)
library(dplyr)
library(tidyr)
library(treemapify)
library(extrafont)
library(OECDdata)

# Dataset 1: OECD Transport
url = "https://sdmx.oecd.org/public/rest/data/OECD.ITF,DSD_ST@DF_STFREIGHT,/.Q......?startPeriod=2025-Q2&dimensionAtObservation=AllDimensions&format=csvfilewithlabels"
ds1 <- read.csv(url)
head(ds1)

#ds1Long <- ds1 %>% pivot_longer(cols = c("...4", "...5", "...6", "...7", "...8"))
ds1Rail <- ds1 %>% filter(TRANSPORT_MODE == "RAIL")
ds1Road <- ds1 %>% filter(TRANSPORT_MODE == "ROAD")

# Rail transport '21 - '25 Volume per Quarter
ds1RailColPlot <- ggplot(
  data = ds1Rail,
  mapping = aes(x = TIME_PERIOD, y = OBS_VALUE, fill = REF_AREA)) +
    geom_col() +
    labs(
      title = "Rail transport",
      subtitle = "From '21 to '25",
      x = "Year",
      y = "Volume",
      fill = "Country",
      caption = "Source: OECD"
    ) +
    theme_ds1

ds1Total2025 <- ds1 %>% filter(TIME_PERIOD == 2025 & TRANSPORT_MODE %in% c("COASTAL", "PIPE", "RAIL", "ROAD", "IWW"))

# TODO: FIX
ds1TotalBarPlot <- ggplot(
  data = ds1Total2025,
  mapping = aes(x = REF_AREA, y = OBS_VALUE, fill = TRANSPORT_MODE)) +
  geom_bar(stat = "identity") +
  theme_ds1

# TODO: FIX
ds1TotalWafflePlot <- ggplot(
  data = ds1Total2025,
  mapping = aes(x = OBS_VALUE, y = OBS_VALUE, fill = REF_AREA)) +
    geom_tile(colour = "black", size = 0.5) +
    scale_x_continuous(expand = c(0, 0)) +
    scale_y_continuous(expand = c(0, 0), trans = 'reverse') 

# Pie chart with OBS_VALUE per country
ds1RailPiePlot <- ggplot(
  data = ds1Rail,
  mapping = aes(x = "", y = OBS_VALUE, fill = REF_AREA)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  theme_ds1 +
  labs(
    x = NULL,
    y = NULL
  )

ds1RoadTreemap <- ds1Road %>%
  group_by(REF_AREA) %>%
  summarise(OBS_VALUE = sum(OBS_VALUE, na.rm = TRUE))

# Tree plot diagram for road data
ds1RoadTreePlot <- ggplot(
  data = ds1RoadTreemap,
  mapping = aes(area = OBS_VALUE, fill = REF_AREA, label = REF_AREA)) +
  geom_treemap() +
  geom_treemap_text(colour = "white", place = "centre") +
  theme(legend.position = "none")

# TODO: FIX
ds1TotalTreePlot <- ggplot(
  data = ds1 %>% filter(TIME_PERIOD == 2025 & TRANSPORT_MODE %in% c("COASTAL", "PIPE", "RAIL", "ROAD", "IWW")),
  mapping = aes(area = OBS_VALUE, fill = REF_AREA, group = REF_AREA, label = Transport.mode)) +
    geom_treemap(colour = ds1_BG, size = 3) +
    geom_treemap_text(colour = "white", family = "Comic Sans MS", place = "centre", size = 12) +
    labs(
      title = "Annual freight transport in the Visegrad 4",
      subtitle = "Time period: 2025",
      fill = "Reference\nArea",
      caption = "Units: Millions of tons - Source: OECD"
    ) +
  theme_ds1

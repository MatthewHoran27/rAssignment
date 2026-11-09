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

# Datasets, only the csv is somehow usable
#oecd_freight_v4_excel <- read_xlsx("Data/OECD.ITF,DSD_TRENDS@DF_TRENDSFREIGHT,1.0,filtered,2026-11-06 16-48-03.xlsx", sheet = "Table")
oecd_freight_v4_csv <- read.csv("Data/OECD.ITF,DSD_TRENDS@DF_TRENDSFREIGHT,1.0,filtered,2026-11-06 17-59-33.csv")

#v4_long <- oecd_freight_v4_excel %>% pivot_longer(cols = c("...4", "...5", "...6", "...7", "...8"))

oecd_rail <- oecd_freight_v4_csv %>% filter(TRANSPORT_MODE == "RAIL")
oecd_road <- oecd_freight_v4_csv %>% filter(TRANSPORT_MODE == "ROAD")

# Fairly usable
v4_rail_col_plot <- ggplot(
  data = oecd_rail,
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
    theme_v4

oecd_total_2025 <- oecd_freight_v4_csv %>% filter(TIME_PERIOD == 2025 & TRANSPORT_MODE %in% c("COASTAL", "PIPE", "RAIL", "ROAD", "IWW"))

# usable...kinda
v4_total_bar_plot <- ggplot(
  data = oecd_total_2025,
  mapping = aes(x = REF_AREA, y = OBS_VALUE, fill = TRANSPORT_MODE)) +
  geom_bar(stat = "identity") +
  theme_v4

# completely fucked
v4_total_waffle_plot <- ggplot(
  data = oecd_total_2025,
  mapping = aes(x = OBS_VALUE, y = OBS_VALUE, fill = REF_AREA)) +
    geom_tile(colour = "black", size = 0.5) +
    scale_x_continuous(expand = c(0, 0)) +
    scale_y_continuous(expand = c(0, 0), trans = 'reverse')

# Farily usable
v4_pie_plot <- ggplot(
  data = oecd_rail,
  mapping = aes(x = "", y = OBS_VALUE, fill = REF_AREA)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  theme_v4

v4_treemap_data <- oecd_road %>%
  group_by(REF_AREA) %>%
  summarise(OBS_VALUE = sum(OBS_VALUE, na.rm = TRUE))

# Usable, but plain and generic
v4_road_tree_plot <- ggplot(
  data = v4_treemap_data,
  mapping = aes(area = OBS_VALUE, fill = REF_AREA, label = REF_AREA)) +
  geom_treemap() +
  geom_treemap_text(colour = "white", place = "centre") +
  theme(legend.position = "none")

# only useful one!
v4_total_tree_plot <- ggplot(
  data = oecd_freight_v4_csv %>% filter(TIME_PERIOD == 2025 & TRANSPORT_MODE %in% c("COASTAL", "PIPE", "RAIL", "ROAD", "IWW")),
  mapping = aes(area = OBS_VALUE, fill = REF_AREA, group = REF_AREA, label = Transport.mode)) +
    geom_treemap(colour = v4_theme_clr_main, size = 3) +
    geom_treemap_text(colour = "white", family = "Comic Sans MS", place = "centre", size = 12) +
    labs(
      title = "Annual freight transport in the Visegrad 4",
      subtitle = "Time period: 2025",
      fill = "Reference\nArea",
      caption = "Units: Millions of tons - Source: OECD"
    ) +
  theme_v4

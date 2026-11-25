install.packages("readxl")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("tidyr")
install.packages("treemapify")
install.packages("extrafont")
install.packages("OECDdata")
install.packages("stringr")

library(readxl)
library(ggplot2)
library(dplyr)
library(tidyr)
library(treemapify)
library(extrafont)
library(OECDdata)
library(stringr)

ds2 = read.csv("datasets/WB_LPI.csv")

# Fixing the labels in the INDICATOR_LABEL column (missing ':')
ds2 <- ds2 %>%
  mutate(
    INDICATOR_LABEL = str_replace_all(
      INDICATOR_LABEL,
      "Logistics Performance Index \\(LPI\\) Overall Score",
      "Logistics Performance Index \\(LPI\\): Overall Score"
    )
  )

ds2_2023 = ds2 %>% filter(TIME_PERIOD == 2023)
ds2_2023 = subset(ds2_2023, select = c("REF_AREA", "REF_AREA_LABEL", "INDICATOR", "INDICATOR_LABEL", "UNIT_MEASURE", "TIME_PERIOD", "OBS_VALUE"))

ds2_2023 <- ds2_2023 %>%
  group_by(INDICATOR, INDICATOR_LABEL, REF_AREA) %>%
  summarise(OBS_VALUE = sum(OBS_VALUE, na.rm = TRUE), .groups = "drop")

ds2CZEIndexBarPlot = ggplot(
  data = ds2_2023 %>% filter(INDICATOR != "LPI_OVR" & REF_AREA == "CZE"),
  mapping = aes(x = INDICATOR, y = OBS_VALUE, fill = INDICATOR_LABEL)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = OBS_VALUE), colour = ds1_MAIN, vjust = -1) +
  scale_fill_discrete(
    labels = function(x) sub(".*: ", "", x)) +# shortens the legend labels
  labs(
    title = "Logistics performance indexes - Czechia",
    subtitle = "Time period: 2023",
    caption = "Source: World Bank",
    dictionary = c(
      INDICATOR_LABEL = "Indicator",
      INDICATOR = "Indicator",
      OBS_VALUE = "Value"
    )
  ) +
  theme_ds1 +
  theme(
    axis.text.x = element_blank()
  )

ds2IndexFacetBarPlot = ggplot(
  data = ds2_2023 %>% filter(INDICATOR != "LPI_OVR" & REF_AREA %in% c("CZE", "IRL")),
  mapping = aes(x = INDICATOR, y = OBS_VALUE, fill = INDICATOR_LABEL)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = OBS_VALUE), colour = ds1_MAIN, vjust = -1) +
  scale_fill_discrete(
    labels = function(x) sub(".*: ", "", x)) +# shortens the legend labels
  labs(
    title = "Logistics performance indexes for CZE and IRL",
    subtitle = "Time period: 2023",
    caption = "Source: World Bank",
    dictionary = c(
      INDICATOR_LABEL = "Indicator",
      INDICATOR = "Indicator",
      OBS_VALUE = "Value"
    )
  ) +
  theme_ds1 +
  theme(
    axis.text.x = element_blank()#,
  ) +
  facet_grid(rows = vars(REF_AREA))

# Adding the "CONTINENT" column for grouping by continent
# TODO: Add some sort of default value
ds2ByContinent <- ds2 %>%
  mutate(CONTINENT = case_when(
    REF_AREA %in% ds2EuropeArr ~ "Europe",
    REF_AREA %in% ds2AsiaArr ~ "Asia",
    REF_AREA %in% ds2AfricaArr ~ "Africa",
    REF_AREA %in% ds2NorthAmericaArr ~ "North America",
    REF_AREA %in% ds2SouthAmericaArr ~ "South America",
    REF_AREA %in% ds2OceaniaArr ~ "Oceania"#,
    #is.na(REF_AREA ~ "Unknown")
  ))

ds2ByContinent = subset(ds2ByContinent, select = c("REF_AREA", "REF_AREA_LABEL", "INDICATOR", "INDICATOR_LABEL", "UNIT_MEASURE", "TIME_PERIOD", "OBS_VALUE", "CONTINENT"))

# Removing empty values
ds2ByContinent <- ds2ByContinent[!is.na(ds2ByContinent$OBS_VALUE), ]
ds2ByContinent <- ds2ByContinent[!is.na(ds2ByContinent$CONTINENT), ]

# Grouping the values by continent, getting the AVERAGE values
ds2ByContinentAVG <- ds2ByContinent %>%
  group_by(CONTINENT, INDICATOR, INDICATOR_LABEL, TIME_PERIOD) %>%
  summarise(OBS_VALUE = mean(OBS_VALUE, na.rm = TRUE), .groups = "drop")

# Very useful!
ds2LPIOVRByContinent23Plot <- ggplot(
  data = ds2ByContinentAVG %>% filter(INDICATOR == "LPI_OVR" & TIME_PERIOD == "2023"),
  mapping = aes(x = reorder(CONTINENT, -OBS_VALUE), y = OBS_VALUE)) +
  geom_bar(stat = "identity", fill = ds1_MAIN) +
  geom_text(aes(label = round(OBS_VALUE, 0)), colour = ds1_BG, vjust = 2, size = 4, fill = "red") +
  labs(
    title = "LPI: Overall score average - by continent",
    subtitle = "Time period: 2023",
    caption = "Source: World Bank",
    dictionary = c(
      CONTINENT = "Continent",
      `reorder(CONTINENT, -OBS_VALUE)` = "Continent",
      OBS_VALUE = "Score value"
    )
  ) +
  theme_ds1 +
  theme(
    axis.title.x = element_blank()
  )

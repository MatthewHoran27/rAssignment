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

ds2_2023 = ds2 %>% filter(TIME_PERIOD == 2023)
ds2_2023 = subset(ds2_2023, select = c("REF_AREA", "REF_AREA_LABEL", "INDICATOR", "INDICATOR_LABEL", "UNIT_MEASURE", "TIME_PERIOD", "OBS_VALUE"))
#ds2_2023 %>% mutate(across('INDICATOR_LABEL', str_replace, 'Logistics Performance Index (LPI) Overall Score', 'Logistics Performance Index (LPI): Overall Score'))
# Value fix, label shortening doesn't work otherwise
ds2_2023 <- ds2_2023 %>%
  mutate(
    INDICATOR_LABEL = str_replace_all(
      INDICATOR_LABEL,
      "Logistics Performance Index \\(LPI\\) Overall Score",
      "Logistics Performance Index \\(LPI\\): Overall Score"
    )
  )

ds2_2023 <- ds2_2023 %>%
  group_by(INDICATOR, INDICATOR_LABEL, REF_AREA) %>%
  summarise(OBS_VALUE = sum(OBS_VALUE, na.rm = TRUE), .groups = "drop")

ds2CZEIndexBarPlot = ggplot(
  data = ds2_2023 %>% filter(INDICATOR != "LPI_OVR" & REF_AREA == "CZE"),
  #mapping = aes(x = reorder(INDICATOR, OBS_VALUE), y = OBS_VALUE, fill = INDICATOR_LABEL)) +
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
    axis.text.x = element_blank()#,
    #legend.position = "bottom"
  )

ds2CZEIndexBarPlot

ds2IndexFacetBarPlot = ggplot(
  data = ds2_2023 %>% filter(INDICATOR != "LPI_OVR" & REF_AREA %in% c("CZE", "IRL")),
  mapping = aes(x = INDICATOR, y = OBS_VALUE, fill = INDICATOR_LABEL)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = OBS_VALUE), colour = ds1_MAIN, vjust = -1) +
  scale_fill_discrete(
    labels = function(x) sub(".*: ", "", x)) +# shortens the legend labels
  labs(
    title = "Logistics performance indexes",
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

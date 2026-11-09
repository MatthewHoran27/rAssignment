library(RKaggle)
library(tidyr)
library(dplyr)
library(stringr)

ds1 <- RKaggle::get_dataset("yogape/logistics-operations-database")

ds1Test <- filter(ds1, status %in% c("detention_minutes",
                                     "scheduled_datetime", 
                                     "actual_datetime", 
                                     "location_city", 
                                     "location_state",
                                     "on_time_flag",
                                     "event_type",
                                     ))

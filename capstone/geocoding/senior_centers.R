library(tidyverse)
library(ggmap)
  

senior_centers <- read_csv("~/workspace/found_data_sci/capstone/source_files/Senior_Centers.csv", na = "NA")

colnames(senior_centers) [1:9] = c("program", "site_name","hours","address","city","state","zip","phone","location")

# get distinct list of hours
hours_profile <- distinct(senior_centers, hours, .keep_all = TRUE) %>% select(hours)

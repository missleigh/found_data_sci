library(tidyverse)

# craete a data frame for speed camera locations
redlight_camera_violations <- read_csv("~/workspace/found_data_sci/capstone/datasource/Red_Light_Camera_Violations.csv", na = "NA")
colnames(redlight_camera_violations)  [1] <- "intersection"

# create address joinable column
redlight_camera_violations$address_join <- 
# remove street type from end
  gsub(pattern = "$ ST|$ BLVD| RD|$ DR|$ HWY|$ AVE|$ PARK|$  DRIVE", replacement = "", x = redlight_camera_violations$intersection, ignore.case = TRUE)

# remove street type and "AND " from string
redlight_camera_violations$address_join <- 
  gsub(pattern = " ST AND | BLVD AND | RD AND | DR AND | HWY AND | AVE AND | PARK AND ", replacement = "-", x = redlight_camera_violations$intersection, ignore.case = TRUE)

# remove " AND " from string
redlight_camera_violations$address_join <- 
  gsub(pattern = " AND ", replacement = "-", x = redlight_camera_violations$address_join, ignore.case = TRUE)

# Create new column for City
redlight_camera_violations$city <- "Chicago"

# Get distinct list of redlight camera locations for geocoding
redlight_camera_locations <- redlight_camera_violations %>%
  select(address_join,city) %>%
  distinct()

redlight_camera_locations$geo_lookup <- paste(redlight_camera_locations$address_join,redlight_camera_locations$city) 

View(redlight_camera_locations)

rl_coords <- data_frame(redlight_camera_locations)

View(redlight_camera_violations)


library(tidyverse)

# craete a data frame for speed camera locations
redlight_camera_violations <- read_csv("~/workspace/found_data_sci/capstone/datasource/Red_Light_Camera_Violations.csv", na = "NA")
colnames(redlight_camera_violations)  [1] <- "intersection"

# create address joinable column
redlight_camera_violations$address_join <- 
  gsub(pattern = "$ ST|$ BLVD| RD|$ DR|$ HWY|$ AVE|$ PARK|$  DRIVE", replacement = "", x = redlight_camera_violations$intersection, ignore.case = TRUE) 

redlight_camera_violations$address_join <- 
  gsub(pattern = " ST AND | BLVD AND | RD AND | DR AND | HWY AND | AVE AND | PARK AND ", replacement = "-", x = redlight_camera_violations$intersection, ignore.case = TRUE) 

redlight_camera_violations$address_join <-
  gsub(pattern = " AND ", replacement = "-", x = redlight_camera_violations$address_join, ignore.case = TRUE)

redlight_camera_violations$city <- "Chicago"

View(redlight_camera_violations)


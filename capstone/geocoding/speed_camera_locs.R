library(tidyverse)

# craete a data frame for speed camera locations
speed_camera_locs <- read_csv("~/workspace/found_data_sci/capstone/datasource/Speed_Camera_Locations.csv", na = "NA")
colnames(speed_camera_locs)  [1] <- "street_address"
View(speed_camera_locs)

# create address column without (camera type)
speed_camera_locs$address <- strsplit(speed_camera_locs$street_address, " \\(.*\\)")
speed_camera_locs$camera_type <- "Speed"

# trim street name types from address for join
speed_camera_locs$address_join <- 
  gsub(pattern = " ST| BLVD| RD| DR| HWY| AVE", replacement = "", x = speed_camera_locs$address, ignore.case = TRUE) 

# fix street names so the case matches
speed_camera_locs$address_join <- toupper(speed_camera_locs$address_join)
View(speed_camera_locs)

# write file with violations, violation type and lat lon
write.csv(speed_camera_vio_geo, file="~/workspace/found_data_sci/capstone/updated_files/Speed_Camera_Locations.csv", na="")

# delete column address_join
# within(speed_camera_locs, rm("address_join"))
       
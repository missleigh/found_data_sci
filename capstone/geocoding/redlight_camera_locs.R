library(tidyverse)

# craete a data frame for speed camera locations
redlight_camera_locs <- read_csv("~/workspace/found_data_sci/capstone/datasource/Red_Light_Camera_Locations.csv", na = "NA")
colnames(redlight_camera_locs)  [1] <- "intersection"
View(redlight_camera_locs)

# assign camera type
redlight_camera_locs$camera_type <- "Red Light"

# fix street names so the case matches
redlight_camera_locs$address_join <- toupper(redlight_camera_locs$intersection)
View(redlight_camera_locs)

# replace invalid characters with space
redlight_camera_locs$address_join  <- 
  gsub(pattern = " \\?.*\\)", replacement = " ", x = redlight_camera_locs$address_join, ignore.case = TRUE) 

# write file with violations, violation type and lat lon
write.csv(speed_camera_vio_geo, file="~/workspace/found_data_sci/capstone/updated_files/Redlight_Camera_Locations.csv", na="")

# delete column address_join
# within(redlight_camera_locs, rm("address_join"))

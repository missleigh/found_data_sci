library(ggmap)
library(tidyr)
library(dplyr)

# craete a data frame for speed camera locations
redlight_camera_violations <- read_csv("~/workspace/found_data_sci/capstone/source_files/Red_Light_Camera_Violations.csv", na = "NA")

#replace empty strings with NA
redlight_camera_violations[redlight_camera_violations ==""] = NA

# update colunm names
colnames(redlight_camera_violations) [1:10] = c("intersection", "camera_id","address","violation_date","violations","x_coord","y_coord","latitude","longitude","location")

# check your work
glimpse(redlight_camera_violations)

# add columns for violation type to later join with speed camera data
redlight_camera_violations$violation_type <- "Red Light"

# add column city for lat/lon lookup
redlight_camera_violations$city <- "Chicago"

# create a df for missing lat/lon values to lookup
missing_light_locations <- distinct(redlight_camera_violations, camera_id, address, .keep_all = TRUE) %>%
  filter(is.na(latitude)) %>%
  select(camera_id, address, city)

# add address_city column for geocode function
missing_light_locations$address_city <- paste(missing_light_locations$address,'+',missing_light_locations$city)
# glimpse(missing_light_locations)

# lookup missing lat/lon
missing_light_geo <- geocode(missing_light_locations$address_city)

# bind missing light locations and lat/lon
missing_light_locations_geo <- bind_cols(missing_light_locations, missing_light_geo)

# drop unneeded columns
missing_light_locations_geo <-subset(missing_light_locations_geo, select = -c(address_city, city))

# create new df with 
redlight_violations_geo <- left_join(redlight_camera_violations, missing_light_locations_geo, by="camera_id")

#update column names for lat/lon swap
# setnames(redlight_violations_geo, old = c('address.x','latitude','longitude'), new = c('address','lat_original','lon_original')) 
names(redlight_violations_geo)[3] <- "address"
names(redlight_violations_geo)[8] <- "lat_original"
names(redlight_violations_geo)[9] <- "lon_original"

redlight_violations_geo <- redlight_violations_geo %>% 
  mutate(latitude = ifelse(is.na(lat_original), lat, lat_original)) %>%
  mutate(longitude = ifelse(is.na(lon_original), lon, lon_original))

# remove unneeded columns  
redlight_violations_geo <- subset(redlight_violations_geo, select = -c(address.y,x_coord,y_coord,lat,lon,lat_original,lon_original,location))

glimpse(redlight_violations_geo)

# reorder columns to match speed camera output file
redlight_violations_geo <- redlight_violations_geo[c(3,2,4,5,6,7,8,9,1)]


# write file with violations, violation type and lat lon
write.csv(redlight_violations_geo, file="~/workspace/found_data_sci/capstone/updated_files/red_light_violations_geo.csv", na="")

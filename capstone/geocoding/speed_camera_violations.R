library(ggmap)
library(tidyr)
library(dplyr)


speed_camera_violations <- read_csv("~/workspace/found_data_sci/capstone/datasource/Speed_Camera_Violations.csv")
View(speed_camera_violations)

# rename StreetAddress to remove special character from column name : colnames(speed_camera_violations) [1] <- "StreetAddress"
# rename columns for later union
names(speed_camera_violations) [1:9] = c("address", "camera_id","violation_date","violations","x_coord","y_coord","latitude","longitude","location")

# add a column for violation type and assign Speeding
speed_camera_violations$violation_type <- "Speeding"

# add city for geocoding
speed_camera_violations$city <- 'Chicago'

# get the list of distinct locations
#distinct_locations <- unique(speed_camera_violations$StreetAddress)
#distinct_locations

missing_light_location <- distinct(speed_camera_violations, camera_id, address, .keep_all = TRUE) %>%
  filter(is.na(latitude)) %>%
  select(address, camera_id, city)

missing_light_location$address_city <-paste(missing_light_location$address,'+',missing_light_location$city)

# get the lat/lon for the distinct locations
# speed_coords <- geocode(distinct_locations)
# speed_coords <- c(distinct_locations, geocode(distinct_locations)) -- can I do this?
#speed_coords <- read_csv("~/workspace/found_data_sci/capstone/geocoding/speed_camera_coords.csv")
#View(speed_coords)


# get missing lat/lon  
missing_light_geo <- geocode(missing_light_location$address_city)

# bind lat/lon to camera_id data set
missing_light_geo_new <- bind_cols(missing_light_location,missing_light_geo)

# remove address_city
missing_light_geo_new <- subset(missing_light_geo_new, select = -address_city)


glimpse(speed_camera_violations)
glimpse(missing_light_geo)
glimpse(missing_light_geo_new)

# speed_violations_geo <- merge(speed_camera_violations, missing_light_geo_new, by="camera_id", all=TRUE)
speed_violations_geo <- left_join(speed_camera_violations,missing_light_geo_new, by = "camera_id" )
glimpse(speed_violations_geo)

#remove duplicate fields
speed_violations_geo <- subset(speed_violations_geo, select = -c(address.y, city.y, x_coord, y_coord, location))
glimpse(speed_violations_geo)

# rename columns
# names(speed_violations_geo)[1] <- "address"
# names(speed_violations_geo)[11] <- "city"
View(speed_violations_geo)

# get a sample of 50 rows to test
# mysample <- speed_violations_geo[sample(1:nrow(speed_violations_geo), 50, replace = FALSE),]

#  add new columns for lat/lon 
names(speed_violations_geo)[1] <- "address"
names(speed_violations_geo)[5] <- "lat_original"
names(speed_violations_geo)[6] <- "lon_original"
names(speed_violations_geo)[8] <- "city"

speed_violations_geo <- speed_violations_geo %>% 
  mutate(latitude = ifelse(is.na(lat_original), lat, lat_original)) %>%
  mutate(longitude = ifelse(is.na(lon_original), lon, lon_original))

# remove unneeded columns
speed_violations_geo <- subset(speed_violations_geo, select = -c(lat,lon,lat_original,lon_original))

#  check the updated lat/lon coords camera_id = c("CHI010","CHI064","CHI065","CHI068","CHI069")
# camera_locations_check <- speed_violations_geo %>% 
#  filter (camera_id %in% c("CHI010","CHI064","CHI065","CHI068","CHI069")) %>%
#  select(camera_id, address, latitude, longitude)
# View(camera_locations_check)

# validate lat/lon assignment

# add empty column for union of violations data sets
speed_violations_geo$intersection <- NA

glimpse(speed_violations_geo)


# write file with violations, violation type and lat lon
write.csv(speed_violations_geo, file="~/workspace/found_data_sci/capstone/updated_files/speed_camera_violations_geo.csv", na="")

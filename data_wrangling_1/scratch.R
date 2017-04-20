
# create a dataframe with the 
#loc_coord <- data.frame(distinct_locations, speed_coords)
#colnames(loc_coord) [1] <- "StreetAddress"
#loc_coord
#remove(loc_coord)

speed_camera_vio_geo <- inner_join(speed_camera_violations, loc_coord)


speed_camera_vl <- merge(x = speed_camera_violations, y = speed_coords, by = "StreetAddress", all = TRUE)

# take a sample and test replacing null lat/lon with geocoded values
mySample <- speed_camera_vio_geo[sample(1:nrow(speed_camera_vio_geo), 100, replace = FALSE),]
View(mySample)

mySample$Latitude_2 <- ifelse(!is.na(mySample$Latitude) & )
pe94.person$foo <- ifelse(!is.na(pe94.person$H01) & pe94.person$H01 == 12, 0, pe94.person$H03)

# create new column and coalesce values
mySample$Latitude_2 <- replace(mySample$Latitude, is.na(mySample$Latitude), mySample$lat)
# drop column
within(mySample, rm("Latitude_2")



	library(ggmap)
library(readr)
library(sp)
library(rgdal)
library(httr)
library(jsonlite)
library(dplyr)

# load violations data
speed_camera_violations <- read_csv("~/workspace/found_data_sci/capstone/datasource/Speed_Camera_Violations.csv")
View(speed_camera_violations)

# rename StreetAddress to remove special character from column name
colnames(speed_camera_violations) [1] <- "StreetAddress"

# add Chicago as city
scv_sample$city <- 'Chicago'

# create dataframe of addresses missing latitude
scv_sample <- sqldf("select distinct StreetAddress, CameraId from speed_camera_violations where Latitude is null", row.names=TRUE)
#View(scv_sample)

#Method 2
# create a data frame with only unique camera_ids that also have missing lat/lon 
scv_geo <- speed_camera_violations





# create column with streetAddress + Chicago for geocoding
scv_sample$geo <- paste(scv_sample$StreetAddress,'+',scv_sample$city)

# get missing lat/lon 
scv_geo <- geocode(scv_sample$geo)

# bind lat/lon to address
scv_geo_update <- cbind(scv_sample, scv_geo)

View(scv_geo_update)

# update missing lat/lon in speed_camera_violations

+++++



# add a column for violation type and assign Speeding
speed_camera_violations$violation_type <- "Speeding"

# get the list of distinct locations
distinct_locations <- unique(speed_camera_violations$StreetAddress)
distinct_locations

# get the lat/lon for the distinct locations
# speed_coords <- geocode(distinct_locations)
# speed_coords <- c(distinct_locations, geocode(distinct_locations)) -- can I do this?
speed_coords <- read_csv("~/workspace/found_data_sci/capstone/geocoding/speed_camera_coords.csv")
View(speed_coords)

# save a copy of the locations
# write.csv(speed_coords, file="~/workspace/found_data_sci/capstone/geocoding/speed_camera_coords.csv")

# create a dataframe with the 
loc_coord <- data.frame(distinct_locations, speed_coords)
colnames(loc_coord) [1] <- "StreetAddress"
loc_coord
#remove(loc_coord)

speed_camera_vio_geo <- inner_join(speed_camera_violations, loc_coord)


speed_camera_vl <- merge(x = speed_camera_violations, y = speed_coords, by = "StreetAddress", all = TRUE)

# take a sample and test replacing null lat/lon with geocoded values
mySample <- speed_camera_vio_geo[sample(1:nrow(speed_camera_vio_geo), 100, replace = FALSE),]
View(mySample)

mySample$Latitude_2 <- ifelse(!is.na(mySample$Latitude) & )
pe94.person$foo <- ifelse(!is.na(pe94.person$H01) & pe94.person$H01 == 12, 0, pe94.person$H03)

# create new column and coalesce values
mySample$Latitude_2 <- replace(mySample$Latitude, is.na(mySample$Latitude), mySample$lat)
# drop column
within(mySample, rm("Latitude_2")

# write file with violations, violation type and lat lon
write.csv(speed_camera_vio_geo, file="~/workspace/found_data_sci/capstone/updated_files/Speed_Camera_Violations.csv", na="")



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


library(ggmap)
library(readr)
library(sp)
library(rgdal)
library(httr)
library(jsonlite)

banks <- read_csv(url("https://www.dropbox.com/s/z0el6vfg1vtmxw5/PhillyBanks_sm.csv?dl=1")) 

banksCoords <- geocode(banks$Address)
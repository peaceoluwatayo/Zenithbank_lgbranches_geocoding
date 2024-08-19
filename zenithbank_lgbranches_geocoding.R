# load readxl and tidyverse packages
library(readxl)
library(tidyverse)

# import zenith bank branches data set
zenith_branches <- read_excel("C:/Users/HP/Downloads/zen ith-branches.xlsx")
zenith_branches


# view zenith bank branches data set
view(zenith_branches)

# check the structure of zenith_branches data set
str(zenith_branches)

# check the dimension of zenith_branches data set
dim(zenith_branches)

# setting google API key
Sys.setenv(GOOGLEGEOCODE_API_KEY= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")

# load tigygeocoder package
library(tidygeocoder)

# geocode address to lat/long
geo_code_tbl <- zenith_branches %>%
  tidygeocoder::geocode(
    address = ADDRESS,
    method ="google"
  )

# view geo_code_tbl
view(geo_code_tbl)

# load sf package
library(sf)

# convert geo_code_tbl to sf object with specified coordinates
zenith_branches2 <- geo_code_tbl

zenith_branches_sf <- zenith_branches2 %>%
  st_as_sf(
    coords = c("long", "lat"),
    crs    = 4326
  )

# load leaflet package
library(leaflet)

# create an interactive map of zenith_branches_sf using leaflet package
zenith_branches_sf %>%
  leaflet() %>%
  addProviderTiles (providers$OpenStreetMap, group = "OpenStreetMap") %>%
  addMarkers (label = zenith_branches_sf$LOCATION,
              clusterOptions = markerClusterOptions(),
              popup = ifelse(!is.na(zenith_branches_sf$CITY),
                             zenith_branches_sf$CITY,
                             "Not sure of the branch's location"))


# load mapview package
library(mapview)

# create an interactive map of zenith_branches_sf using mapview package
mapview(zenith_branches_sf)

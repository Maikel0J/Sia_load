# This code takes the dataset of all the netstations and selects the netstions used in the project.
# The selection is plotted on a map.
# The user needs the dataset 'dali_stations.csv' and perhaps needs to change working directory.

library(leaflet)

setwd('D:/NoBackup/sia')

col_classes_dalistations <- c('character', 'character','character','character','character')
dali_stations <- read.csv('dali_stations.csv', sep=';', colClasses = col_classes_dalistations)

project = c('168.5184', '170.553')

#dali_stations <- dali_stations[grepl('168.', dali_stations$STATIONSNUMMER)==TRUE,]
dali_stations <- dali_stations[dali_stations$STATIONSNUMMER %in% project,]

dali_stations$LAT <- gsub('\\.', '', dali_stations$LAT)
dali_stations$LONG <- gsub('\\.', '', dali_stations$LONG)

# http://stackoverflow.com/questions/13863599/insert-a-character-at-a-specific-location-in-a-string
dali_stations$LAT <- gsub('^([0-9]{2})([0-9]+)$', '\\1.\\2', dali_stations$LAT)
dali_stations$LONG <- gsub('^([0-9]{1})([0-9]+)$', '\\1.\\2', dali_stations$LONG)

dali_stations$LAT <- as.numeric(dali_stations$LAT)
dali_stations$LONG <- as.numeric(dali_stations$LONG)

leaflet(data = dali_stations) %>% addTiles() %>%
  addMarkers(~LONG, ~LAT, popup = ~STATIONSNUMMER, label = ~STATIONSNUMMER)



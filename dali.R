# Initialisatie
library(data.table)
library(ggplot2)
library(dplyr)
library(lubridate)

setwd('D:/NoBackup/sia')
rm(list=ls())
gc()



# Inlezen data
bestand <- 'vry.kruuz.csv'

setClass('datum_tijd')
setAs("character","datum_tijd", function(from) as.POSIXct(from, format="%Y-%m-%d %H:%M:%S"))
col_classes <- c('integer', 'factor', 'factor', 'datum_tijd', 'character', 'factor', 'factor', 'datum_tijd', 'datum_tijd')

df <- read.csv(bestand, header=TRUE, sep = ',', colClasses = col_classes, quote="\"")
df$value <- gsub(',', '',df$value)
df$value <- as.numeric(df$value)


# Analyse & bewerken data
str(df)
summary(df)

# Bewerken data
columns_keep <- c('deviceid', 'timestamp', 'value', 'description', 'unit')
df_subset <- df[df$description == 'ActivePower.Sum' , columns_keep]

    # http://stackoverflow.com/questions/10862056/rounding-time-to-nearest-quarter-hour
    #df_subset$timestamp_afgerond <- format(strptime("1970-01-01", "%Y-%m-%d", tz="GMT") + round(as.numeric(df_subset$timestamp)/900)*900,"%Y-%m-%d %H:%M")

#https://rdrr.io/cran/lubridate/man/round_date.html
df_subset$timestamp_afgerond <- ceiling_date(df_subset$timestamp, "15 mins")

# http://stackoverflow.com/questions/30024437/applying-group-by-and-summarise-on-data-while-keeping-all-the-columns-info
df_subset_15mins <- df_subset %>% group_by(timestamp_afgerond) %>%
  filter(timestamp == max(timestamp))

g <- ggplot(data = df_subset_15mins, aes(x = timestamp, y = value)) 
g <- g + geom_line()  
g <- g + theme(panel.border = element_blank(),
               panel.background = element_blank(),
               panel.grid.minor = element_line(colour = "grey90"),
               panel.grid.major = element_line(colour = "grey90"),
               panel.grid.major.x = element_line(colour = "grey90"),
               axis.text = element_text(size = 10),
               axis.title = element_text(size = 12, face = "bold"),
               strip.text = element_text(size = 9, face = "bold")) 
g <- g + labs(x = "Datum", y = "ActivePower.Sum")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
g







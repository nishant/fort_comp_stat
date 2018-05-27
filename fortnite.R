# web app to compare user statistic in Fortnite

# libraries:
library(shiny)
library(shinythemes)
library(dplyr)
library(readr)
library(tidyverse)
library(httr)
library(jsonlite)
library(data.table)


# TRN API key (from Fortnite Tracker)
api_key <- "37081ba2-4aa1-41fd-9239-d299fc47816d"   


# urls for each user
user_url_1 <- "https://api.fortnitetracker.com/v1/profile/pc/nish%20."
user_url_2 <- "https://api.fortnitetracker.com/v1/profile/pc/Raspberry%20Jams"


# get data for each user
request_1 <- GET(user_url_1, add_headers("TRN-Api-Key"= api_key))
result_1 <- content(request_1, "text")
data_1 <- fromJSON(result_1, simplifyDataFrame = TRUE)

request_2 <- GET(user_url_2, add_headers("TRN-Api-Key"= api_key))
result_2 <- content(request_2, "text")
data_2 <- fromJSON(result_2, simplifyDataFrame = TRUE)


# get lifetime stats for each user
lifetime_stats_1 <- as.data.frame(data_1$lifeTimeStats)
lifetime_stats_2 <- data_2$lifeTimeStats



# convert list to data frame
lifetime_stats_1 <- data.frame(t(sapply(lifetime_stats_1,c)))
lifetime_stats_2 <- data.frame(t(sapply(lifetime_stats_2,c)))

# rename cols
names(lifetime_stats_1) <- c("solo_top_10", "duo_top_5", "squad_top_3", "squad_top_6", 
                             "duo_top_12", "solo_top_25", "score", "matches", "wins", 
                             "win_rate", "kills", "kdr")
names(lifetime_stats_2) <- c("solo_top_10", "duo_top_5", "squad_top_3", "squad_top_6", 
                             "duo_top_12", "solo_top_25", "score", "matches", "wins", 
                             "win_rate", "kills", "kdr")
# remove duplicate row
lifetime_stats_1 <-  lifetime_stats_1[-1,]
lifetime_stats_2 <-  lifetime_stats_2[-1,]

# reorder cols
lifetime_stats_1 <- lifetime_stats_1[,c(1,6,2,5,3,4,11,12,9,10,8,7)]
lifetime_stats_2 <- lifetime_stats_2[,c(1,6,2,5,3,4,11,12,9,10,8,7)]

# join tidied lifetime stats for each user
lifetime_joined <- lifetime_stats_1
lifetime_joined<-rbind(lifetime_joined, lifetime_stats_2[1,])

# rename rows
setattr(lifetime_joined, "row.names", c("values_user_1", "values_user_2"))

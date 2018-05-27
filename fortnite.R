# Web  app to compare user statistic in Fortnite


# Libraries:

library(shiny)
library(shinythemes)
library(dplyr)
library(readr)
library(tidyverse)
library(httr)
library(jsonlite)



# Load data
url <- "https://api.fortnitetracker.com/v1/profile/pc/nish%20."
key <- "37081ba2-4aa1-41fd-9239-d299fc47816d"

req <- GET(url, add_headers("TRN-Api-Key"= key))
result <- content(req, "text")
data <- fromJSON(result, simplifyDataFrame = TRUE)

data



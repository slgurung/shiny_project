library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(dplyr)
library(googleVis)
library(leaflet)
library(data.table)
library(geojsonio)
library(maps)


 
df <- read.csv('nys_ps_water_lead.csv')
countyList <- unique(df$county)
districtList <- unique(df$school.district)
schoolList <- unique(df$school)
long = df$school.long
lat = df$school.lat

dtData <- df[c(1,2,3,9,26)]
labelData <- paste(df$school, df$address, df$county, df$school.district, sep = ', ')
df$labelData <- paste(labelData, df$outlet.greater.15ppb, sep = ', Outlets >15ppb = ')

avgAbove15ppb <-  df %>% group_by(county) %>% 
    summarise(avgAbove15ppb = mean(outlet.greater.15ppb)) %>% 
    arrange(desc(avgAbove15ppb))
df_joined <- left_join(df, avgAbove15ppb, by ='county')
df_joined <- df_joined %>% arrange(desc(avgAbove15ppb))


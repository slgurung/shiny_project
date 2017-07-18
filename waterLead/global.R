library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(dplyr)
library(googleVis)
library(leaflet)
library(data.table)

setwd('~/nycds10/shiny_project/waterlead/')
df <- read.csv('nys_ps_water_lead.csv')
countyList <- unique(df$county)
districtList <- unique(df$school.district)
schoolList <- unique(df$school)
long = df$school.long
lat = df$school.lat

dtData <- df[c(1,2,3,9,26)]


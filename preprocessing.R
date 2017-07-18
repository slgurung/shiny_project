setwd('~/nycds10/shiny_project/')
df <- read.csv('water_lead.csv')
colnames(df) <- tolower(colnames(df))
#df1 <- head(df, 4)
schoolLocation = as.character(df$school.location)
countyLocation = as.character(df$county.location)

address = lapply(schoolLocation, function(x) strsplit(x, split = '[\\(\\)]')[[1]][1])
df$address = unlist(address) # need to unlist before write.csv()

longLat = lapply(schoolLocation, function(x) strsplit(x, split = '[\\(\\)]')[[1]][2])
longLatMatrix = sapply(longLat, function(x) strsplit(x, split = ',')[[1]])
options(digits = 16)

longLatMatrix = apply(longLatMatrix,2, FUN=as.numeric)

df$school.lat = longLatMatrix[1, ]
df$school.long = longLatMatrix[2, ]

longLat = lapply(countyLocation, function(x) strsplit(x, split = '[\\(\\)]')[[1]][2])
longLatMatrix = sapply(longLat, function(x) strsplit(x, split = ',')[[1]])

longLatMatrix = apply(longLatMatrix,2, FUN=as.numeric)

df$county.lat = longLatMatrix[1, ]
df$county.long = longLatMatrix[2, ]

df$above15.pct = df$outlet.greater.15ppb/df$outlet.num

write.csv(df, './waterLead/nys_ps_water_lead.csv', row.names = FALSE)



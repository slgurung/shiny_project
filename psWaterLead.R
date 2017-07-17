library(ggplot2)
library(dplyr)
df <- read.csv('water_lead.csv')

g1 <- ggplot(data = df, aes(x = County, y = Outlet.Less.5ppb)) +
    geom_bar(stat = 'identity')


show(g1)    



g2 <- ggplot(data = df, aes(Outlet.Less.5ppb)) +
        geom_histogram(binwidth = 5, aes(fill = County))
show(g2)

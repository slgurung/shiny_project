library(data.table)
library(RSQLite)
fdata <- fread(input = "~/git_proj/shiny_proj/ptcFundamentals.csv",
              sep = ",",
              header = TRUE)


## connect to database
conn <- dbConnect(drv = SQLite(), 
                  dbname = "~/git_proj/shiny_proj/fundamentalsDB")
## write table
dbWriteTable(conn = conn,
             name = "fundamentals",
             value = fdata)
## disconnect
dbDisconnect(conn)


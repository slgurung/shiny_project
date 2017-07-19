# server.R

#shinyServer(
function(input, output, session) {
    # colPal <- colorNumeric(
    #     palette = "red",
    #     domain = df$outlet.num
    #     )
    colPal <- colorNumeric(c('green', 'blue', 'red'), 0:140)
    
    nycounties <- map('county', regions = c('new york'), fill = TRUE, plot = FALSE )
    
    output$map <- renderLeaflet({
        leaflet(df) %>% 
            addProviderTiles("Esri.WorldStreetMap") %>% 
            #addTiles() %>% 
            #addMarkers(lng=-74.0059, lat=40.7128, popup="New York City") %>% 
            addPolygons(data = nycounties, fillColor = heat.colors(6, alpha = 1), stroke = FALSE) %>%
            addCircles(lng = long, lat = lat, weight = 2, radius = ~outlet.greater.15ppb * 10, 
                       label = ~(labelData), color = ~colPal(outlet.greater.15ppb)) %>% 
            setView(lng=-73.832453, lat=40.724160, zoom = 12) 
    })
    
    
    
    # observe({
    #     pal <- colorpal()
    #     
    #     leafletProxy("map", data = filteredData()) %>%
    #         clearShapes() %>%
    #         addCircles(radius = ~10^mag/10, weight = 1, color = "#777777",
    #                    fillColor = ~pal(mag), fillOpacity = 0.7, popup = ~paste(mag)
    #         )
    # })
    
    
    
    observe({
         districtSchool <- df[df$county == input$selectCounty, c("school.district", "school")]
         districts <- unique(districtSchool$school.district)
         schools <- unique(districtSchool$school)
         updateSelectInput(
             session, "selectDistrict",
             choices = districts,
             selected = districts[1]
        )
        updateSelectInput(
            session, "selectSchool",
            choices = schools,
            selected = schools[1]
        )
    })
    
    output$schoolTable <- DT::renderDataTable({
        dtData
    })
    
    countyData <- reactive({
         d <- df %>% 
              filter(Sector == input$selectSector)
    })
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    # output$cleanedData = renderDataTable({
    #     fundamentals
    # })
    # sectorData <- reactive({
    #     d <- fundamentals %>% 
    #         filter(Sector == input$selectSector)
    # })
    # companyData <- reactive({
    #     d <- fundamentals %>% 
    #         filter(Company == input$selectCompany)
    # })
    # bwDf <- reactive({
    #     if (input$selectBW == 'best10'){
    #         d = arrange(tail(bwData, 10), desc(ZScore))
    #     } else{
    #         d = head(bwData, 10)
    #     }
    #     d
    # })
    
    # output$all <- renderPlotly({
    #     #plot_ly(mtcars, x = ~mpg, y = ~wt)
    #     
    #     #plot_ly(diamonds, x = ~carat, y = ~price, color = ~carat,
    #     #        size = ~carat, text = ~paste("Clarity: ", clarity))
    #     #plot_ly(dataInput, x = ~EP, y = ~ZScore)
    #     
    #     plot_ly(fundamentals, y = ~ZScore, color = ~Sector, 
    #             type = "box", boxmean = TRUE, 
    #             marker= list(symbol = "hexagon-open"),
    #             line = list(width = 1),
    #             hoverinfo = 'x+y'
    #     ) %>% 
    #     layout( 
    #         height = 500,
    #         margin = list(t = 0, r = 0, b = 20, l= 35, pad = 0), 
    #         showlegend = FALSE, 
    #         xaxis = list(
    #                     type = "category",
    #                     ticks = "inside",
    #                     showticklabels= TRUE,
    #                     autorange = FALSE,
    #                     tickmode = "auto",
    #                     nticks = 3,
    #                     tickcolor = toRGB("blue")
    #                 )
    #         ) 
    # })
    # output$sector <- renderPlotly({
    #     
    #     p <- sectorData() %>% 
    #             plot_ly(x = ~Ticker, y = ~ZScore, 
    #                     alpha = 0.5, 
    #                     type = 'scatter',
    #                     text = ~Company,
    #                     hoverinfo = 'y + text'
    #                     
    #                     ) 
    #     subplot(
    #             add_markers(p, color = ~factor(ZScore), 
    #                             colors = colorRamp(c("red", "blue"))
    #                     )
    #     ) %>% 
    #         layout(title = input$selectSector,
    #                margin = list(t = 30, r = 0, b = 80, l= 35, pad = 0),
    #                showlegend = FALSE,
    #                yaxis = list(title = "Z-Score", 
    #                             showgrid = FALSE
    #                             ),
    #                xaxis = list(
    #                             showgrid = FALSE
    #                             )
    #              )
    #              
    # })
    # output$company <- renderPlotly({
    #     d <- companyData() #%>% 
    #     p1 <- plot_ly(d, x = ~EP, y = ~ZScore, 
    #                   type = 'bar',
    #                   name = 'Z-Score',
    #                   hoverinfo = 'x+y+name'
    #                   ) %>% 
    #         layout(
    #                 showlegend = FALSE,
    #                 yaxis = list(showgrid = FALSE),
    #                 xaxis = list( 
    #                    type = "date",
    #                    showgrid = FALSE,
    #                    showticklabels = FALSE
    #                 )
    #         )
    #     p2 <- companyData() %>%
    #         plot_ly(x = ~EP, y = ~Close, 
    #                 type = 'scatter',
    #                 marker = list(symbol = 'diamond'),
    #                 opacity = 0.5,
    #                 name = 'Price',
    #                 hoverinfo = 'x+y+name'
    #                 
    #                 ) %>% 
    #         layout(
    #             showlegend = FALSE,
    #             yaxis = list(showgrid = FALSE),
    #             xaxis = list( 
    #                 type = 'date',
    #                 showgrid = FALSE,
    #                 showticklabels = FALSE,
    #                 showline = TRUE
    #                 
    #             )
    #         )
    #     
    #     subplot( p1, p2) %>% 
    #         layout(title = d[1,3],
    #            margin = list(t = 80, r = 60, b = 30, l= 60, pad = 0),
    #            showlegend = FALSE
    #            
    #         )
    #})
    # output$bestworst <- renderPlotly({
    #     d <- bwDf() 
    #         plot_ly(d, x = d$Company, 
    #                 y = d$ZScore, 
    #                 type = 'bar'
    #                 )
    #     
    # })
   
} # end of function

#)
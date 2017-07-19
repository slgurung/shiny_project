# server.R

#shinyServer(
function(input, output, session) {
    # colPal <- colorNumeric(
    #     palette = "red",
    #     domain = df$outlet.num
    #     )
    colPal <- colorNumeric(c('green', 'blue', 'red'), 0:140)
    
    nycounties <- map('county', regions = c('new york'), fill = TRUE, plot = FALSE )
    
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
    
    observe({
        ds <- df %>%  filter(county == input$displayCounty)  %>% 
            select(school.district)
        sdistricts <- unique(ds$school.district)
        # schools <- unique(districtSchool$school)
        updateSelectInput(
            session, "displayDistrict",
            choices = sdistricts,
            selected = sdistricts[1]
        )
        
    })
    
    observe({
        plotUpdate <- df %>%  filter(county == input$plotCounty)  %>% 
            select(school.district)

        schoolsDistrict <- unique(plotUpdate$school.district)

        updateSelectInput(
            session, "plotDistrict",
            choices = schoolsDistrict,
            selected = schoolsDistrict[1]
        )
    })
    
    mySchool <- reactive({
        df %>% 
            filter(county == input$selectCounty & 
                       school == input$selectSchool) #%>% select(c(22,23))
        
        
        
    })
    
    
    
    
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
    observeEvent(input$selectSchool, {
        proxy <- leafletProxy("map")
        myschool <- mySchool()
        #if(input$show) {
            proxy %>% addMarkers(lng = myschool$school.long, lat = myschool$school.lat, layerId = 'a') %>% 
                setView(lng = myschool$school.long, lat = myschool$school.lat , zoom = 12)
        # } else {
             proxy %>% removeShape(layerId = 'a')
        # }
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
    
    output$schoolTable <- DT::renderDataTable({
        df  %>% filter(county == input$displayCounty & school.district == input$displayDistrict) %>% 
                select(c(1,2,3,9,26)) %>% 
                arrange(desc(outlet.greater.15ppb))
    })
    
    output$boxPlot <- renderPlotly({
        df %>% filter(above15.pct != Inf) %>% 
            filter(above15.pct < 1.2) %>% 
            plot_ly(y = ~outlet.greater.15ppb, color = ~county, 
                type = "box", boxmean = TRUE, 
                marker= list(symbol = "hexagon-open")
        ) %>% 
            layout( 
                boxmode = "group",
                height = 510,
                width = 1240,
                margin = list(t = 0, r = 0, b = 60, l= 0, pad = 0), 
                showlegend = FALSE, 
                xaxis = list(
                    type = "category",
                    ticks = "inside",
                    showticklabels= TRUE,
                    autorange = FALSE,
                    tickmode = "auto",
                    nticks = 3,
                    tickcolor = toRGB("blue"),
                    title = 'County'
                ),
                yaxis = list(
                    title = "No. of Outlets >15ppb in each School"
                )
            ) 
    })
     output$densePlot <- renderPlot(
         df %>% filter(above15.pct != Inf) %>% 
             filter(above15.pct < 1) %>% 
             ggplot(aes(x = log(outlet.greater.15ppb), color = county)) +
             geom_density() 

     )

     # output$barPlot <- renderPlot(
     #     df_joined %>% filter(avgAbove15ppb > 20) %>% 
     #         ggplot(aes(outlet.greater.15ppb, fill = county)) +
     #         geom_bar(aes(position = "stack") ) +
     #         xlab("Counties with avg of 20 or more schools with > 15ppb outlets")
     #     
     # )
     output$histPlot <- renderPlot(
         df %>% filter(above15.pct != Inf) %>% 
             filter(above15.pct < 1) %>% 
             mutate(pct = above15.pct * 100) %>% 
             #filter(pct < 100) %>% 
             ggplot(aes(pct)) +
             geom_histogram(aes(fill = county), binwidth = 2) +
             xlab("Percent of outlets with > 15ppb") +
             ylab("Number of schools")
         
     )
     output$bVSpPlot <- renderPlot(
         df %>% filter(above15.pct != Inf) %>% 
             filter(above15.pct < 1.2) %>% 
             ggplot(aes(y = above15.pct, x = org.type)) + 
             geom_boxplot(aes(color = county))  +
             ylab("Percent of outlet with > 15ppb")
     )
    
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
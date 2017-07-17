# server.R

#shinyServer(
function(input, output, session) {
    output$map <- renderLeaflet({
        leaflet(Andrew) %>%
            addProviderTiles("Esri.WorldStreetMap") %>%
            addPolylines(~Long, ~Lat)
    })
    
    # observe({
    #     co <- unique(fundamentals[fundamentals$Sector == input$selectSector, "Company"])
    #     updateSelectizeInput(
    #         session, "selectCompany",
    #         choices = co,
    #         selected = co[1])
    # })
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
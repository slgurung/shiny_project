
navbarPage(strong("Lead in NYS Public Schools' Fountain Water: "), id="nav",
           
    tabPanel("School Map",
        div(class="outer",
                        
            tags$head(
                # connecting to custom CSS
                tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
                        #includeScript("gomap.js")
            ),
                        
            leafletOutput("map", width="100%", height="100%"),
            absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                    draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                    width = 330, height = "400",
                                      
                    h2("School Search"),
                                  
                    selectInput("selectCounty", "County", countyList, selected = 'Queens'),
                    selectInput("selectDistrict", "School District", districtList, selected = 'NYC DOE'),
                    selectInput("selectSchool", "School", schoolList, selected = 'Q221')
                            
                    # plotOutput("histPlt", height = 200),
                    # plotOutput("scatterPlt", height = 250),
                    
            ),
            absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                          draggable = TRUE, top = 60, left = "auto", right = 30, bottom = "auto",
                          width = 400, height = 500,
                          
                          h2(" Introduction"),
                          
                          tags$ul(
                              tags$li(h3("Topic: Lead testing in NYS pulbic school drinking water done during 2016.")),
                              tags$li(h4("Dataset source: https://health.data.ny.gov/Health/Lead-Testing-in-School-Drinking-Water-Sampling-and/rkyy-fsv9.")),
                              tags$li(h4("Brief description of cleaned dataset:")),
                              tags$ul(
                                  tags$li(h4("Number of Schools: 4366 (4603)")),
                                  tags$li(h4("Number of Counties: 62")),
                                  tags$li(h4("Type of School System: BOCES School and  Public School"))
                                  
                              )
                          )
            )
        )
    ),
           
    tabPanel("Dataset",
             
             class = "dataset",
            fluidRow(
                    
                    
                    column(3,
                        selectInput("displayCounty", "NY Counties", countyList, selected = 'Queens')
                    ),
                    column(3,
                        selectInput("displayDistrict", "Districts", districtList, selected = 'NYC DOE')
                        
                    )
                    # column(3,
                    #     conditionalPanel("input.states",
                    #                      selectInput("zipcodes", "Zipcodes", c("All zipcodes"=""), multiple=TRUE)
                    #     )
                    # )
            ),
            fluidRow(
                box(width = 12, 
                    height = "500px",
                    DT::dataTableOutput("schoolTable")
                )
                
            )
    ),
    
    tabPanel("BoxPlot",
             fluidRow(
                 class = 'intro',
                 
                 box(width =  4,
                     height = "90px",
                     selectInput("plotCounty", "County", countyList)
                     
                     
                 ),
                 box(width =  6,
                     height = "90px",
                     
                     selectInput("plotDistrict", "School District", districtList)
                     
                 ),
                     box(width = 12, background = 'blue',
                         height = "550px" ,
                         plotlyOutput("boxPlot")
                     )

             )
   
    ),
    tabPanel("Density",
             fluidRow(
                 class = 'ggPlot',
                
                 # box(width = 1,
                 #     height = 580
                 # ),

                 box(width = 12,
                     height = 580,
                     plotOutput("densePlot", height = 550)
                 )
                 # box(width = 1,
                 #     height = 580 
                 # )

             )

    ),
    tabPanel("Histogram",
             fluidRow(
                 class = 'ggPlot',


                 box(width = 12, background = 'blue',
                     height = 580,
                     plotOutput("histPlot", height = 550)
                 )

             )
    ),
    tabPanel("BOCES vs PS",
             fluidRow(
                 class = 'ggPlot',
                 box(width = 12, background = 'blue',
                     height = 580,
                     plotOutput("bVSpPlot", height = 550)
                 )
             )
    ),
    
    tabPanel( strong("..."),
             fluidRow(
                 box(width = 4
                 ),
                 box(width = 4, 
                     height = 550,
                     br(),
                     br(),
                     h2("Thank You."),
                     br(),
                     h2("... Surya Gurung")
                 )
            )
             
    ),
           
    conditionalPanel("false", icon("crosshair"))
)



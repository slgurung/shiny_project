
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
                            selectInput("selectSchool", "School", schoolList, selected = 'Q221'),
                            
                            plotOutput("hist", height = 200),
                            plotOutput("scatterCollegeIncome", height = 250)
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
    
    tabPanel("Box",
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
                 class = 'intro',


                 box(width = 12,
                     height = "550px" ,
                     plotOutput("densePlot")
                 )
                 # box(width = 4,
                 #     height = "550px" ,
                 #     plotOutput("densePlot")
                 # )

             )

    ),
    tabPanel("Histogram",
             fluidRow(
                 class = 'intro',


                 box(width = 12, background = 'blue',
                     height = "550px" ,
                     plotOutput("barPlot")
                 )

             )

    ),
    
    tabPanel( strong("..."),
             fluidRow(
                 box(width = 4
                 ),
                 
                 box(width = 4, 
                     height = "550px",
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



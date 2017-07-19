
navbarPage(strong("NY Public School Water Fountain:"), id="nav",
           
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
                                      
                            selectInput("selectCounty", "County", countyList),
                            selectInput("selectDistrict", "School District", districtList),
                            selectInput("selectSchool", "School", schoolList),
                            ##########
                            conditionalPanel("input.color == 'superzip' || input.size == 'superzip'",
                                                       # Only prompt for threshold when coloring or sizing by superzip
                                            numericInput("threshold", "SuperZIP threshold (top n percentile)", 5)
                            ),
                           ##########
                            plotOutput("hist", height = 200),
                            plotOutput("scatterCollegeIncome", height = 250)
            )
        )
    ),
           
    tabPanel("Dataset",
            fluidRow(
                    column(3,
                        selectInput("displayCounty", "NY Counties", countyList)
                    ),
                    column(3,
                        conditionalPanel("input.displayCounty",
                                        selectInput("displayDistrict", "Districts", districtList, multiple=TRUE)
                        )
                    ),
                    column(3,
                        conditionalPanel("input.states",
                                         selectInput("zipcodes", "Zipcodes", c("All zipcodes"=""), multiple=TRUE)
                        )
                    )
            ),
            fluidRow(
                    column(1,
                            numericInput("minScore", "Min score", min=0, max=100, value=0)
                    ),
                    column(1,
                            numericInput("maxScore", "Max score", min=0, max=100, value=100)
                    )
            ),
            hr(),
            DT::dataTableOutput("schoolTable")
    ),
    
    tabPanel("EDA",
             fluidRow(
                 class = 'intro',
                     box(width = 12, background = 'blue',
                         height = "550px" 
                     )
                 
             ),
             #hr(),
             fluidRow(
                 #class = 'intro',
                 box(width = 3,
                     height = "90px",
                    
                     
                     sliderInput("slider2", label = "No. of Outlets > 15ppb", min = 0, 
                                 max = 100, value = c(40, 60))
                    
                 ),
                 box(width =  3,
                     height = "50px",
                     selectInput("selectCounty", "County", countyList)
                     #selectInput("selectDistrict", "School District", districtList)
                     #selectInput("selectSchool", "School", schoolList)
                     
                ),
                box(width =  3,
                    height = "50px",
                    #selectInput("selectCounty", "County", countyList),
                    selectInput("selectDistrict", "School District", districtList)
                    #selectInput("selectSchool", "School", schoolList)
                    
                )
                
                 
             )
        
             
    ),
           
    conditionalPanel("false", icon("crosshair"))
)



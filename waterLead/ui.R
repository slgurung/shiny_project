
navbarPage("NY Public School Water Fountain:", id="nav",
           
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
            ),
                        
            tags$div(id="cite",
                     'Data compiled for ', 
                     tags$em('Coming Apart: The State of White America, 1960–2010'), ' by Charles Murray (Crown Forum, 2012).'
            )
        )
    ),
           
    tabPanel("Dataset",
            fluidRow(
                    column(3,
                        selectInput("displayCounty", "NY Counties", countyList)
                    ),
                    column(3,
                        conditionalPanel("input.states",
                                        selectInput("cities", "Cities", c("All cities"=""), multiple=TRUE)
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
           
    conditionalPanel("false", icon("crosshair"))
)



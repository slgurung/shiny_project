
navbarPage("NY Public School Water Fountain:", id="nav",
           
    tabPanel("School Map",
        div(class="outer",
                        
            tags$head(
                # Include our custom CSS
                tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
                        #includeScript("gomap.js")
            ),
                        
            leafletOutput("map", width="100%", height="100%"),
            absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                            draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                            width = 330, height = "auto",
                                      
                            h2("School Search"),
                                      
                            selectInput("color", "County", countyList),
                            selectInput("size", "School District", districtList),
                            selectInput("size", "School", schoolList),
                            conditionalPanel("input.color == 'superzip' || input.size == 'superzip'",
                                                       # Only prompt for threshold when coloring or sizing by superzip
                                            numericInput("threshold", "SuperZIP threshold (top n percentile)", 5)
                            ),
                            plotOutput("histCentile", height = 200),
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
                        selectInput("states", "States", 
                                c("All states"="", structure(state.abb, names=state.name), "Washington, DC"="DC"), 
                                multiple=TRUE
                        )
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
            DT::dataTableOutput("ziptable")
    ),
           
    conditionalPanel("false", icon("crosshair"))
)































# #library(shiny)
# #library(shinydashboard)
# #library(plotly)
# #shinyUI(
#     dashboardPage(
#         #skin = "red",
#         
#         dashboardHeader(
#             disable = TRUE
#                         
#         ),
#         dashboardSidebar(
#             disable = TRUE
#         ),
#         dashboardBody(
#             tags$head(
#                 tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
#             ),
#             class = 'tabMargin',
#             # fluidRow(
#             #     column(
#             #         img(src = "waterfountain.jpg",height = 20, width = "100%"),
#             #         width = 12
#             #         #background = "light-blue"
#             #         #strong("Bankruptcy Predictor")
#             #     )
#             # ),
#             #fluidRow(box(width=12, height = "0px")),
#             fluidRow(
#                 
#                 tabBox(
#                     #title = "Surya Gurung",
#                     # The id lets us use input$tabset1 on the server to find the current tab
#                     id = "tabset1", height = "500px",
#                     width = 12, 
#                     
#                     tags$style(HTML("
#                                     .tabs-above > .nav > li[class=active] > a {
#                                     background-color: #000;
#                                     color: #FFF;
#                                     }")),
#                     
#                     tabPanel("Z-Score",
#                                 class = 'fountain',
#                                 tags$h2("Looking for an employer after Bootcamp?"),
#                                 tags$ul(
#                                     tags$li(h4("If yes, do you want to work for a company who might default within 2 years?")),
#                                     tags$li(h4("If no, then lets talk about Altman's Z-Score.")),
#                                     tags$li(h4("Altman's Z-Score might help you to avoid financially distressed companies."))
#                                 ),
#                                 tags$h3("Datasets"),
#                                 tags$ul(
#                                     tags$li(h4("Kaggle: NYSE S&P 500 Comapanies Historical price with fundamental.")),
#                                     tags$li(h4("'fundamentals.csv': 1781 rows with 79 columns for 448 companies.")),
#                                     tags$li(h4("From SEC 10K annual fillings between 2012-2016.")),
#                                     tags$li(h4("'cf.csv': 1274 rows with 7 columns for 370 companies."))
#                                 )
#                                 
#                                 
#                     ),
#                     tabPanel("Dataset"
#                              #dataTableOutput('cleanedData')      
#                     ),
#                     tabPanel("Features", 
#                              strong("What is Altman's Z-Score?"),
#                              leafletOutput("mymap")    
#                     )
#                     # tabPanel("NYSE: S&P 500",
#                     #     plotlyOutput("all")
#                     # ),
#                     # tabPanel("Industries", 
#                     #          plotlyOutput("sector")         
#                     # ),
#                     # tabPanel("Company", 
#                     #     plotlyOutput("company")         
#                     # ),
#                     # tabPanel("Best & Worst", 
#                     #          plotlyOutput("bestworst")         
#                     # )
#                 )
#                 # box(
#                 #     #title = h4("Bankruptcy Predictor"),
#                 #     background = 'aqua',
#                 #     width = 3, 
#                 #     height = "500px",
#                 #     #dateRangeInput("dates", 
#                 #     #               "Date Range",
#                 #     #               start = "2013-01-01", 
#                 #     #               end = as.character(Sys.Date())),
#                 #     selectizeInput('selectSector', label = h4('Industries'),
#                 #                    choices = fundamentals$Sector, selected = ''
#                 #     ),
#                 #     
#                 #     selectizeInput('selectCompany', label = h4('Company'),
#                 #                    choices = unique(fundamentals$Company), selected = ''
#                 #     ),
#                 #     hr(),
#                 #     br(),
#                 #     radioButtons("selectBW", 
#                 #                     label = h4("Best & Worst"),
#                 #                     choices = list("Best 10" = 'best10', "Worst 10" = 'worst10'),
#                 #                     selected = NULL
#                 #                  )
#                 #     
#                 # )
#             ),
#             fluidRow(
#                 box(width = 12, background = 'blue',
#                     strong("by: Surya Gurung")    
#                 )
#             )
#         )
#             
#             
#     )
# #)
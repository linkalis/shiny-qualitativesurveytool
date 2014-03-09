library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("Qualitative Survey Analysis Tool",
              tags$head(
                tags$script(),
                tags$style(type="text/css",
                           ".highlight { font-weight: bold; }"
                           )
                )
              ),
  
  sidebarPanel(
    
    tabsetPanel(
      
      tabPanel("Search",
               
               p("Wordclouds and charts take up to 20 seconds to load the first time you click on each tab to the right. DO NOT refresh--please be patient!"),
               
               textInput("searchterm", h3("Search for...")),
               
               p("Use the search box to display only responses that contain your specific search term."),
               
               ## Define ROLE list against which you want to be able to sort responses. Currently, this needs to be alphabetic
               ## to avoid strange sorting errors.
               checkboxGroupInput("roleslist", h3("Filter by:"),
                                   c("Continuing Education" = "Continuing Education",
                                     "Faculty" = "Faculty",
                                     "Instructional Staff" = "Instructional Staff",
                                     "Other" = "Other",
                                     "Staff" = "Staff",
                                     "Student" = "Student"
                                   ),
                                  ## Define which ROLES you want to display by default in response tables.
                                   selected = c("Continuing Education", "Faculty", "Instructional Staff", "Other", "Staff", "Student")),
                
                p("Note: This is an experimental tool, so no absolute guarantees for sort or count accuracy."),
                
                p("Powered by R + Shiny.")
               
               ),
      
      tabPanel("Word Counts",
               
               p("Number of times"),
               h4(textOutput("searched")),
               p("occurred in question responses:"),
               
               h4("Q1:"),
               p(textOutput("Q1WordCount")),
               h4("Q2:"),
               p(textOutput("Q2WordCount")),
               h4("Q3:"),
               p(textOutput("Q3WordCount"))
               )
      )
    ),
  
  
  mainPanel(
    tabsetPanel(
      tabPanel("Q1",
               h3("Q1 question text"),
               plotOutput("Q1Cloud"), 
               tableOutput("Q1Table")),
      tabPanel("Q2",
               h3("Q2 question text"),
               plotOutput("Q2Cloud"), 
               tableOutput("Q2Table")),
      tabPanel("Q3",
               h3("Q3 question text"),
               plotOutput("Q3Cloud"), 
               tableOutput("Q3Table"))
    )
  )
))

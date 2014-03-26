library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("Qualitative Survey Analysis Tool"),
  
  sidebarPanel(
    
    tabsetPanel(
      
      tabPanel("Search",
               
               p("Wordclouds and charts take up to 20 seconds to load the first time you click on each tab to the right. DO NOT refresh--please be patient!"),
               
               textInput("searchterm", h3("Search for...")),
               
               p("Use the search box to display only responses that contain your specific search term."),
               
               ## DEFINE ROLE LIST AGAINST WHICH YOU WANT TO BE ABLE TO SORT RESPONSES.  For each Role type, list the full
               ## display name first (e.g. "Democrat"), then the code that represents it in the data (e.g. "Dem").
               checkboxGroupInput("roleslist", h3("Filter by:"),
                                   c("Democrat" = "Dem",
                                     "Republican" = "Rep",
                                     "Other" = "Other"
                                   ),
                                  ## DEFINE WHICH ROLES YOU WANT CHECKED BY DEFAULT for display when the app first loads.
                                   selected = c("Democrat", "Republican", "Other")),
                
                p("Note: This is an experimental tool, so no absolute guarantees for sort or count accuracy."),
                
                p("Powered by R + Shiny.")
               
               ),
      
      tabPanel("Search Word Stats",
               
               p("Number of responses in which"),
               h4(textOutput("searched")),
               p("occurred at least once:"),
               
               h4("Q1:"),
               p(textOutput("Q1WordCount")),
               
               h4("Q2:"),
               p(textOutput("Q2WordCount")),
               
               h4("Q3:"),
               p(textOutput("Q3WordCount")),
               
               ## (e) Add word count(s) for additional questions here, using the same format as above.
               
               
               h4("Related terms:"),
               p(textOutput("relatedTerms"))
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
      
      ## (f) Add tabPanel(s) for additional questions here, using same format as above.
    )
  )
))

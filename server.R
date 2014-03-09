shinyServer(function(input, output) {
  
  ##################################################
  ## SORT & FILTER SURVEY DATA BASED ON UI INPUTS ##
  ##################################################
  
  ## Get list of "Roles" from UI.  This list is 'reactive', so it will adjust as user checks and unchecks which Roles
  ## she wishes to filter in and out of the display.
  Roles <- reactive({
    input$roleslist
  })
  
  ## Filter survey data according to which "Roles" are checked in UI.
  SurveyData <- reactive({
    surveydata[surveydata$Role %in% Roles(), ]
  })
  
  ## Get user-defined search term from UI.
  SearchTerm <- reactive({
    input$searchterm
  })
  
  output$searched <- reactive({
    SearchTerm()
  })
  
  
  ########
  ## Q1 ## 
  ########
  
  ## Render a table that displays all survey responses to Q1.  Table is 'reactive', and will filter on the fly when user 
  ## inputs a search term or changes which Roles are checked in the UI.  For example, if user searches for "constitution", 
  ## this table will re-render to only display responses containing the word "constitution" (non-case-sensitive).  Or if 
  ## user unchecks "Republican", table will re-render and remove all responses labeled with the Role "Rep".
  output$Q1Table <- renderTable({
    search <- grep(SearchTerm(), SurveyData()$Q1, ignore.case = TRUE)
    narrowedSearch <- SurveyData()[search, c("Role","Q1")]
    narrowedSearch[order(narrowedSearch$Role), ]
  })
  
  ## Render a word cloud that displays the frequently-occurring terms across all survey responses to Q1.  Due to processing
  ## limitations, this word cloud is NOT 'reactive'.  It will only render once, representing terms from ALL, unfiltered 
  ## survey responses to Q1.  It will not filter its content based on a user-input search term or which Roles are checked 
  ## in the UI.  To change size of words in the cloud, fiddle around with the numbers in 'scale='.  To change the colors
  ## of words in the cloud, add or remove hex-formatted colors from the list in 'col='.  To change the proportion of words
  ## that are rotated 90 degrees, change the 'rot.per=' variable. 
  output$Q1Cloud <- renderPlot({
    wordcloud(Q1Corpus, scale=c(4,1), min.freq=5, max.words=120, random.order=TRUE, random.color=FALSE, rot.per=.25, colors=c("#FFCC33", "#7A0019"), ordered.colors=FALSE, use.r.layout=FALSE)
  })
  
  ## If user has entered a word/phrase in the search box within the UI, then count the number of survey responses to Q1
  ## where this word/phrase occurred at least once.  Return this value, which is then displayed on the "Word Counts" tab
  ## in the ui.R file.  If no search term has been entered by the user, return "N/A".
  Q1wordcount <- reactive({
    if(SearchTerm()!=""){
      length(grep(SearchTerm(), SurveyData()$Q1, ignore.case = TRUE))
    }else{
      return("N/A")
    }
  })
  
  output$Q1WordCount <- renderText({
    Q1wordcount()
  })
  
  
  ########
  ## Q2 ## 
  ########
  output$Q2Table <- renderTable({
    search <- grep(SearchTerm(), SurveyData()$Q2, ignore.case = TRUE)
    narrowedSearch <- SurveyData()[search, c("Role","Q2")]
    narrowedSearch[order(narrowedSearch$Role), ]
  })
  
  output$Q2Cloud <- renderPlot({
    wordcloud(Q2Corpus, scale=c(4,1), min.freq=5, max.words=120, random.order=TRUE, random.color=FALSE, rot.per=.25, colors=c("#FFCC33", "#7A0019"), ordered.colors=FALSE, use.r.layout=FALSE)
  })
  
  Q2wordcount <- reactive({
    if(SearchTerm()!=""){
      length(grep(SearchTerm(), SurveyData()$Q2, ignore.case = TRUE))
    }else{
      return("N/A")
    }
  })
  
  output$Q2WordCount <- renderText({
    Q2wordcount()
  })
  
  
  ########
  ## Q3 ## 
  ########
  output$Q3Table <- renderTable({
    search <- grep(SearchTerm(), SurveyData()$Q3, ignore.case = TRUE)
    narrowedSearch <- SurveyData()[search, c("Role","Q3")]
    narrowedSearch[order(narrowedSearch$Role), ]
  })
  
  output$Q3Cloud <- renderPlot({
    wordcloud(Q3Corpus, scale=c(4,1), min.freq=5, max.words=120, random.order=TRUE, random.color=FALSE, rot.per=.25, colors=c("#FFCC33", "#7A0019"), ordered.colors=FALSE, use.r.layout=FALSE)
  })
  
  Q3wordcount <- reactive({
    if(SearchTerm()!=""){
      length(grep(SearchTerm(), SurveyData()$Q3, ignore.case = TRUE))
    }else{
      return("N/A")
    }
  })
  
  output$Q3WordCount <- renderText({
    Q3wordcount()
  })
  
  ##########################
  ## ADDITIONAL QUESTIONS ##
  ##########################
  
  ## (c) Add server processing code for additional questions here, using the same format as above.
  
  
})
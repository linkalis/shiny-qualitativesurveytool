shinyServer(function(input, output) {
  
  ##################################################
  ## SORT & FILTER SURVEY DATA BASED ON UI INPUTS ##
  ##################################################
  
  ## Get list of "Roles" from UI
  Roles <- reactive({
    input$roleslist
  })
  
  ## Filter survey data according to which "Roles" are checked in UI
  SurveyData <- reactive({
    surveydata[surveydata$Role %in% Roles(), ]
  })
  
  ## Get search term from UI
  SearchTerm <- reactive({
    input$searchterm
  })
  
  output$searched <- reactive({
    SearchTerm()
  })
  
  
  ########
  ## Q1 ## 
  ########
  output$Q1Table <- renderTable({
    search <- grep(SearchTerm(), SurveyData()$Q1, ignore.case = TRUE)
    narrowedSearch <- SurveyData()[search, c("Role","Q1")]
    narrowedSearch[order(narrowedSearch$Role), ]
  })
  
  output$Q1Cloud <- renderPlot({
    wordcloud(Q1Corpus, scale=c(4,1), min.freq=15, max.words=120, random.order=TRUE, random.color=FALSE, rot.per=.25, colors=c("#FFCC33", "#7A0019"), ordered.colors=FALSE, use.r.layout=FALSE)
  })
  
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
    wordcloud(Q2Corpus, scale=c(4,1), min.freq=15, max.words=120, random.order=TRUE, random.color=FALSE, rot.per=.25, colors=c("#FFCC33", "#7A0019"), ordered.colors=FALSE, use.r.layout=FALSE)
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
    wordcloud(Q3Corpus, scale=c(4,1), min.freq=15, max.words=120, random.order=TRUE, random.color=FALSE, rot.per=.25, colors=c("#FFCC33", "#7A0019"), ordered.colors=FALSE, use.r.layout=FALSE)
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
  
  
})
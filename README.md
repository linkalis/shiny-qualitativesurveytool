Qualitative Survey Analysis Tool
================================
A tool for displaying and sorting responses to qualitative (open-ended) survey questions.  Allows user to quickly search and filter qualitative responses based on a demographic data column, or based on a user-entered phrase or search term.  Also displays wordclouds illustrating frequently-occurring terms within each survey question.

Demo app contains code for displaying responses to three qualitative questions in side-by-side tabs in the main panel of the UI.  If you're feeling adventurous, you can also alter the code and add additional questions to the display.

This tool is powered by R + Shiny.

![app screenshot][app_screenshot.png]



What you need
-------------
* .CSV file containing survey responses
* R (version 2.15.3)
* Shiny library installed in R


### .CSV data file specifications
* **Rows:** each row represents one respondent
* **Data Columns:** columns each represent a question from the survey, and contain qualitative responses from each respondent; formatted as text strings
* **Demographic Sort/"Role" Column:** file contains one demographic column against which you would like to be able to sort reponses; formatted as text strings (For example: democrat vs. republican; male vs. female; freshman vs. sophomore vs. junior vs. senior)



How to run
----------
1. Install and run R.  From within R console, load Shiny library: `library(shiny)`
2. Save the 'shiny-qualitativesurveytool' app directory and its contents within your R working directory.  Note: If you are unsure of where your R working directory is, check `getwd()` from within the R console.
3. Run the app from the R console: `runApp("shiny-qualitativesurveytool/")`
4. Wait a few seconds.  Shiny server process should start within your R console, and app should launch locally within your browser.
5. Go nuts searching and sorting the sample data! 



How to tweak
------------
### Adapt for your data
Read through the code comments for instructions on how to alter the code to point to your own .CSV data file.  You will need to adjust some code in both the **global.R** and the **ui.R** files.  PAY PARTICULAR ATTENTION TO THE INSTRUCTIONS IN ALL CAPS--these are the 'bare minimum' adjustments you need to make to get the app to run using your own data.   


### Add an additional survey question to the app
To add additional survey questions(s) into the app for display, you will need to copy some snippets of the existing code, and paste and tweak them to incorporate the additional question numbers.  The sections you need to tweak are labeled with letters (a)-(e) in the code comments.  Let's say, for example, that you want to add a fourth question to the app.  At the respective code sections, insert the following:

**global.R**
* (a) Define the column number for the question: `names(surveydata)[#] <- "Q4"`
* (b) Add corpus processing code for the question: `Q4Corpus <- cleanCorpus(surveydata$Q4)`

**server.R**
* (c) Add server processing code for the question:

```
output$Q4Table <- renderTable({
    search <- grep(SearchTerm(), SurveyData()$Q4, ignore.case = TRUE)
    narrowedSearch <- SurveyData()[search, c("Role","Q4")]
    narrowedSearch[order(narrowedSearch$Role), ]
  })
  
  output$Q4Cloud <- renderPlot({
    wordcloud(Q4Corpus, scale=c(4,1), min.freq=5, max.words=120, random.order=TRUE, random.color=FALSE, rot.per=.25, colors=c("#FFCC33", "#7A0019"), ordered.colors=FALSE, use.r.layout=FALSE)
  })
  
  Q4wordcount <- reactive({
    if(SearchTerm()!=""){
      length(grep(SearchTerm(), SurveyData()$Q4, ignore.case = TRUE))
    }else{
      return("N/A")
    }
  })
  
  output$Q4WordCount <- renderText({
    Q4wordcount()
  })
  ```

**ui.R**

* (d) Add word count display to the "Word Counts" tabPanel: 
```
h4("Q4:"),
p(textOutput("Q4WordCount"))
```

* (e) Add tabPanel display to the the mainPanel:
```
tabPanel("Q4",
        h3("Q4 question text"),
        plotOutput("Q4Cloud"), 
        tableOutput("Q4Table"))
```


Note: Shiny's ui.R file is very picky about comma placement!  After altering the ui.R file, double-check to make you end up with a comma (,) after *all but the last list item* in each tabPanel and tabsetPanel in the ui.R file.  For more information on formatting and troubleshooting the ui.R file and other Shiny features, see the [Shiny tutorial pages](http://www.rstudio.com/shiny/).



-----
Sample data from: Inaugural Addresses of the Presidents of the United States: http://www.bartleby.com/124/



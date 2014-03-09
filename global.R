######################################
## QUALITATIVE SURVEY ANALYSIS TOOL ##
######################################
## Version: 1.0
## Author: Alison Link, linkalis@gmail.com


## Load required packages
library(shiny)
library(tm)
library(wordcloud)


###############
## READ DATA ##
###############

## Read in survey data. Data must be in .csv format and saved within the Shiny app's directory.
suppressWarnings(surveydata <- read.csv("Mobile_at_UofM.csv", header=TRUE, skip=1, as.is=TRUE, quote="\""))

## Sometimes responses contain unsupported character encoding (for example, if a survey respondents used an unrecognized 
## keyboard setup to submit their respones). This will "break" the UI and cause survey response tables in the Shiny app 
## to render "greyed out".  Some trial and error with the search box can help identify which columns are causing issues.
## Where necessary, remove columns that are messing up character encoding and breaking .CSV read-in.

# surveydata <- surveydata[-1904, ]


##################
## DATA COLUMNS ##
##################

## Select which questions/columns of data to analyze. Assign them column names of Q1...n.
names(surveydata)[118] <- "Q1"
names(surveydata)[119] <- "Q2"
names(surveydata)[160] <- "Q3"


names(surveydata)[164] <- "MobileAssignments"
names(surveydata)[260] <- "Security"
names(surveydata)[275] <- "FaveUMobileTool"
names(surveydata)[276] <- "InnovativeTeachLearn"
names(surveydata)[277] <- "OtherSuggestions"


####################################
## DEMOGRAPHIC SORT/"ROLE" COLUMN ##
##############################

## Does survey contain a demographic column against which you would like to be able to sort reponses?  
## (For example: students vs. faculty vs. staff; male vs. female; freshman vs. sophomore vs. junior vs. senior)
## Define that column here, and name it "Role".  Also deal with empty response rows by assigning them the role of "Other".
names(surveydata)[23] <- "Role"
surveydata$Role[surveydata$Role==""] <- "Other"


###################
## CLEAN CORPORA ##
###################

## Process each data column into a cleaned Corpus: convert to lowercase, remove stopwords, remove punctuation.
## These corpora are then used to render wordcloud plots in server.R file.
processCorpus <- function(col){
  processedCorpus <- Corpus(VectorSource(col))
  processedCorpus <- tm_map(processedCorpus, tolower)
  processedCorpus <- tm_map(processedCorpus, removeWords, stopwords("english"))
  processedCorpus <- tm_map(processedCorpus, removePunctuation)
  return(processedCorpus)
}

Q1Corpus <- processCorpus(surveydata$Q1)
Q2Corpus <- processCorpus(surveydata$Q2)
Q3Corpus <- processCorpus(surveydata$Q3)

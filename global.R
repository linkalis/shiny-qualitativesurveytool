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

## CHANGE THE FILE NAME BELOW TO POINT TO YOUR SURVEY DATA.  Data file must be in .csv format and saved within the 
## Shiny app's directory.  If your file contains a header row, keep 'header=TRUE'.  If your file contains additional 
## 'junk' lines at the top, you can skip them before reading in the data by changing the code below to: 
## 'skip=<# of junk lines in your file>'.
suppressWarnings(surveydata <- read.csv("survey_sample_data.csv", header=TRUE, skip=0, as.is=TRUE, quote="\""))

## Sometimes responses contain unsupported character encoding (for example, if a survey respondent used an unrecognized 
## keyboard setup to submit their responses). This will "break" the UI and cause survey response tables in the Shiny app 
## to render "greyed out".  Some trial and error with the search box can help identify which columns are causing issues.
## Where necessary, remove columns that are messing up character encoding and breaking .CSV read-in by adding them to the
## c(....) list and uncommenting the line below.  For example, here we are removing rows 3 & 8:
# surveydata <- surveydata[c(-3, -8), ]


##################
## DATA COLUMNS ##
##################

## Select which questions/columns from your survey data to display. INSERT RELEVANT COLUMN NUMBERS INTO THE BRACKETS BELOW.  
## (For example: Here, the first question to display is located in column 3 of the .CSV file, the second is in column 4, 
## the third is in column 5.)  Alter these numbers so they correspond to the column numbers within your .CSV data file.
## Then, assign each column a name from Q1...n.  

## You can also add additional questions/columns, as necessary, but it will require some extra copying & pasting of code 
## throughout the global.R, server.R, and ui.R files.  If you choose to display more than the three questions included in 
## this sample app, check documentation to make sure you add all relevant code bits to support additional question displays.
names(surveydata)[3] <- "Q1"
names(surveydata)[4] <- "Q2"
names(surveydata)[5] <- "Q3"

# (a) Define column numbers for additional questions here, using the same format as above.


####################################
## DEMOGRAPHIC SORT/"ROLE" COLUMN ##
####################################

## Does survey contain a demographic column against which you would like to be able to sort reponses?  (For example: 
## democrat vs. republican; male vs. female; freshman vs. sophomore vs. junior vs. senior)  DEFINE THAT COLUMN HERE BY
## INSERTING ITS COLUMN NUMBER INTO THE BRACKETS BELOW.  Then, rename the data column to "Role".  Also deal with empty 
## response rows by assigning them the role of "Other".
names(surveydata)[2] <- "Role"
surveydata$Role[surveydata$Role==""] <- "Other"


###################
## CLEAN CORPORA ##
###################

## Process each data column into a cleaned Corpus: convert to lowercase, remove common English stopwords, 
## remove punctuation.  These corpora are then used to render wordcloud plots in server.R file.
cleanCorpus <- function(col){
  cleanedCorpus <- Corpus(VectorSource(col))
  cleanedCorpus <- tm_map(cleanedCorpus, tolower)
  cleanedCorpus <- tm_map(cleanedCorpus, removeWords, stopwords("english"))
  cleanedCorpus <- tm_map(cleanedCorpus, removePunctuation)
  return(cleanedCorpus)
}

Q1Corpus <- cleanCorpus(surveydata$Q1)
Q2Corpus <- cleanCorpus(surveydata$Q2)
Q3Corpus <- cleanCorpus(surveydata$Q3)

# (b) Add corpus processing code for additional questions here, using same format as above.




#################################
## CREATE DOCUMENT-TERM MATRIX ##
#################################
FullCorpus <- c(Q1Corpus, Q2Corpus, Q3Corpus) ## (c) Add additional question corpora (for example: "Q4Corpus") at the end of this list, separated by commas
FullCorpus <- tm_map(FullCorpus, tolower)
FullCorpus <- tm_map(FullCorpus, removePunctuation)
FullCorpus <- tm_map(FullCorpus, removeWords, stopwords("english"))
FullDTM <- DocumentTermMatrix(FullCorpus)

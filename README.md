Qualitative Survey Analysis Tool
================================
A tool for displaying and sorting responses to qualitative (open-ended) survey questions.  Allows user to quickly search and filter qualitative responses based on a phrase or search term.  Also displays wordclouds illustrating frequently-occurring terms within each survey question.



What you need
-------------
* .CSV file containing survey responses
* R (version 2.15.3)
* Shiny library installed in R


### .CSV Data Specifications
* Rows: each row represents one respondent
* Data Columns: columns contain qualitative responses from each respondent; formatted as text strings
* Demographic Sort/"Role" Column: data contains one demographic column against which you would like to be able to sort reponses; formatted as test strings (For example: students vs. faculty vs. staff; male vs. female; freshman vs. sophomore vs. junior vs. senior)



How to run
----------

runApp("shiny-qualitativesurveytool")






*** Clean & anonymize mobile survey data, or get generic dataset to include for testing ***



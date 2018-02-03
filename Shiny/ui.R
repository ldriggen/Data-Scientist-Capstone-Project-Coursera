# Course: Coursera Data Scientist - Capstone Project
# Author: Larry Riggen
# Creation Date: 2018-01-23
# Purpose: Provide the Shiny user interface for next word prediction app

finalbigram <- readRDS(file="./data/finalbigram.RData")
finaltrigram <- readRDS(file="./data/finaltrigram.RData")
finalquadgram <- readRDS(file="./data/finalquadgram.RData")

suppressPackageStartupMessages(c(
        library(shinythemes),
        library(shiny),
        library(tm),
        library(stringr),
        library(markdown),
        library(stylo)))

shinyUI(navbarPage("Cousera Capstone - Next Word Prediction", 
                   
                   theme = shinytheme("cyborg"),
                   
############################### ~~~~~~~~1~~~~~~~~ ##############################  
## Tab 1 - Prediction

tabPanel("Next Word Prediction",
         

         fluidRow(
                 
                 column(3),
                 column(6,
                        tags$div(textInput("text", 
                                  label = h3("Please enter your text below:"),
                                  value = ),
                        br(),
                        tags$hr(),
                        h4("The predicted next word is"),
                        tags$span(style="color:darkred",
                                  tags$strong(tags$h3(textOutput("predictedWord")))),
                        br(),
                        tags$hr(),
                        h4("The text you have entered so far is:"),
                        tags$em(tags$h4(textOutput("inputText"))),
                        align="center")
                        ),
                 column(3)
         )
),

############################### ~~~~~~~~2~~~~~~~~ ##############################
## Tab 2 - application description

tabPanel("Application Description",

h4("Purpose:"),
p("This application was developed as the capstone project for the Coursera Data Scientist Specialization created by John Hopkins University."),
p("The application attempts to predict the next english word based on an input string. The prediction is based on "),
p("a subset of lines from files of text messages, tweets, and news feeds supplied by SwiftKey. "),
p("Source code for the application can be found at the URL below:"), 
a(href="https://github.com/ldriggen/Data-Scientist-Capstone-Project-Coursera", "https://github.com/ldriggen/Data-Scientist-Capstone-Project-Coursera"),
br(),
br(),
p("Information on the specialization can be found at the URL below:"), 
a(href="https://www.coursera.org/specializations/jhu-data-science", "www.coursera.org/specializations/jhu-data-science")
        
)


)
)

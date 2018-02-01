# Course: Coursera Data Scientist - Capstone Project
# Author: Larry Riggen
# Creation Date: 2018-01-23
# Purpose: Provide the shiny server functions for the next word prediction app

suppressPackageStartupMessages(c(
        library(shinythemes),
        library(shiny),
        library(tm),
        library(stringr),
        library(markdown),
        library(stylo)))

source("./inputCleaner.R")

finalbigram <- readRDS(file="./data/finalbigram.RData")
finaltrigram <- readRDS(file="./data/finaltrigram.RData")
finalquadgram <- readRDS(file="./data/finalquadgram.RData")

shinyServer(function(input, output) {
        
        predictedWord <- reactive({
                text <- input$text
                textInput <- cleanInput(text)
                wordCount <- length(textInput)
                predictedWord <- nextpredictedWord(wordCount,textInput)})
        
        output$predictedWord <- renderPrint(predictedWord())
        output$inputText <- renderText({ input$text }, quoted = FALSE)
})
# Course: Coursera Data Scientist - Capstone Project
# Author: Larry Riggen
# Creation Date: 2018-01-23
# Purpose: Provide the utility functions for the Shiny word prediction app

suppressPackageStartupMessages(c(
        library(shinythemes),
        library(shiny),
        library(tm),
        library(stringr),
        library(markdown),
        library(stylo)))

finalbigram <- readRDS(file="./data/finalbigram.RData")
finaltrigram <- readRDS(file="./data/finaltrigram.RData")
finalquadgram <- readRDS(file="./data/finalquadgram.RData")



dataCleaner<-function(text){
        
        cleanText <- tolower(text)
        cleanText <- removePunctuation(cleanText)
        cleanText <- removeNumbers(cleanText)
        cleanText <- str_replace_all(cleanText, "[^[:alnum:]]", " ")
        cleanText <- stripWhitespace(cleanText)

        return(cleanText)
}

cleanInput <- function(text){
        
        textInput <- dataCleaner(text)
        textInput <- txt.to.words.ext(textInput, 
                                      language="English.all", 
                                      preserve.case = TRUE)
        
        return(textInput)
}


nextpredictedWord <- function(wordCount,textInput){
        
        if (wordCount>=3) {
                textInput <- textInput[(wordCount-2):wordCount] 
                
        }
        
        else if(wordCount==2) {
                textInput <- c(NA,textInput)   
        }
        
        else {
                textInput <- c(NA,NA,textInput)
        }
        
        
        ### 1 ###
        predictedWord <- as.character(finalquadgram[finalquadgram$unigram==textInput[1] & 
                                                          finalquadgram$bigram==textInput[2] & 
                                                          finalquadgram$trigram==textInput[3],][1,]$quadgram)
        
        if(is.na(predictedWord)) {
                predictedWord1 <- as.character(finaltrigram[finaltrigram$unigram==textInput[2] & 
                                                                   finaltrigram$bigram==textInput[3],][1,]$trigram)
                
                if(is.na(predictedWord)) {
                        predictedWord <- as.character(finalbigram[finalbigram$unigram==textInput[3],][1,]$bigram)
                }
        }
        
        
        print(predictedWord)
        
}
# Course: Coursera - Capstone Project
# Author: Larry Riggen
# Creation Date: 2018-01-23
# Purpose: Create bi, tri, and quad grams for input into the Shiny app for next
#          word prediction


# load libraries
library(RWekajars)
library(qdapDictionaries)
library(qdapRegex)
library(qdapTools)
library(RColorBrewer)
library(qdap)
library(NLP)
library(tm)
library(SnowballC)
library(slam)
library(RWeka)
library(rJava)
library(stringr)
library(DT)
library(stringi)



## Read in the SwiftKey datasets
getwd()
blogs <- readLines("./final/en_US/en_US.blogs.txt",encoding = "UTF-8", skipNul=TRUE)
news <- readLines("./final/en_US/en_US.news.txt",encoding = "UTF-8", skipNul=TRUE)
twitter <- readLines("./final/en_US/en_US.twitter.txt",encoding = "UTF-8", skipNul=TRUE)

## Generate a random sapmle from each of the sources
set.seed(2017) # Set seed for reproducibility
sample_size <- 0.02 # Subsample of 2%

blogs_samplelines <- sample(seq_len(length(blogs)),length(blogs)*sample_size)
news_samplelines <- sample(seq_len(length(news)),length(news)*sample_size)
twitter_samplelines <- sample(seq_len(length(twitter)),length(twitter)*sample_size)

blogs_subset <- blogs[blogs_samplelines[]]
news_subset <- news[news_samplelines[]]
twitter_subset <- twitter[twitter_samplelines[]]

# Join the individual samples into one sample
sampleData <- c(blogs_subset,news_subset,twitter_subset)

# Save the sample
writeLines(sampleData, "./savedData/sampleData.txt")


# Read in the saved sample

theSampleCon <- file("./savedData/sampleData.txt")
theSample <- readLines(theSampleCon)
close(theSampleCon)


# Build the corpus, and specify the source to be character vectors 
cleanSample <- Corpus(VectorSource(theSample))

# perform some cleanup to save memory
rm(theSample)
rm(blogs)
rm(news)
rm(twitter)
rm(blogs_samplelines)
rm(news_samplelines)
rm(twitter_samplelines)
rm(blogs_subset)
rm(news_subset)
rm(twitter_subset)

# standardize the character set
cleanSample <- tm_map(cleanSample,
                      content_transformer(function(x) 
                              iconv(x, to="UTF-8", sub="byte")))

# Convert to lower case
cleanSample <- tm_map(cleanSample, content_transformer(tolower))
# remove punction, numbers, URLs, stop, profanity 
cleanSample <- tm_map(cleanSample, content_transformer(removePunctuation))
cleanSample <- tm_map(cleanSample, content_transformer(removeNumbers))
removeURL <- function(x) gsub("http[[:alnum:]]*", "", x) 
cleanSample <- tm_map(cleanSample, content_transformer(removeURL))
cleanSample <- tm_map(cleanSample, stripWhitespace)
bad_words <- read.csv("https://www.cs.cmu.edu/~biglou/resources/bad-words.txt",header =FALSE, strip.white = TRUE, stringsAsFactors = FALSE)
cleanSample <- tm_map(cleanSample, removeWords, bad_words$V1)
cleanSample <- tm_map(cleanSample, stripWhitespace)


# Save the final corpus
save(cleanSample, file = "./savedData/finalCorpus.RDS")




# Create the n-grams

finalCorpus <- load("./savedData/finalCorpus.RDS")
finalCorpusDF <-data.frame(text=unlist(sapply(cleanSample,`[`, 1)), 
                           stringsAsFactors = FALSE)

## Building the tokenization function for the n-grams
ngramTokenizer <- function(theCorpus, ngramCount) {
        ngramFunction <- NGramTokenizer(theCorpus, 
                                Weka_control(min = ngramCount, max = ngramCount, 
                                delimiters = " \\r\\n\\t.,;:\"()?!"))
        ngramFunction <- data.frame(table(ngramFunction))
        ngramFunction <- ngramFunction[order(ngramFunction$Freq, 
                                             decreasing = TRUE),]
        colnames(ngramFunction) <- c("String","Count")
        ngramFunction
}



# Build and save the ngrams
unigram <- ngramTokenizer(finalCorpusDF, 1)
saveRDS(unigram, file = "./savedData/unigram.RDS")
bigram <- ngramTokenizer(finalCorpusDF, 2)
saveRDS(bigram, file = "./savedData/bigram.RDS")
trigram <- ngramTokenizer(finalCorpusDF, 3)
saveRDS(trigram, file = "./savedData/trigram.RDS")
quadgram <- ngramTokenizer(finalCorpusDF, 4)
saveRDS(quadgram, file = "./savedData/quadgram.RDS")


bigram<-readRDS("./savedData/bigram.RDS")
trigram<-readRDS("./savedData/trigram.RDS")
quadgram<-readRDS("./savedData/quadgram.RDS")

finalbigram<-bigram[1:100000,]
unlist_uni<-rep("",nrow(finalbigram))
unlist_bi<-rep("",nrow(finalbigram))
for (i in 1:nrow(finalbigram)){ 
  unlist_uni[i] <-  unlist(strsplit(as.character(finalbigram[i,]$String)," "))[1]      
  unlist_bi[i]<-unlist(strsplit(as.character(finalbigram[i,]$String)," "))[2]
}
finalbigram$unigram <-  unlist_uni
finalbigram$bigram <-   unlist_bi



finaltrigram<-trigram[1:100000,]
unlist_uni<-rep("",nrow(finaltrigram))
unlist_bi<-rep("",nrow(finaltrigram))
unlist_tri<-rep("",nrow(finaltrigram))
for (i in 1:nrow(finaltrigram)){ 
        unlist_uni[i] <-  unlist(strsplit(as.character(finaltrigram[i,]$String)," "))[1]      
        unlist_bi[i]<-unlist(strsplit(as.character(finaltrigram[i,]$String)," "))[2]
        unlist_tri[i]<-unlist(strsplit(as.character(finaltrigram[i,]$String)," "))[3]        
}
finaltrigram$unigram <-  unlist_uni
finaltrigram$bigram <-   unlist_bi
finaltrigram$trigram <-   unlist_tri


finalquadgram<-quadgram[1:100000,]
unlist_uni<-rep("",nrow(finalquadgram))
unlist_bi<-rep("",nrow(finalquadgram))
unlist_tri<-rep("",nrow(finaltrigram))
unlist_quad<-rep("",nrow(finaltrigram))
for (i in 1:nrow(finalquadgram)){ 
        unlist_uni[i] <-  unlist(strsplit(as.character(finalquadgram[i,]$String)," "))[1]      
        unlist_bi[i]<-unlist(strsplit(as.character(finalquadgram[i,]$String)," "))[2]
        unlist_tri[i]<-unlist(strsplit(as.character(finalquadgram[i,]$String)," "))[3]  
        unlist_quad[i]<-unlist(strsplit(as.character(finalquadgram[i,]$String)," "))[4]   
}
finalquadgram$unigram <-  unlist_uni
finalquadgram$bigram <-   unlist_bi
finalquadgram$trigram <-   unlist_tri
finalquadgram$quadgram <-   unlist_quad

saveRDS(finalbigram, file = ".\\..\\Shiny\\data\\finalbigram.RData")
saveRDS(finaltrigram, file = ".\\..\\Shiny\\data\\finaltrigram.RData")
saveRDS(finalquadgram, file = ".\\..\\Shiny\\data\\finalquadgram.RData")

ldfinalbigram <- readRDS(file = ".\\..\\Shiny\\data\\finalbigram.RData")
ldfinaltrigram <- readRDS(file = ".\\..\\Shiny\\data\\finaltrigram.RData")
ldfinalquadgram <- readRDS(file = ".\\..\\Shiny\\data\\finalquadgram.RData")


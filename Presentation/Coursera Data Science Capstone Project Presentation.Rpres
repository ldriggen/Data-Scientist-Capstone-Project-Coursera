Coursera Data Science Capstone Project Presentation
========================================================
author: Larry Riggen  
date: 01-28-2018
autosize: true
This presentation is a pitch for an application to predict the next word given an input string of one or more English words.

To predict the next word, the application uses corupus built from files containg tweets, blogs, and news supplied to the course by SwiftKey. The next word prediction algorithm is built using the text strings in these files.

Application Overview
========================================================


The main goal of this capstone project is to build a shiny application that is able to predict the next word for a given input string.

Using R the following steps were used to create a set of bi, tri and quadgram data frames that can be uset as input to predicted the next work based on an input string.

    - Read in the text sources (tweets, blogs, and news) supplied by SwiftKey.
    - Select a 2% subset of each source
    - Create a corpus from the combined subsets using the tm package
    - Clean the corpus (standardize character set, make lower case, remove numbers, remove profanity,....) 
    - Generate ngrams (uni, bi, tri, and quad) from the corpus using the RWeka and tm packages
    - Create data frames containing top 100,000 bi, tri, and quadgrams
    
The data frames created in the last step above are searched to determine the most likey next word based on the input string (after the string has been cleaned using the same methods used for cleaning and standardizing the corpus)

 

Using the application
=======================================================
Below is a screen shot of the application. The text "Hope" has been typed into the white box under the title "Please enter your text below:". The next predicted word ("you") is displayed under the title "The predicted next word is".

![Caption for the picture.](./Application_image.jpg)

Future Enhancement
========================================================

Listed below the are enhancements that are being developed for the product

    - improve the aesthetics of the user interface
    - reduce the time required to load the ngrams
    - reduce the search time for the next predicted word
    - add tabs for additional languages
    - incorporate any changes suggested by user feedback
    
  
Reference information
========================================================

* This application is hosted on shinyapps.io: [https://ldriggen.shinyapps.io/CourseraDataScienceCapstone](https://nierhoff.shinyapps.io/CourseraDataScienceCapstone)

* The source code and data to generate this application as well as this presentation can be found at [https://github.com/ldriggen/CourseraDataScienceCapstone](https://github.com/ldriggen/CourseraDataScienceCapstone)

* This presentation is hosted at:
[http://rpubs.com/ldriggen/CourseraDataScienceCapstone](http://rpubs.com/ldriggen/CourseraDataScienceCapstone)

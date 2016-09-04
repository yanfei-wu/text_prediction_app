# Capstone-Project-NLP

This project explores data science in the area of natural language processing.    

## Data
The project uses English text data from twitters, blogs, and news. The data is from a corpus called HC Corpora (www.corpora.heliohost.org).   
  
The corpora are collected from publicly available sources by a web crawler. The crawler checks for language, so as to mainly get texts consisting of the desired language. Once the raw corpus has been collected, it is parsed further, to remove duplicate entries and split into individual lines.   

5% of the English text data from the 3 different sources are randomly selected to form a new corpus for the project.

## Exploratory Analysis   
The basic text data information is extracted, including the number of lines, words, characters, etc.     

R library quanteda is used to build basic n-gram (n = 1, 2, 3, 4) models with the new corpus. The document term matrix for each n-gram is constructed to determine the term frequency. The term frequency is visualized with bar charts and word cloud.   

## Prediction & Shiny app  
A backoff algorithm is built to predict the next word based on the existing words using the n-grams. A shiny app is built.  
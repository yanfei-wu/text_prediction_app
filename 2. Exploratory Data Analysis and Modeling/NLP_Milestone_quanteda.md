# Text Predictor for Smart Keyboard_Preliminary
Yanfei Wu  
August 31, 2016  



## Introduction  

As people are spending more and more time on their mobile devices for email, social networking, banking, etc., smart keyboards that can predict and automatically complete the words users are trying to type are of great interest. The goal of this project is to build a predictive text model in the form of a Shiny app using English text data (twitters, news, and blogs) from a corpus called [HC Corpora](http://www.corpora.heliohost.org/).   

This preliminary report (1) explains the major features of the data such as the distribution and relationship between the words, tokens, and phrases in the text; and (2) summarizes my plans for creating the prediction algorithm and Shiny app.   

## Exploratory Analysis  

### 1. Getting and summarizing Data  




```r
# Load data into R
twitter <- readLines('en_US.twitter.txt', encoding = 'UTF-8', skipNul = T)
blog <- readLines('en_US.blogs.txt', encoding = 'UTF-8', skipNul = T)
news <- readLines('en_US.news.txt', encoding = 'UTF-8', skipNul = T)
```

The downloaded text data are loaded into R. Some basic information including the number of lines, characters, words of the dataset can be extracted and is shown in the table below.  








File                  Size (MB)   Line Count   Word Count   Character Count
-------------------  ----------  -----------  -----------  ----------------
en_US.twitters.txt     159.3641      2360148     30433550         162096241
en_US.blogs.txt        200.4242       899288     38222300         206824505
en_US.news.txt         196.2775      1010242     35710849         203223159

### 2. Sampling Data for New Corpus   
As we can see from the table above, the entire dataset is very large which makes any further processing very slow. Because it is actualy not necessary to use all the data for building the algorithms, only 5% of the data from each data source (twitters, news, and blogs) are randomly selected and then combined to build a new corpus.  


```r
# Randomly sample 10% of data from the 3 data sources
set.seed(25)
sampletwitter <- twitter[sample(1:twitter_lines, twitter_lines*0.05)]
sampleblog <- blog[sample(1:blog_lines, blog_lines*0.05)]
samplenews <- news[sample(1:news_lines, news_lines*0.05)]
writeLines(c(sampletwitter, sampleblog, samplenews), 'sample.txt')
rm(twitter, blog, news, sampletwitter, sampleblog, samplenews) # free up memory
```

The statistics of the sampled data is shown in the table below:  


File          Size (MB)   Line Count   Word Count   Character Count
-----------  ----------  -----------  -----------  ----------------
sample.txt     27.55027       213483      5208554          28555992

With this much smaller dataset, a new corpus can be constructed for further model building. After comparing two R libraries, namely **tm** library and **quanteda** library, I found that the latter is significantly faster. Also, it provides a more convenient way for pre-processing. Therefore, **quanteda** library is chosen to build the new corpus and to perform the steps described in the next section.


```r
# Create new corpus with the sampled data 
corpus <- corpus(sample)
```

### 3. N-gram Tokenization and Summary Statistics  

With the new corpus constructed, the next step is to build a basic n-gram model. [N-gram](https://en.wikipedia.org/wiki/N-gram#n-gram_models) is a continuous sequence of n items from a given sequence of text or speech, in this case the corpus from twitter, blogs and news data. For example, a 2-gram is a sequence of 2 words.   

Here, n from 1 to 4 are chosen to create 4 different n-grams using the **quanteda** library. The process includes:    
  
  a. Tokenization: break out the corpus text up into words (n words for n-gram).   
  b. Creating document-term matrix for each n-gram: construct matrices to describe the frequency of the word or n-word combination that occurs in the corpus.   

Note that the corpus needs to be pre-processed for tokenization and document-term matrix construction. The **quanteda** library allows us to pass common pre-processing arguments to the *tokenize()* function. The pre-processing in this case includes: 

  * removing numbers  
  * removing punctuation  
  * removing symbols  
  * removing Separators  
  * removing twitter characters (@ and #)  
  * removing hyphens  
  * revoming URLs  


```r
# N-gram tokenization & document-term matrix construction

# 1-gram
Uni_token <- tokenize(corpus, removePunct = T, removeSymbols = T, removeSeparators = T, removeTwitter = T, 
                      removeHyphens = T, removeURL = T, ngrams = 1, verbose = F)
Uni_dfm <- dfm(Uni_token)
```

```
## 
##    ... indexing documents: 213,483 documents
```

```
## 
##    ... indexing features:
```

```
## 131,234 feature types
```

```
## 
```

```
##    ... created a 213483 x 131235 sparse dfm
##    ... complete. 
## Elapsed time: 3.52 seconds.
```

```r
# 2-gram
Bi_token <- tokenize(corpus, removePunct = T, removeSymbols = T, removeSeparators = T, removeTwitter = T, 
                     removeHyphens = T, removeURL = T, ngrams = 2, concatenator = ' ', verbose = F)
Bi_dfm <- dfm(Bi_token)
```

```
## 
##    ... indexing documents: 213,483 documents
```

```
## 
##    ... indexing features:
```

```
## 1,610,202 feature types
```

```
## 
```

```
##    ... created a 213483 x 1610203 sparse dfm
##    ... complete. 
## Elapsed time: 5.81 seconds.
```

```r
# 3-gram
Tri_token <- tokenize(corpus, removePunct = T, removeSymbols = T, removeSeparators = T, removeTwitter = T, 
                      removeHyphens = T, removeURL = T, ngrams = 3, concatenator = ' ', verbose = F)
Tri_dfm <- dfm(Tri_token)
```

```
## 
##    ... indexing documents: 213,483 documents
```

```
## 
##    ... indexing features:
```

```
## 3,449,394 feature types
```

```
## 
```

```
##    ... created a 213483 x 3449395 sparse dfm
##    ... complete. 
## Elapsed time: 7.15 seconds.
```

```r
# 4-gram
Quadri_token <- tokenize(corpus, removePunct = T, removeSymbols = T, removeSeparators = T, removeTwitter = T, 
                         removeHyphens = T, removeURL = T, ngrams = 4,  concatenator = ' ', verbose = F)
Quadri_dfm <- dfm(Quadri_token)
```

```
## 
##    ... indexing documents: 213,483 documents
```

```
## 
##    ... indexing features:
```

```
## 4,173,563 feature types
```

```
## 
```

```
##    ... created a 213483 x 4173564 sparse dfm
##    ... complete. 
## Elapsed time: 12.5 seconds.
```

With the document-term matrices, we can find out terms with top frequency in the corpus for each n-gram model. The results are shown in the plots below:    



<img src="NLP_Milestone_quanteda_files/figure-html/frequency plot-1.png" style="display: block; margin: auto;" />

We can also visualize the frequency of the terms using word clouds using the *plot()* function which passes arguments through to *wordcloud()* function in the **wordcloud** package in R. For example, the word cloud of uni-gram for the top 100 words is shown below with the more frequent words having larger size.   

<img src="NLP_Milestone_quanteda_files/figure-html/word cloud-1.png" style="display: block; margin: auto;" />

From the bar plots and the word cloud, we find that the terms with the highest frequency are mainly the stopwords, such as 'the', 'and'...It is probably necessary to remove these stopwords for our model. But on the other hand, they are a significant portion of our daily word libraries. So, removing them might not be helpful if the goal is to build a smart keyboard for mobile devices.  

## Summary and Next Steps  

So far, a basic n-gram model has been built to help us understand the relationship between the words. The next steps would be to:    

  1. build a predictive model based on the n-grams to predict the next word based on the previous 1, 2, or 3 words
  2. evaluate and improve the efficiency of the predictive model
  3. explore new models and data to improve the predictive model  
  4. create a Shiny App that accepts an n-gram and predicts the next word  



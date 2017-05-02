# text_prediction_app

This project explores natural language processing techniques and builds a predictive text model in the form of a Shiny app using English text data (twitters, news, and blogs). 

## Data   
The project uses English text data from twitters, blogs, and news. The dataset was obtained from a corpus called [HC Corpora](www.corpora.heliohost.org). The corpora were collected from publicly available sources by a web crawler. The crawler checked for language, so as to mainly get texts consisting of the desired language. Once the raw corpus was collected, it was parsed further to remove duplicate entries and split into individual lines.   

Each text data file (twitters, blogs, news) is abot 200 MB, containing about 30-40 million words. For the purpose of this project, 5% of each text data from the 3 different sources are randomly selected to form a new corpus.

## Exploratory Analysis   

The basic text data information is extracted, including the number of lines, words, characters, etc. R library `quanteda` is used to build basic n-gram (n = 1, 2, 3, 4) models with the new corpus. The document term matrix for each n-gram is constructed with the preprocessed corpus to determine the term frequency. The term frequency is visualized with bar charts and word cloud.   

## Prediction model, Shiny app & slide deck  
A backoff algorithm is built to predict the next word based on the existing words using the n-grams. In particular, the prediction starts with 4-gram by matching the last three words of the user input to the first three words of the 4-grams. It outputs the last word of the 4-grams whenever there is a match. It also calculates the frequency of that word (1/total number of matches).

The algorithm then backoffs to 3-gram and 2-gram to find the possible last words similarly. In these cases, the calculated frequency of the potential word is multiplied by a factor (0.4 for 3-gram, and 0.4 * 0.4 for 2-gram). The maximum likelihood estimate (MLE) of each candicate word is calculated with its overall frequency, and words with the largest MLE are selected as the output.

A shiny app is built and can be accessed [here](https://yanfei-wu.shinyapps.io/text_predictor/).  
A slide deck about this project and the app can be found [here](http://rpubs.com/ywu/206764).  


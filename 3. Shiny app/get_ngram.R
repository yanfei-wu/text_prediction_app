## Create n-gram

library(quanteda)
library(dplyr)

# read sample text and build corpus
sample <- readLines('sample.txt', encoding = 'UTF-8', skipNul = T)
sample <- tolower(sample)
corpus <- corpus(sample)
rm(sample)

# N-gram tokenization & document-term matrix construction
dfm_ngram <- function(n) {
  token_ngram <- function(n) {tokenize(corpus, removeNumbers = T, removePunct = T, removeSymbols = T, removeSeparators = T, removeTwitter = T, 
                                       removeHyphens = T, removeURL = T, ngrams = n, concatenator = ' ', verbose = F)}
  dfm_ngram <- dfm(token_ngram(n))
} 

# Build sorted frequency table (frequency descending)
df_ngram <- function(n) {
  matrix_ngram <- function(n) {as.matrix(colSums(sort(dfm_ngram(n))))}
  df_ngram <- data.frame(word = rownames(matrix_ngram(n)), freq = matrix_ngram(n)[, 1], stringsAsFactors = F)
}

# Modify the frequency tables. 
# Split the terms in the frequency table, e.g., first word + second word for 2-gram, first two words + third word for 3-gram... but keep the original order of the data frame

split_ngram <- function(n) {strsplit(df_ngram$word, split = ' ')}

# 1-gram
df_1gram <- df_ngram(1)
df_1gram <- df_1gram %>% filter(freq >= 1)
write.csv(df_1gram, 'unigram.csv', row.names = F)
unigram <- read.csv('unigram.csv', stringsAsFactors = F)
saveRDS(unigram, 'unigram.RData')

# 2-gram 
df_2gram <- df_ngram(2)
split_2gram <- strsplit(df_2gram$word, split = ' ')
df_2gram <- df_2gram %>% mutate(first = sapply(split_2gram, '[[', 1), last = sapply(split_2gram, '[[', 2)) %>% 
  select(first, last, freq) %>% filter(freq >= 1)
write.csv(df_2gram, 'bigram.csv', row.names = F)
bigram <- read.csv('bigram.csv', stringsAsFactors = F)
saveRDS(bigram, 'bigram.RData')

# 3-gram 
df_3gram <- df_ngram(3)
split_3gram <- strsplit(df_3gram$word, split = ' ')
df_3gram <- df_3gram %>% 
  mutate(first = paste(sapply(split_3gram, '[[', 1), sapply(split_3gram, '[[', 2), sep = ' '), 
         last = sapply(split_3gram, '[[', 3)) %>% select(first, last, freq) %>% filter(freq >= 1)
write.csv(df_3gram, 'trigram.csv', row.names = F)
trigram <- read.csv('trigram.csv', stringsAsFactors = F)
saveRDS(trigram, 'trigram.RData') 

# 4-gram 
df_4gram <- df_ngram(4)
split_4gram <- strsplit(df_4gram$word, split = ' ')
df_4gram <- df_4gram %>% 
  mutate(first = paste(sapply(split_4gram, '[[', 1), sapply(split_4gram, '[[', 2), sapply(split_4gram, '[[', 3), sep = ' '), 
         last = sapply(split_4gram, '[[', 4)) %>% select(first, last, freq) %>% filter(freq >= 1)
write.csv(df_4gram, 'quadrigram.csv', row.names = F)
quadrigram <- read.csv('quadrigram.csv', stringsAsFactors = F)
saveRDS(quadrigram, 'quadrigram.RData') 

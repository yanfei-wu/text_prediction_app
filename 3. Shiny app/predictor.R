library(quanteda)

# read sample text and build corpus
sample <- readLines('sample.txt', encoding = 'UTF-8', skipNul = T)
sample <- tolower(sample)
corpus <- corpus(sample)
rm(sample)

# N-gram tokenization & document-term matrix construction
dfm_ngram <- function(n) {
  token_ngram <- function(n) {tokenize(corpus, removePunct = T, removeSymbols = T, removeSeparators = T, removeTwitter = T, 
                                       removeHyphens = T, removeURL = T, ngrams = n, concatenator = ' ', verbose = F)}
  dfm_gram <- dfm(token_ngram(n))
} 

# Build sorted frequency table (frequency descending)
df_ngram <- function(n) {
  matrix_ngram <- function(n) {as.matrix(colSums(sort(dfm_ngram(n))))}
  df_ngram <- data.frame(word = rownames(matrix_ngram(n)), freq = matrix_ngram(n)[, 1], stringsAsFactors = F)
}

# Modify the frequency tables. Split the terms in the frequency table, e.g., first word + second word for 2-gram, first two words + third word for 3-gram... but keep the original order of the data frame

split_ngram <- function(n) {strsplit(df_ngram$word, split = ' ')}

# 2-gram 
df_2gram <- df_ngram(2)
df_2gram <- df_2gram %>% mutate(first = sapply(split_ngram(2), '[[', 1), last = sapply(split_ngram(2), '[[', 2)) %>% filter(freq >= 1)
write.csv(df_2gram, 'bigram.csv', row.names = F)
bigram <- read.csv('bigram.csv', stringsAsFactors = F)
saveRDS(bigram, 'bigram.RData')

# 3-gram 
df_3gram <- df_ngram(3)
df_3gram <- df_3gram %>% 
  mutate(first = paste(sapply(split_ngram(3), '[[', 1), sapply(split_ngram(3), '[[', 2), sep = ' '), 
         last = sapply(split_ngram(3), '[[', 3)) %>% 
  filter(freq >= 1)
write.csv(df_3gram, 'trigram.csv', row.names = F)
bigram <- read.csv('trigram.csv', stringsAsFactors = F)
saveRDS(bigram, 'trigram.RData') 

# 4-gram 
df_4gram <- df_ngram(4)
df_4gram <- df_4gram %>% 
  mutate(first = paste(sapply(split_ngram(3), '[[', 1), sapply(split_ngram(3), '[[', 2), sapply(split_ngram(3), '[[', 3), sep = ' '), 
         last = sapply(split_ngram(3), '[[', 4)) %>% 
  filter(freq >= 1)
write.csv(df_4gram, 'quadrigram.csv', row.names = F)
bigram <- read.csv('quadrigram.csv', stringsAsFactors = F)
saveRDS(bigram, 'quadrigram.RData') 


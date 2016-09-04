library(quanteda)
library(dplyr)

quadrigram <- readRDS("quadrigram.RData")
trigram <- readRDS("trigram.RData")
bigram <- readRDS("bigram.RData")

predict <- function(input) {
  # Clean user input
  input <- tolower(input)
  input <- unlist(tokenize(input, removeNumbers = T, removePunct = T, removeSymbols = T, removeSeparators = T, removeTwitter = T, 
                           removeHyphens = T, removeURL = T, ngrams = 1, concatenator = ' ', verbose = F))
  
  # Stupid Backoff Algorithm
  # 1. Check if the last 3 words of user input match the first 3 words of quadrigram table, output the matches 
  # 2. If not, check if the last 2 words of user input match the first 2 words of trigram table, output the matches 
  # 3. Also check if the last word of user input match the first word of bigram table, output the match
  # 4. For 1-3, caculate the MLE scores for all candidate words. The probability of the word is multiplied by 0.4 to the power of backoff numbers.
  
  
  input3 <- paste(tail(input, 3), collapse = ' ')
  sub4 <- subset(quadrigram, first == input3)
  sub4$freq <- round(sub4$freq/nrow(sub4), 3)
  sub4 <- select(sub4, last, freq4 = freq)
  
  input2 <- paste(tail(input, 2), collapse = ' ')
  sub3 <- subset(trigram, first == input2)
  sub3$freq <- round(0.4*sub3$freq/nrow(sub3), 3)
  sub3 <- select(sub3, last, freq3 = freq)
  
  input1 <- tail(input, 1)
  sub2 <- subset(bigram, first == input1)
  sub2$freq <- round(0.4^2*sub2$freq/nrow(sub2), 3)
  sub2 <- select(sub2, last, freq2 = freq)
  
  total <- merge(sub4, sub3, by = 'last', all = T)
  total <- merge(total, sub2, by = 'last', all = T)
  total[is.na(total)] <- 0
  total['freq_sum'] <- rowSums(total[, 2:4])
  total <- arrange(total, desc(freq4), desc(freq3), desc(freq2))
  predict <- head(total, 3)
  predict
  }
  
   



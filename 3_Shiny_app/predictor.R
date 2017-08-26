library(quanteda)
library(dplyr)

quadrigram <- readRDS("qgram.RData")
trigram <- readRDS("tgram.RData")
bigram <- readRDS("bgram.RData")

predict <- function(input) {
  # Clean user input
  input <- tolower(input)
  input <- unlist(tokenize(input, remove_numbers = T, remove_punct = T, remove_symbols = T, 
                            remove_separators = T, remove_twitter = T, remove_hyphens = T,
                            remove_url = T, ngrams = 1, concatenator = ' ', verbose = F))
  
  # Stupid Backoff Algorithm
  # 1. Check if the last 3 words of user input match the first 3 words of quadrigram table, output the matches 
  # 2. If not, check if the last 2 words of user input match the first 2 words of trigram table, output the matches 
  # 3. Also check if the last word of user input match the first word of bigram table, output the match
  # 4. For 1-3, caculate the MLE scores for all candidate words. The probability of the word is multiplied by 
  # 0.4 to the power of backoff numbers.
    
  input3 <- paste(tail(input, 3), collapse = ' ')
  sub4 <- subset(quadrigram, first == input3)
  sub4$freq <- round(sub4$freq/sum(sub4$freq), 3)
  sub4 <- head(select(sub4, last, freq4 = freq), 10)
    
  input2 <- paste(tail(input, 2), collapse = ' ')
  sub3 <- subset(trigram, first == input2)
  sub3$freq <- round(0.4*sub3$freq/sum(sub3$freq), 3)
  sub3 <- head(select(sub3, last, freq3 = freq), 10)
    
  input1 <- tail(input, 1)
  sub2 <- subset(bigram, first == input1)
  sub2$freq <- round(0.4^2*sub2$freq/sum(sub2$freq), 3)
  sub2 <- head(select(sub2, last, freq2 = freq), 10)
  
  total <- merge(sub4, sub3, by = 'last', all = T)
  total <- merge(total, sub2, by = 'last', all = T)
  total[is.na(total)] <- 0
  total['freq_sum'] <- rowSums(total[, 2:4])
  total <- arrange(total, desc(freq4), desc(freq3), desc(freq2))
  predict <- head(total, 3)$last
  return (predict)
  
  }
  
   



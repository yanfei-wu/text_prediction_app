## Get data from Locale en_US

# Twitter data (en_US.twitter.txt)
ustwitter <- read.table('en_US.twitter.txt', sep = '\t', stringsAsFactors = F)
head(ustwitter, 3)
str(ustwitter)

# There are some rows containing more than 1 twits as they are newline seperated. 
# We need to further break them down to single twit.
s <- s <- strsplit(ustwitter$V1, '\n')
ustwitter_df <- data.frame(V1 = unlist(s), stringsAsFactors = F)
str(ustwitter_df)  

# Find twits containing certain words/sentences.
grep('biostats', dd$V1, perl = T, value = T) 
# show twits with 'biostats' in them
length(grep('love', dd$V1, perl = T, value = F)) 
# show the number of twits with 'love' in them
length(grep('hate', dd$V1, perl = T, value = F)) 
# show the number of twits with 'hate' in them
length(grep('A computer once beat me at chess, but it was no match for me at kickboxing', 
            dd$V1, perl = T, value = F))
# show the number of twits with a sentence 'A computer once beat me at chess, 
# but it was no match for me at kickboxing' in it.

# Find the longest twits length
ustwitter_df['Len'] <- nchar(ustwitter_df$V1)
head(sort(ustwitter_df$V1, decreasing = T), 1)


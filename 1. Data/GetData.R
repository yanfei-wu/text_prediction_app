
########################## twitters exploration #################################
# Twitter data (en_US.twitter.txt)
ustwitter <- read.table('en_US.twitter.txt', sep = '\t', stringsAsFactors = F)
head(ustwitter, 3)
str(ustwitter)

# There are some rows containing more than 1 twits as they are newline seperated. 
# need to further break them down to single twit.
s <- strsplit(ustwitter$V1, '\n')
ustwitter_df <- data.frame(V1 = unlist(s), stringsAsFactors = F)
str(ustwitter_df)  

# explore regular expression with text data 
# find twits containing 'biostats'
grep('biostats', dd$V1, perl = T, value = T) 

# show the number of twits with 'love' in them
length(grep('love', dd$V1, perl = T, value = F)) 

# show the number of twits with 'hate' in them
length(grep('hate', dd$V1, perl = T, value = F)) 

# show the number of twits with a particular sentence 
length(grep('A computer once beat me at chess, but it was no match for me at kickboxing', 
            dd$V1, perl = T, value = F))

# find the longest twits length
ustwitter_df['Len'] <- nchar(ustwitter_df$V1)
head(sort(ustwitter_df$V1, decreasing = T), 1)


########################## get blogs and news data ############################# 
# read blogs and news data
blog <- readLines('en_US.blogs.txt', encoding = 'UTF-8', skipNul = T)
news <- readLines('en_US.news.txt', encoding = 'UTF-8', skipNul = T)


########################## new corpus with sample data ######################### 
# randomly sample 5% of data from each of the 3 data sources
set.seed(25) # set a seed
sampletwitter <- twitter[sample(1:twitter_lines, twitter_lines*0.05)]
sampleblog <- blog[sample(1:blog_lines, blog_lines*0.05)]
samplenews <- news[sample(1:news_lines, news_lines*0.05)]
writeLines(c(sampletwitter, sampleblog, samplenews), 'sample.txt')
rm(twitter, blog, news, sampletwitter, sampleblog, samplenews) # free up memory

# construct a new corpus with the sample data
sample <- readLines('sample.txt', encoding = 'UTF-8', skipNul = T)
sample <- tolower(sample)
corpus <- corpus(sample)




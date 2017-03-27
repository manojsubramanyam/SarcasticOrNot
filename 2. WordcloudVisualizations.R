## Wordcloud 
rm(list = ls())

require(data.table)
require(tm)
require(wordcloud)
require(ggplot2)

tweet <- fread('TweetsDataSet.csv')
load('step1_DS.dat')


## creating wordcloud for entire data set

sparse.dtm <- removeSparseTerms(dtm, 0.999 )
sparse.dtm

# creating word frequency data frame
word.freq <- sort(colSums(data.table(as.matrix(sparse.dtm))), decreasing = T)
word.freq <- data.table(Terms = names(word.freq), frequency = word.freq)

# creating word cloud for top 200 words in frequency
wordcloud(word.freq$Terms, word.freq$frequency,max.words = 150, scale = c(4,0.75),
          random.order = F, colors=brewer.pal(8, "Dark2"))
a <- word.freq[frequency>2000]

# Bar graph for words that are more frequent appearing more than 2000 times
ggplot(a, aes(Terms, frequency))+
  geom_bar(stat = 'identity', colour = '#041838', fill = '#0b439e')+
  labs(title= 'Alphabetical ordered High frequent Terms')
#clearing graphical memory
dev.off()

## Seperate Word clouds for sarcastic and non-sarcastic tweets
# subsetting sarcasm and non sarcasm tweets 
sarcasm     <- tweet[label == 'sarcastic']
sarcasm.not <- tweet[label == 'non-sarcastic']

# corpus for both sarcastic and non-sarcastic

corp.sarcasm = vec2clean.corp(sarcasm$tweet, 5)
# Wordcloud for Sarcasm subset
wordcloud(corp.sarcasm, min.freq = 300, max.words = 300,
          random.order = F, scale = c(5 ,0.75),  colors=brewer.pal(8, "Dark2"))

corp.sarcasm.not = vec2clean.corp(sarcasm.not$tweet, 5)
# Wordcloud for Non Sarcasm subset
wordcloud(corp.sarcasm.not, min.freq = 200, max.words = 300,
          random.order = F, scale = c(5 ,0.75),  colors=brewer.pal(8, "Dark2"))

# DTM for sarcasm and non sarcasm corpora
dtm.sar <- DocumentTermMatrix(corp.sarcasm)
dtm.non <- DocumentTermMatrix(corp.sarcasm.not)

# Most frequent 30 words in Sarcasm and non-sarcasm DTMs
findFreqTerms(dtm.sar)[seq(30)]
findFreqTerms(dtm.non)[seq(30)]

# Finding out the most common words and frequent words 
# These words should be eliminated from the master DTM
common <- NULL
for(i in findFreqTerms(dtm.non)[seq(100)]){
  for(j in findFreqTerms(dtm.sar)[seq(100)]){
    if(identical(i,j)){
      common = c(common,i)
      print(i)
    }
  }
}
common # common words are passed to feature engineering code
# common is saved for future references
save(common, file = 'step2_DS.dat')
# Please move to 3.FeatureEngineering.R

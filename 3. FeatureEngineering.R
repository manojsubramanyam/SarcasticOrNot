## This code is about Feature engineering and Feature selection
# We check correlations and associations between variables.

# clean the environment
rm(list= ls())
require(data.table)
require(tm)

# 

# loading the previous data sets
load('step1_DS.dat')
load('step2_DS.dat')

# load the tweet data set
tweet <- fread('TweetsDataSet.csv')
tweet$label <- as.factor(tweet$label)

#remove sparsity and prepare data frame
sparse <- removeSparseTerms(dtm, 0.9992)
sparse

df <- data.table(as.matrix(sparse))

# Find associations 
unlist(findAssocs(sparse, findFreqTerms(sparse,100),corlimit = 0.5))
# this may not provide all correlated pairs
rm(dtm,sparse) # as it is not necessary

# we go for pearson correlation matrix to get more detailed info
corr <- data.table(cor(df, use = "complete.obs", method= "pearson"))
corr.terms <- NULL
for(i in 1:(nrow(corr)-1)){
  for(j in (i+1):ncol(corr)){
    if((abs(corr[[i,j]])>0.49) ==T){
      corr.terms = c(corr.terms, names(corr)[i])
      print(paste(colnames(corr)[i],',',colnames(corr)[j])) # print rows and column numbers which are correlated
    }
  }
}
# corr.terms consist of correlated terms which are more than 50% with any other variable
# only one term out correlated pair is added while 'for' loop
rm(corr,i,j)
corr.terms

# combining both common and del.words
del.words <- c(corr.terms, common)
del.words <- unique(del.words)

# removing del.words features from master
df[, (del.words) := NULL]
dim(df)

# creating master data set
master <- data.table(label = tweet$label, df)

# saving numeric data master for sampling
save(master, file='master.numeric.dat')

# We are going to prepare master.factor from master
rm(list = ls())
# loading numeric master 
load('master.numeric.dat')
master.factor <- as.data.frame(master)

#Binning 
master.factor <- data.frame(lapply(master[,2:ncol(master)], function(x){ifelse(x==0,0,1)}))

# Converting numericals to factors 
master.factor <- data.frame(lapply(master.factor, as.factor))
# master.factor has all categorical variables 0 and 1 factors

master.factor <- cbind(label = master$label, master.factor)

# saving factor data master.factor
save(master.factor, file = 'master.factor.dat')

# Please go to 4.Sampling_TrianTest.R

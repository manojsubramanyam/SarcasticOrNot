# This code is about Preparing samples of the master data set and 
# splitting training and testing sets

# clean the environment
rm(list = ls())

# loading necessary libraries
require(caTools)

# function to create sample and push the train and test data sets out
# we are considering sample count as 5022(91298*0.055)
# and 0.8 ratio as training and testing ratio

sample2train.test <- function(master.x, seed.x, samp.ratio= 0.055, train.ratio= 0.8){
  set.seed(seed = seed.x)
  samp.split = sample.split(master.x$label, samp.ratio)
  sample = subset(master.x, samp.split == T)
  
  # training and testing 
  spl = sample.split(sample$label, train.ratio)
  train.x = subset(sample, spl == T )
  test.x  = subset(sample, spl == F )
  return(list(train.x, test.x))
}

# choose the data set you like to use and load the data set 

# to load master.numeric
load('master.numeric.dat')

# to load master.factor
load('master.factor.dat')

# pass the desired master data set, seed(to produce random sample), sample ratio and train ratio
# sample ratio and train ratio are defaulted with 0.055(5022 observations) and 0.8 respectively

# For producing Training and Testing sets of master.numeric
Train.Test.list <- sample2train.test(master,123)

train.num <- Train.Test.list[[1]]
test.num  <- Train.Test.list[[2]]

# saving numeric train and test sets
save(train.num, test.num, file = 'TrainTest_num.dat')

# For producing Training and Testing sets of master.factor
Train.Test.list <- sample2train.test(master.factor,123)

train <- Train.Test.list[[1]]
test  <- Train.Test.list[[2]]

# saving factor train and test sets
save(train, test, file = 'TrainTest.dat')

# Please move to Modelling codes 5.Naive Bayes Training.R, 6.Naive Bayes Evaluation.R
#  7.RandomForestTraining.R , 8.RandomForestEvaluation
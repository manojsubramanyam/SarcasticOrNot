# Random forest model building on master.factor and master.numeric
# and saving the model 

# clean the environment
rm(list = ls())

# loading required package
require(h2o) # to implement random forest quick

# Initializing h2o cluster
h2o.init(nthreads = -1)

#check h2o cluster status
h2o.init()

set.seed(123)
# loading Train and Test sets 
load('TrainTest_num.dat')
load('TrainTest.dat')

# loading data to h2o clusters 
h.train.num <- as.h2o(train.num)
h.train     <- as.h2o(train)


# creating predictor and target indices
x <- 2:ncol(train)
y <- 1
# Building random forest model on numeric data 
rf.model.num <- h2o.randomForest(x=x, y=y, training_frame = h.train.num, ntrees = 1000)

# Building random forest model on factor data
rf.model     <- h2o.randomForest(x=x, y=y, training_frame = h.train, ntrees = 1000)

# saving both models for evaluation 
save(rf.model.num, rf.model, file = 'RF_models.dat')

# Please move to 8.RandomForestEvaluation.R
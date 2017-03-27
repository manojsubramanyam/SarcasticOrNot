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


# loading Train and Test sets 
load('TrainTest_num.dat')
load('TrainTest.dat')

# loading data to h2o clusters 
h.test.num  <- as.h2o(test.num)
h.test      <- as.h2o(test)

# loading RF models
load('RF_models.dat')

# Evaluating random forest models

# Random forest evaluation for Numeric data
pred.num <- as.data.frame(h2o.predict(rf.model.num, h.test.num))
caret::confusionMatrix(table('Actual class' = test$label,'Predicted class' =  pred.num$predict))

# Random forest evaluation for Factor data
pred <- as.data.frame(h2o.predict(rf.model, h.test))
caret::confusionMatrix(table('Actual class' = test$label, 'Predicted class' = pred$predict))

# shuting down h2o cluster
h2o.shutdown(prompt = F)
# Thank you!
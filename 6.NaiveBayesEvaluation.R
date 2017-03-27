# Naive Bayes Evaluation code

# clean the environment
rm(list = ls())


# loading required packages
require(e1071)

# loading Train and Test sets
load('TrainTest.dat')

# loading the Naive Bayes models
load('NB_models.dat')

# Predicting the test target class
# for classic Naive Bayes model
n.pred <- predict(n.model, test[,-1], type = 'class')

xtab.n <- table('Actual class' = test[,1], 'Predicted class' = n.pred )
caret::confusionMatrix(xtab.n)

# for robust Naive Bayes model with laplace estimator
n.pred.lap <- predict(n.model.lap, test[,-1], type = 'class')

xtab.lap <- table('Actual class' = test[,1], 'Predicted class' = n.pred.lap )
caret::confusionMatrix(xtab.lap)


# We build Naive Bayes model on master.factor and save the model 
# clean the environment
rm(list = ls())

# loading required package
require(e1071)

# loading Train and Test sets 
load('TrainTest.dat')


# Naive Bayes model classic
n.model <- naiveBayes(label~ ., data = train)


# Naive Bayes model with laplace estimator 1
# laplace = 1 ensures a non-zero probability for every feature
n.model.lap <- naiveBayes(label~ ., data = train, laplace = 1)


# save the model for evaluation
save(n.model,n.model.lap, file= "NB_models.dat")

# please go to 6.NaiveBayesEvaluation.R for Evaluation
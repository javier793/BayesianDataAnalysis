# Chapter 8 code and exercises
rm(list = ls())
setwd("/Users/javiergallego/Documents/Bayesian analysis/DBDA2Eprograms")
source("DBDA2E-utilities.R")
# ----------------------------------------------------------------------
# JAGS example

# Load libraries
library(rjags)
library(runjags)

myData = read.csv("z15N50.csv")
y = myData$y
Ntotal = length(y)
dataList = list(
  y = y, 
  Ntotal = Ntotal
)

# Definition of the model in a text file 
# that will be sent to JAGS which will process and interpret the model

modelString = " # Open quote for modelString
  model{
    for(i in 1:Ntotal){
      y[i] ~ dbern(theta) # likelihood
    }
    theta ~ dbeta(1,1) # prior
  }
" # close quote for modelString
writeLines(modelString, con = "TempModel.txt")

# Initial parameters of the model

initsList = function(){
  "
  Compute a random initial value close to the MLE
  ---------------------
  returns: list of with initial parameter
  
  "
  resampledY = sample(y, replace = TRUE )
  thetaInit = sum(resampledY)/length(resampledY)
  thetaInit = 0.001 + 0.998*thetaInit
  
  return(list(theta= thetaInit))
  
}


jagsModel = jags.model(file = "TempModel.txt", data = dataList, inits = initsList, n.chain= 3, n.adapt= 500)
update(jagsModel, n.iter = 500)
codaSamples = coda.samples(jagsModel, variable.names = c("theta"), n.iter = 3334)
diagMCMC(codaObject = codaSamples, parName = "theta")
plotPost(codaSamples[,"theta"], main = "theta", xlab = bquote(theta))

#------------------------------------------------------
# Example of difference of Biases

myData = read.csv("z6N8z2N7.csv")
y = myData$y
s = as.numeric(myData$s)

Ntotal = length(y)
Nsubj = length(unique(s))
dataList = list(
  y = y,
  s = s,
  Ntotal = Ntotal,
  Nsubj = Nsubj
)

model{
  for(i in 1:Ntotal){
    y[i] ~ dbern(theta[s[i]])
  }
  for(s in 1:Nsubj){
    theta[s] ~ dbeta(2,2)
  }
}





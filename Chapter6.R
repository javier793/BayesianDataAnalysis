rm(list=ls())
setwd("/Users/javiergallego/Documents/Bayesian analysis/DBDA2Eprograms")
source("DBDA2E-utilities.R")
source("BernBeta.R")

# Specify prior
t = 0.75
n = 25
a = t*(n-2) + 1
b = (1-t)*(n-2) + 1
Prior = c(a,b)

# Specify data
N = 20
z = 17
Data = c(rep(0,N-z), rep(1,z))
openGraph(width = 5, height = 7)
posterior = BernBeta(priorBetaAB = Prior, Data = Data, plotType = "Bars", showCentTend = "Mode", showHDI = TRUE,
                     showpD = FALSE)
saveGraph(file= "BernBetaExample", type ="jpg")

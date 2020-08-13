rm(list=ls())
setwd("/Users/javiergallego/Documents/Bayesian analysis/DBDA2Eprograms")

source("DBDA2E-utilities.R")
source("BernGrid.R")

Theta = seq(0, 1, length= 10001)
pTheta = pmin(Theta, 1-Theta)
pTheta = pTheta/sum(pTheta)
Data = c(rep(0,3), 1)

openGraph(width = 5, height = 7)
posterior = BernGrid(Theta,pTheta,Data, plotType = "Bars", showCentTend = "Mode", showHDI = TRUE, showpD = FALSE)
saveGraph(file="BernGridExample", type="jpg")

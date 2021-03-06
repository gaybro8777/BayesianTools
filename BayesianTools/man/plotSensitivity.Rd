% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotSensitivityOAT.R
\name{plotSensitivity}
\alias{plotSensitivity}
\title{Performs a one-factor-at-a-time sensitivity analysis for the posterior of a given bayesianSetup within the prior range.}
\usage{
plotSensitivity(bayesianSetup, selection = NULL, equalScale = T)
}
\arguments{
\item{bayesianSetup}{An object of class BayesianSetup}

\item{selection}{indices of selected parameters}

\item{equalScale}{if T, y axis of all plots will have the same scale}
}
\description{
Performs a one-factor-at-a-time sensitivity analysis for the posterior of a given bayesianSetup within the prior range.
}
\note{
This function can also be used for sensitivity analysis of an arbitrary output - just create a BayesianSetup with this output.
}
\examples{

ll <- testDensityBanana
bayesianSetup <- createBayesianSetup(likelihood = ll, lower = rep(-10, 2), upper = rep(10, 2))

plotSensitivity(bayesianSetup)
}
\author{
Florian Hartig
}

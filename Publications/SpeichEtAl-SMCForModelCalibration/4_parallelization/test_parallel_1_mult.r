arg <- commandArgs(TRUE)
number <- eval(parse(text = arg))

library(BayesianTools)
library(threePGN)

# Load saved (synthetic) data and reference MCMC output (reference is not needed here, only BA and GPP)
load("./out/reference_threePGN_list.RData")
# Use only sample from reference; delete reference to free memory
ref.sample <- getSample(save.list[[3]], start = 3333)
ref.ba <- save.list[[1]]
ref.gpp <- save.list[[2]]
rm(save.list)


ref.pars <- c(data_param$mode, 1, 1)
min.pars <- c(data_param$min, 0.2, 0.2)
max.pars <- c(data_param$max, 2, 2)

out.file <- paste0("/home/fr/fr_fr/fr_ms1719/out/test_parallel/out", number ,"/1core.txt")


#### No sleep
likelihood <- function(ref.pars){
  
  library(threePGN)
  pgrun <- r3pgn(siteData = data_site[1:3,], climate = data_climate, parameters = ref.pars[1:51], outputs = c(1:5,10:12, 26:27))
  sim.ba  <- pgrun$output[,,1][,3]
  sim.gpp <- pgrun$output[,,1][,9]
  
  like <- sum(dnorm(ref.ba-sim.ba, sd=ref.pars[52], log=TRUE)) + sum(dnorm(ref.gpp-sim.gpp, sd=ref.pars[53], log=TRUE))
  #Sys.sleep(0.05)
  return(like)
}

prior <- createUniformPrior(lower = min.pars, upper = max.pars)
pgSetup <- createBayesianSetup(likelihood = likelihood, prior = prior, parallel = FALSE)

time <- system.time(smc <- smcSampler(bayesianSetup = pgSetup, initialParticles = 50000, ess.limit = 50000 * 0.9, mutate.method = "DE", proposalScale = 0.1, resamplingSteps = 30))[3]

cat(c("noSleep", time), file = out.file, append = FALSE)



#### Sleep 20ms
likelihood <- function(ref.pars){
  
  library(threePGN)
  pgrun <- r3pgn(siteData = data_site[1:3,], climate = data_climate, parameters = ref.pars[1:51], outputs = c(1:5,10:12, 26:27))
  sim.ba  <- pgrun$output[,,1][,3]
  sim.gpp <- pgrun$output[,,1][,9]
  
  like <- sum(dnorm(ref.ba-sim.ba, sd=ref.pars[52], log=TRUE)) + sum(dnorm(ref.gpp-sim.gpp, sd=ref.pars[53], log=TRUE))
  Sys.sleep(0.02)
  return(like)
}

prior <- createUniformPrior(lower = min.pars, upper = max.pars)
pgSetup <- createBayesianSetup(likelihood = likelihood, prior = prior, parallel = FALSE)

time <- system.time(smc <- smcSampler(bayesianSetup = pgSetup, initialParticles = 50000, ess.limit = 50000 * 0.9, mutate.method = "DE", proposalScale = 0.1, resamplingSteps = 30))[3]

cat("\n", file=out.file, append=TRUE)
cat(c("sleep20ms", time), file = out.file, append = TRUE)


#### Sleep 50s
likelihood <- function(ref.pars){
  
  library(threePGN)
  pgrun <- r3pgn(siteData = data_site[1:3,], climate = data_climate, parameters = ref.pars[1:51], outputs = c(1:5,10:12, 26:27))
  sim.ba  <- pgrun$output[,,1][,3]
  sim.gpp <- pgrun$output[,,1][,9]
  
  like <- sum(dnorm(ref.ba-sim.ba, sd=ref.pars[52], log=TRUE)) + sum(dnorm(ref.gpp-sim.gpp, sd=ref.pars[53], log=TRUE))
  Sys.sleep(0.05)
  return(like)
}

prior <- createUniformPrior(lower = min.pars, upper = max.pars)
pgSetup <- createBayesianSetup(likelihood = likelihood, prior = prior, parallel = FALSE)

time <- system.time(smc <- smcSampler(bayesianSetup = pgSetup, initialParticles = 50000, ess.limit = 50000 * 0.9, mutate.method = "DE", proposalScale = 0.1, resamplingSteps = 30))[3]

cat("\n", file=out.file, append=TRUE)
cat(c("sleep50ms", time), file = out.file, append = TRUE)


#### Sleep 100ms
likelihood <- function(ref.pars){
  
  library(threePGN)
  pgrun <- r3pgn(siteData = data_site[1:3,], climate = data_climate, parameters = ref.pars[1:51], outputs = c(1:5,10:12, 26:27))
  sim.ba  <- pgrun$output[,,1][,3]
  sim.gpp <- pgrun$output[,,1][,9]
  
  like <- sum(dnorm(ref.ba-sim.ba, sd=ref.pars[52], log=TRUE)) + sum(dnorm(ref.gpp-sim.gpp, sd=ref.pars[53], log=TRUE))
  Sys.sleep(0.1)
  return(like)
}

prior <- createUniformPrior(lower = min.pars, upper = max.pars)
pgSetup <- createBayesianSetup(likelihood = likelihood, prior = prior, parallel = FALSE)

time <- system.time(smc <- smcSampler(bayesianSetup = pgSetup, initialParticles = 50000, ess.limit = 50000 * 0.9, mutate.method = "DE", proposalScale = 0.1, resamplingSteps = 30))[3]

cat("\n", file=out.file, append=TRUE)
cat(c("sleep100ms", time), file = out.file, append = TRUE)
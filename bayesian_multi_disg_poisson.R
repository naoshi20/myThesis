library(tidyverse)
library(rstan)
library(brms)
source("myfunc.R")

# Stan options -----------------------------------------------------------------
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

# data loading -----------------------------------------------------------------
data <- read.csv("data/data.csv",header=T)

# data summary -----------------------------------------------------------------
summary(data)

# modeling,無情報事前分布
fit <- brm(
  formula = disgust ~ AU10 + AU12,
  family = poisson(),#gaussian()
  #chains = 8,
  #iter = 8000,
  #control = list(adapt_delta = 0.99,max_treedepth = 15),
  data = data,
  seed = 1,
  prior = c(prior("", class = "Intercept"),
            prior("", class = "b")), #NULL
  save_pars = save_pars(all = TRUE)
)

# saving and loading an RDS file -----------------------------------------------------------------
saveRDS(fit, "./result/stanfitRDS/disgust_multi_poisson.rds")
fit <- readRDS("./result/stanfitRDS/disgust_multi_poisson.rds")
pairs(fit)
s_fit <- summary(fit)
s_fit

# summary -----------------------------------------------------------------
write.csv(fit, file = "./result/bayesian/disgust_estimates_multi_poisson.csv", row.names = FALSE)


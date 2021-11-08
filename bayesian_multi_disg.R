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
  family = gaussian(),#gaussian()
  data = data,
  seed = 1,
  prior = c(set_prior("", class = "Intercept"),
            set_prior("", class = "sigma")), #NULL
  save_pars = save_pars(all = TRUE)
)

# saving and loading an RDS file -----------------------------------------------------------------
saveRDS(fit, "./result/stanfitRDS/disgust_multi.rds")
fit <- readRDS("./result/stanfitRDS/disgust_multi.rds")
pairs(fit)
s_fit <- summary(fit)
s_fit

# summary -----------------------------------------------------------------
write.csv(fit, file = "./result/bayesian/disgust_estimates_multi.csv", row.names = FALSE)
#エラー
#write.csv(s_fit$spec_pars, file = "./result/bayesian/disgust_summary_multi_spec.csv", row.names = FALSE)
#write.csv(s_fit$cor_pars, file = "./result/bayesian/disgust_summary_multi_cor.csv", row.names = FALSE)

#以下エラー----------------------------------------------------------------------
# prediction visualization --------------------------------------------------------------------
#eff <- conditional_effects(lm_brms, effects = "AU10:AU12")
#plot(eff, points = TRUE)


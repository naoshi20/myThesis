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

# modeling
fit <- brm(
  formula = amusement ~ AU1 + AU2 + AU4 + AU5	+ AU6	+ AU7	+ AU10	+ AU12 + AU14	+ AU15 + AU17 + AU21 + AU23 + AU25 + AU26,
  family = gaussian(),
  data = data,
  seed = 1,
  prior = c(set_prior("", class = "Intercept"),
            set_prior("", class = "sigma")),
  save_pars = save_pars(all = TRUE)
)

# saving and loading an RDS file -----------------------------------------------------------------
saveRDS(fit, "./result/stanfitRDS/amusement_multi.rds")
fit <- readRDS("./result/stanfitRDS/amusement_multi.rds")
s_fit <- summary(fit)
s_fit
names(s_fit)
# summary -----------------------------------------------------------------
write.csv(fit, file = "./result/bayesian/amusement_estimates_multi.csv", row.names = FALSE)
#エラー
#write.csv(s_fit$spec_pars, file = "./result/bayesian/amusement_summary_multi_spec.csv", row.names = FALSE)
#write.csv(s_fit$cor_pars, file = "./result/bayesian/amusement_summary_multi_cor.csv", row.names = FALSE)

#以下エラー----------------------------------------------------------------------
# prediction visualization --------------------------------------------------------------------
#eff <- conditional_effects(lm_brms, effects = "AU10:AU12")
#plot(eff, points = TRUE)


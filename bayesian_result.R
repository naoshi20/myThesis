library(bayesplot)
library(tidyverse)
data <- read.csv("data/data.csv")

fit <- readRDS("./result/stanfitRDS/amusement.rds")

mcmc_sample <- rstan::extract(fit, permuted = FALSE)
#dimnames(mcmc_sample)
#dim(mcmc_sample) #繰り返し数,Chain数,推定されたパラメータ数

beta0_mcmc_vec <- as.vector(mcmc_sample[,,"beta0"])
mean(beta0_mcmc_vec)
quantile(beta0_mcmc_vec, probs = c(0.025, 0.975))
print(
  fit,
  probs= c(0.025,0.5, 0.975))

#事後分布とトレースプロット
#mcmc_combo <- mcmc_combo(mcmc_sample, pars= c("beta0","beta1","eta"))
#ggsave("result/bayesian/posterior_trace.png", mcmc_combo, width = 5, height = 10.0, dpi = 600)

#コレログラム
#mcmc_acf_bar <- mcmc_acf_bar(mcmc_sample,pars = c("beta0", "beta1","eta"))
#ggsave("result/bayesian/correlogram.png", mcmc_acf_bar, width = 5, height = 10.0, dpi = 600)

#事後分布範囲の比較
mcmc_intervals(
  mcmc_sample, pars = c("beta0", "beta1", "eta"),
  prob = 0.8,
  prob_outer = 0.95
)

#事後分布範囲の比較(密度付き)
mcmc_areas(
  mcmc_sample, pars = c("beta0", "beta1", "eta"),
  prob = 0.6,
  prob_outer = 0.99
)

#事後予測チェック
yrep <- rstan::extract(fit)$theta #classはmatrix, [1,"chain:1","theta_pred[1]"]#$theta_pred[1]
ppc_hist(y = data$amusement,
         yrep = yrep[1:10,],
         binwidth = 1)
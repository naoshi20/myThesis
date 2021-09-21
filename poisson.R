library(tidyverse)
library(rstan)
#library(RWiener)
source("myfunc.R")

# Stan options -----------------------------------------------------------------
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

# data loading -----------------------------------------------------------------
data <- read.csv("data/data.csv",header=T)

# making data for Stan ---------------------------------------------------------
standata <- list(
  N_x = nrow(data), #サンプルサイズ
  Y = data$amusement, #目的変数
  AU10 = data$AU10, #説明変数
  x_pred = seq(0,1,length=116)
) %>%
  c(N_x_pred = length(.$x_pred))

# compile -----------------------------------------------------------------
stan_model <- stan_model(file="poisson.stan")

# model fitting -----------------------------------------------------------------
fit <- sampling(stan_model
                ,data=standata
                ,seed=610
                ,chains=4
                ,iter=2500 + 500
                ,warmup=500
                ,thin=1
                ,pars="theta", include=FALSE
)

# saving and loading an RDS file -----------------------------------------------------------------
saveRDS(fit, "./result/stanfitRDS/amusement_poisson.rds")
fit <- readRDS("./result/stanfitRDS/amusement_poisson.rds")

# summary -----------------------------------------------------------------
s_fit <- summary(fit)$summary
write.csv(s_fit, file = "./result/bayesian/amusement_summary_poisson.csv", row.names = FALSE)

print(s_fit)
# saving estimates -----------------------------------------------------------------
s_fit %>% 
  as.data.frame() %>% 
  rownames_to_column("parameter") %>% 
  write.csv("result/bayesian/amusement_estimates_poisson.csv", row.names = FALSE)

# visualization -----------------------------------------------------------------
pred <- s_fit %>%
  as.data.frame() %>%
  rownames_to_column("parameter") %>%
  filter(str_detect(parameter, "^theta_pred")) %>%
  mutate(AU10 = standata$x_pred) %>%
  dplyr::select(AU10, mean, "2.5%", "97.5%") %>%
  dplyr::rename(amusement = mean, Lower = "2.5%", Upper = "97.5%")

g <- ggplot(data, aes(x = AU10, y = amusement)) %>% plt_pred()
plot(g)

ggsave("result/bayesian/pred_amusement_poisson.png", g, width = 2.5, height = 2.5, dpi = 600)

# association between a and beta -----------------------------------------------------------------
est <- data.frame(
  beta0_M = s_fit["beta0", "mean"],
  beta0_Lower = s_fit["beta0", "2.5%"],
  beta0_Upper = s_fit["beta0", "97.5%"],
  beta1_M = s_fit["beta1", "mean"],
  beta1_Lower = s_fit["beta1", "2.5%"],
  beta1_Upper = s_fit["beta1", "97.5%"]
)

g <- ggplot(est, aes(x = beta0_M, y = beta1_M)) %>% plt_est()
plot(g)

ggsave("result/bayesian/est_amusement_poisson.png", g, width = 2.5, height = 2.5, dpi = 600)

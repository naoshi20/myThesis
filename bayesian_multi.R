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
#fit <- brm(
#  formula = amusement ~ AU1 + AU2 + AU4 + AU5	+ AU6	+ AU7	+ AU10	+ AU12 + AU14	+ AU15 + AU17 + AU21 + AU23 + AU25 + AU26,
#  family = gaussian(),
#  data = data,
#  seed = 1,
#  prior = c(set_prior("", class = "Intercept"),
#            set_prior("", class = "sigma"))
#)

# saving and loading an RDS file -----------------------------------------------------------------
#saveRDS(fit, "./result/stanfitRDS/amusement_multi.rds")
fit <- readRDS("./result/stanfitRDS/amusement_multi.rds")

fit
# summary -----------------------------------------------------------------
write.csv(fit, file = "./result/bayesian/amusement_estimates_multi.csv", row.names = FALSE)
write.csv(summary(fit), file = "./result/bayesian/amusement_summary_multi.csv", row.names = FALSE)

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

ggsave("result/bayesian/pred_amusement_multi.png", g, width = 2.5, height = 2.5, dpi = 600)

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

ggsave("result/bayesian/est_amusement_multi.png", g, width = 2.5, height = 2.5, dpi = 600)

# prediction visualization --------------------------------------------------------------------
eff <- conditional_effects(lm_brms, effects = "AU10:AU12")
plot(eff, points = TRUE)


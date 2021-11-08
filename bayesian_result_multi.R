library(bayesplot)
library(tidyverse)
data <- read.csv("data/data.csv")

fit <- readRDS("./result/stanfitRDS/disgust_multi.rds")
fit_poisson <- readRDS("./result/stanfitRDS/disgust_multi_poisson.rds")
fit_geometric <- readRDS("./result/stanfitRDS/disgust_multi_geometric.rds")

#loo1 <- brms::loo(fit)
#loo2 <- brms::loo(fit_poisson)
#loo3 <- brms::loo(fit_geometric)

#comp <- loo_compare(loo1, loo2, loo3)
#print(comp, digits = 2)

#trace plot,グラフは複数出力されるため、グラフの保存はRstudioのPlotsペインに表示されるExportタブから行う。矢印でグラフの移動が可能。
#plot(fit, N=2)
plot(fit_poisson, N=3)
plot(fit_geometric, N=3)
#launch_shinystan(fit)

#自己相関の確認。コレログラム


#事後予測チェックPosterior Predictive Checks (https://m-clark.github.io/easy-bayes/posterior-predictive-checks.html)
color_scheme_set(scheme = "darkgray")
pp_check <- pp_check(fit,seed=1) + xlim(-5, 12) + ylim(0, 0.37)
ggsave("result/bayesian/posterior_predictive_checks_brms.png", pp_check)

pp_check_poisson <- pp_check(fit_poisson,seed=1) + xlim(-5, 12)+ ylim(0, 0.37)
ggsave("result/bayesian/posterior_predictive_checks_brms_poisson.png", pp_check_poisson)

pp_check_geometric <- pp_check(fit_geometric,seed=1)+ xlim(-5, 12)+ ylim(0, 0.37)
ggsave("result/bayesian/posterior_predictive_checks_brms_geometric.png", pp_check_geometric)

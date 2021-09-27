library(bayesplot)
library(tidyverse)
data <- read.csv("data/data.csv")

fit <- readRDS("./result/stanfitRDS/amusement_multi.rds")


#trace plot
#グラフは複数出力されるため、グラフの保存はRstudioのPlotsペインに表示されるExportタブから行う。矢印でグラフの移動が可能。
#plot(fit, N=2)
#launch_shinystan(fit)

#自己相関の確認。コレログラム


#事後予測チェックPosterior Predictive Checks (https://m-clark.github.io/easy-bayes/posterior-predictive-checks.html)
pp_check <- pp_check(fit)
ggsave("result/bayesian/posterior_predictive_checks_brms.png", pp_check)

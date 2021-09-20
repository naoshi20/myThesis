# install.packages("tidyverse")

library("ggplot2")
library("dplyr")
library("ggcorrplot")
library("car")

# data loading -----------------------------------------------------------------
data <- read.csv("data/data.csv") 
head(data)

# scaling
z <- scale(data[5:23])
z <- data.frame(z)
head(z)

# surprise --------------------------------------------------------------------
# 標準化前
#result <- lm(surprise~AU1+AU2+AU4+AU5+AU6+AU7+AU10+AU12+AU14+AU15+AU17+AU21+AU23+AU25+AU26, data)
#summary(result)

#標準化後
result <- lm(surprise~AU1+AU2+AU4+AU5+AU6+AU7+AU10+AU12+AU14+AU15+AU17+AU21+AU23+AU25+AU26, z)
summary(result)

summary <- summary(result)
coe <- summary$coefficient
N <- nrow(data)
aic <- AIC(result)
r_squared <- summary$r.squared
adj_r_squared <- summary$adj.r.squared

result <- cbind(coe,aic,N,r_squared,adj_r_squared)
result[2:nrow(result),5:8] <- ""

filename <- "./result/regression/surprise.csv"
write.table(matrix(c("",colnames(result)),nrow=1),filename,append=F,quote=F,sep=","
            ,row.names=F,col.names=F)
write.table(result,filename,append=T,quote=F,sep=",",row.names=T,col.names=F)

# 関数stepで最もAICが低くなるモデルを確認
#model <- step(result)
#summary(model) # 選ばれたもっとも良いモデルとなる変数を使って回帰分析


# 多重共線性の検討
# VIF>10だと多重共線性に問題あり。<2なら問題なし。
# 独立変数間の多重共線性を検出するための指標の1つ。
# 独立変数間の相関係数行列の逆行列の対角要素であり、
# 値が大きい場合はその変数を分析から除いた方がよいと考えられる。
#vif(result)
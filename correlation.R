# install.packages("tidyverse")

library("ggplot2")
library("dplyr")
library("ggcorrplot")

# data loading -----------------------------------------------------------------
data <- read.csv("data/data.csv") 
head(data)

#correlation


emo_data = select(.data = data, amusement, disgust, sadness, surprise)

# Computing correlation matrix
correlation_matrix <- round(cor(emo_data),1)

# Computing correlation matrix with p-values
corrp.mat <- cor_pmat(emo_data)

# Adding the correlation coefficient
correlation <- ggcorrplot(correlation_matrix, hc.order =TRUE, 
           type ="lower", lab =TRUE)

ggsave("result/visualize/correlation_emo.png", correlation, width = 6, height = 5, dpi = 600)
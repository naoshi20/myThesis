# install.packages("tidyverse")

library("ggplot2")
library("dplyr")
# data loading -----------------------------------------------------------------
data <- read.csv("data/data.csv") 
head(data)

bar_film_samples <- ggplot(data=data)+
  geom_bar(mapping=aes(x=film_labeled,fill=film_labeled))
  
ggsave("result/visualize/film_samples.png", bar_film_samples, width = 5.5, height = 2, dpi = 600)

#感情値の全体平均
mean_emo <- summarize(data, mean_amusement = mean(amusement), mean_disgust = mean(disgust), mean_sadness = mean(sadness), mean_surprise = mean(surprise))
mean_emo <- unlist(mean_emo, use.names=FALSE)
sd_emo <- summarize(data, sd_amusement = sd(amusement), sd_disgust = sd(disgust), sd_sadness = sd(sadness), sd_surprise = sd(surprise))
sd_emo <- unlist(sd_emo, use.names=FALSE)

summarized_data <- data.frame(
  name=c("amusement","disgust","surprise","sadness"),
  value=mean_emo,
  sd=sd_emo
)

bar_mean_emo <- ggplot(summarized_data) +
  geom_bar(aes(x=name, y=value), stat="identity", fill="skyblue", alpha=0.7) +
  xlab("") + ylab("") +
  geom_errorbar(aes(x=name, ymin=value-sd/2, ymax=value+sd/2), colour="black", alpha=0.7, size=0.4, width=0.4)

ggsave("result/visualize/mean_emo.png", bar_mean_emo, width = 5.5, height = 2, dpi = 600)

#感情値の条件ごとの平均
#amusement条件での平均値
amusement_data <- subset(data, data$film_labeled=="amusement_1")
amusement_data

mean_emo <- summarize(amusement_data, mean_amusement = mean(amusement), mean_disgust = mean(disgust), mean_sadness = mean(sadness), mean_surprise = mean(surprise))
mean_emo <- unlist(mean_emo, use.names=FALSE)
sd_emo <- summarize(disgust_data, sd_amusement = sd(amusement), sd_disgust = sd(disgust), sd_sadness = sd(sadness), sd_surprise = sd(surprise))
sd_emo <- unlist(sd_emo, use.names=FALSE)

summarized_data <- data.frame(
  name=c("amusement","disgust","sadness","surprise"),
  value=mean_emo,
  sd=sd_emo
)

bar_mean_emo <- ggplot(summarized_data) +
  geom_bar(aes(x=name, y=value), stat="identity", fill="skyblue", alpha=0.7) +
  xlab("") + ylab("") +
  geom_errorbar(aes(x=name, ymin=value-sd/2, ymax=value+sd/2), colour="black", alpha=0.7, size=0.4, width=0.4)


ggsave("result/visualize/mean_emo_amusement_1.png", bar_mean_emo, width = 5.5, height = 2, dpi = 600)




#感情値の条件ごとの平均
#amusement条件での平均値
amusement_data <- subset(data, data$film_labeled=="amusement_2")
amusement_data

mean_emo <- summarize(amusement_data, mean_amusement = mean(amusement), mean_disgust = mean(disgust), mean_sadness = mean(sadness), mean_surprise = mean(surprise))
mean_emo <- unlist(mean_emo, use.names=FALSE)
sd_emo <- summarize(disgust_data, sd_amusement = sd(amusement), sd_disgust = sd(disgust), sd_sadness = sd(sadness), sd_surprise = sd(surprise))
sd_emo <- unlist(sd_emo, use.names=FALSE)

summarized_data <- data.frame(
  name=c("amusement","disgust","sadness","surprise"),
  value=mean_emo,
  sd=sd_emo
)

bar_mean_emo <- ggplot(summarized_data) +
  geom_bar(aes(x=name, y=value), stat="identity", fill="skyblue", alpha=0.7) +
  xlab("") + ylab("") +
  geom_errorbar(aes(x=name, ymin=value-sd/2, ymax=value+sd/2), colour="black", alpha=0.7, size=0.4, width=0.4)


ggsave("result/visualize/mean_emo_amusement_2.png", bar_mean_emo, width = 5.5, height = 2, dpi = 600)



#disgust条件での平均値
disgust_data <- subset(data, data$film_labeled=="disgust")
disgust_data

mean_emo <- summarize(disgust_data, mean_amusement = mean(amusement), mean_disgust = mean(disgust), mean_sadness = mean(sadness), mean_surprise = mean(surprise))
mean_emo <- unlist(mean_emo, use.names=FALSE)
sd_emo <- summarize(disgust_data, sd_amusement = sd(amusement), sd_disgust = sd(disgust), sd_sadness = sd(sadness), sd_surprise = sd(surprise))
sd_emo <- unlist(sd_emo, use.names=FALSE)

summarized_data <- data.frame(
  name=c("amusement","disgust","sadness","surprise"),
  value=mean_emo,
  sd=sd_emo
)

bar_mean_emo <- ggplot(summarized_data) +
  geom_bar(aes(x=name, y=value), stat="identity", fill="skyblue", alpha=0.7) +
  xlab("") + ylab("") +
  geom_errorbar(aes(x=name, ymin=value-sd/2, ymax=value+sd/2), colour="black", alpha=0.7, size=0.4, width=0.4)


ggsave("result/visualize/mean_emo_disgust.png", bar_mean_emo, width = 5.5, height = 2, dpi = 600)



#sadness条件での平均値
sadness_data <- subset(data, data$film_labeled=="sadness")
sadness_data

mean_emo <- summarize(sadness_data, mean_amusement = mean(amusement), mean_disgust = mean(disgust), mean_sadness = mean(sadness), mean_surprise = mean(surprise))
mean_emo <- unlist(mean_emo, use.names=FALSE)
sd_emo <- summarize(sadness_data, sd_amusement = sd(amusement), sd_disgust = sd(disgust), sd_sadness = sd(sadness), sd_surprise = sd(surprise))
sd_emo <- unlist(sd_emo, use.names=FALSE)

summarized_data <- data.frame(
  name=c("amusement","disgust","sadness","surprise"),
  value=mean_emo,
  sd=sd_emo
)

bar_mean_emo <- ggplot(summarized_data) +
  geom_bar(aes(x=name, y=value), stat="identity", fill="skyblue", alpha=0.7) +
  xlab("") + ylab("") +
  geom_errorbar(aes(x=name, ymin=value-sd/2, ymax=value+sd/2), colour="black", alpha=0.7, size=0.4, width=0.4)


ggsave("result/visualize/mean_emo_sadness.png", bar_mean_emo, width = 5.5, height = 2, dpi = 600)



#surprise条件での平均値
surprise_data <- subset(data, data$film_labeled=="surprise")
surprise_data

mean_emo <- summarize(surprise_data, mean_amusement = mean(amusement), mean_disgust = mean(disgust), mean_sadness = mean(sadness), mean_surprise = mean(surprise))
mean_emo <- unlist(mean_emo, use.names=FALSE)
sd_emo <- summarize(sadness_data, sd_amusement = sd(amusement), sd_disgust = sd(disgust), sd_sadness = sd(sadness), sd_surprise = sd(surprise))
sd_emo <- unlist(sd_emo, use.names=FALSE)

summarized_data <- data.frame(
  name=c("amusement","disgust","sadness","surprise"),
  value=mean_emo,
  sd=sd_emo
)

bar_mean_emo <- ggplot(summarized_data) +
  geom_bar(aes(x=name, y=value), stat="identity", fill="skyblue", alpha=0.7) +
  xlab("") + ylab("") +
  geom_errorbar(aes(x=name, ymin=value-sd/2, ymax=value+sd/2), colour="black", alpha=0.7, size=0.4, width=0.4)

ggsave("result/visualize/mean_emo_surprise.png", bar_mean_emo, width = 5.5, height = 2, dpi = 600)





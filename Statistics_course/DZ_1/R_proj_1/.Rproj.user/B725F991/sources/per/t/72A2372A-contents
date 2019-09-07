df <- read.csv("db.csv", header = F)
#1
max_el <- max(df)
min_el <- min(df)
range_el <- max_el - min_el

#2
num_bins = floor(1 + log2(length(df$V1)))

#3
library(ggplot2)
pl1 <- ggplot(df, aes(x = df$V1)) + 
  geom_histogram(aes(y=..density..), bins = num_bins, col = "black",
                 fill = "lightblue") 

pl1

#4
mean_el <- mean(df$V1)
var_el <- var(df$V1)

#5
library(fitdistrplus)
library(logspline)

descdist(df$V1)
fit.weibull <- fitdist(df$V1, "weibull")
fit.norm <- fitdist(df$V1, "norm")
plot(fit.norm)
plot(fit.weibull)

fit.norm$aic
fit.weibull$aic
cdfcomp(list(fit.norm, fit.weibull), legendtext = c("normal", "weibull"))
denscomp(list(fit.norm, fit.weibull), legendtext = c("normal", "weibull"))
qqcomp(list(fit.norm, fit.weibull), legendtext = c("normal", "weibull"))
ppcomp(list(fit.norm, fit.weibull), legendtext = c("normal", "weibull"))
gofstat(list(fit.norm, fit.weibull), fitnames = c("normal", "weibull"))







h <- range_el / num_bins
h





pl1_data <- hist(df$V1, freq = F)
axis(1,1:20)

pl1_data$breaks
pl1_data$counts

sum(pl1$counts / length(df$V1))

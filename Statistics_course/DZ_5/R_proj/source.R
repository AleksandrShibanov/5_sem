alpha  <-  0.1
a0 <- 7.5 
sigma0 <- 2.4
a1 <- 8
sigma1 <- 2.5
eps <- 0.1
n <- 100

df <- unlist(read.csv("data.csv", header = F, sep = ";"), use.names = F)
df

summary(df)
df_mean <- mean(df)
df_sd <- sd(df)
df_len <- length(df)
df_df <- length(df) - 1
df_min <- min(df)
df_max <- max(df)
df_var <- var(df)

#1
t_stat <- (df_mean - a0)/(df_sd) * sqrt(df_len)
qt(1-alpha,df_df)

#2
chi_stat <- df_df * (df_var)/(sigma0^2)
qchisq(1-alpha, df_df)

#3
c1 <- a0 + (qnorm(1-alpha))/(sqrt(df_len)) * sigma1

#4
beta <- pnorm((c1-a1)/sigma1 * sqrt(df_len))

#5
a1_new <- c1 - sigma1/sqrt(df_len) * qnorm(eps)

#6
png(filename = "../img/hist_densts.png", 
    width = 1920, height = 1080,
    pointsize = 24, res = 96 * 1.25)
x1 <- rnorm(n = 1e5, mean = a0, sd = sigma1)
x2 <- rnorm(n = 1e5, mean = a1, sd = sigma1)
hist(df,prob=T, xlab = "Data", main = "Histogram")
lines(sort(x1),dnorm(sort(x1),a0,sigma1), col='blue', lwd = 2)
lines(sort(x2),dnorm(sort(x2),a1,sigma1), col='red', lwd = 2)
legend("topright", c("a0 = 7.5", "a1 = 8.0"), 
       lty=c(1,1),
       lwd = c(2,2),
       fill=c("blue", "red"))
dev.off()
###########################
library(fitdistrplus)
FIT <- fitdist(df, "norm")
plot(FIT)

sss <- c(24,54,41,17,48,33,42,44,92,27)
qchisq(p = 0.975, df = 9)
a <- c(7.4,  1.5,  4.2,  4.4,  3.5,  3.4,  1.1,  2.4,  0.8,  2.6)
log2(a)
sum(log2(a))
library(fitdistrplus)

a <- c(4,6,7,14,21,16,12,6,4)
dff <- data.frame(c(4,6,7,14,21,16,12,6,4))
descdist(a, method = "sample", boot = 1e3)
t.test(a)
hist(a)

shapiro.test(a)
chisq.test(a)
ks.test(unique(a),"pnorm",10,5.67)

library(nortest)
lillie.test(a)

pearson.test(a)

library(MASS)
mean(a)
library(scales)
res <- rescale(a)
res
fit.norm <- fitdist(a, "norm", method = "mme")
fit.uniform <- fitdist(a, "unif", method = "mme")
fit.beta <- fitdist(res, "beta", method = "mme")

stat_normal <- gofstat(fit.norm, 
                       fitnames = c("normal"))
stat_unif <- gofstat(fit.uniform, 
                     fitnames = c("uniform"))
stat_beta <- gofstat(fit.beta, 
                     fitnames = c("beta"))

stat_table <- cbind(rbind(stat_normal$ks, stat_normal$cvm),  
                    rbind(stat_unif$ks, stat_unif$cvm),
                    rbind(stat_beta$ks, stat_beta$cvm))
rownames(stat_table) <- c("Kolmogorov-Smirnov statistic", 
                          "Cramer-von Mises statistic")
stat_table

cdfcomp(list(fit.norm, fit.uniform), legendtext = c("normal", "unif"))
denscomp(list(fit.norm, fit.uniform), legendtext = c("normal", "unif"))
sort(a)
summary(a)
plot(ecdf(a))

fitdist(data = a, distr = "lnorm",method = "mle")
sum(c(2.4, 3.5, 3.2, 3.4, 2.5, 2.4, 3.1, 3.4, 3.8, 2.6))
a <- c(2.4, 3.5, 3.2, 3.4, 2.5, 2.4, 3.1, 3.4, 3.8, 2.6)
b <- a^5
sum(b)


1/10 * sum((c(24,54,41,17,48,33,42,44,92,27) - 55)^2)
qchisq()

asd <- c(0.3*174, 0.9*108, 1.5 * 72, 2.1 * 46, 2.7 * 3, 3.3 * 22, 3.9 * 15, 4.5 * 12, 5.1 * 7, 5.7 * 5) /ss 
ss <- sum(c(174,108,72,46,30,22,15,12,7,5))
sum(asd)

2*0.1 + 3*0.3 + 4*0.4 + 5*0.2
2^2*0.1 + 3^2*0.3 + 4^2*0.4 + 5^2*0.2

14.5 - 3.7^2


spb <- c(23, 24, 21, 23, 22, 21, 20, 21, 28, 25, 22, 22, 25, 21)
sort(spb)
mean(spb)
var(spb)
sum((spb - mean(spb))^2) / length(spb)
median(spb)
summary(spb)
sort(spb)[12]
qnorm(0.2563, mean = 2, sd = 3)

2.4^5 + 3.5^5 + 3.2^5 + 3.4^5 + 2.5^5 + 2.4^5+ 3.1^5 + 3.4^5 + 3.8^5 + 2.6^5
31^2 + 1 + 14^2 + 38^2 + 7^2 + 22^2 + 13^2 + 11^2 + 37^2 + 28^2

s_exp <- rexp(100,0.2)
s_geom <- rgeom(100, 0.3)
s_norm1 <- rnorm(100, 5, 2)
s_norm2 <- rnorm(100, 5, 0.5)
s_unif <- runif(100,1,9)
boxplot(s_geom, s_exp, s_norm1, s_norm2, s_unif)

height <- matrix(c(170, 66,
                          182, 74,
                          183, 77,
                          180, 72,
                          175, 67,
                          181, 77,
                          187, 76,
                          181, 77,
                          178, 72,
                          187, 76),ncol = 2, byrow = T)
height
cor(height[,1], height[,2])

k <- 8
p1 <- 0.7
n <- 140
p <- rep(NA, k+1)
q <- rep(NA, k+1)

p <- dbinom(c(0:8), 8, 0.7)


q <- qbinom(c(0:8), 8, 0.7)
set.seed(161)
y <- runif(n, 0, 1)
p_p <- rep(0,k+2)


p_p[1] <- sum(y < q[1])


for (i in 2:(k+2))
{
  p_p[i] <- sum(ifelse(y < q[i] & y >= q[i-1], 1, 0))
}
p_p
#sum(p_p)


q_q <- rep(NA,k+1)

q_q <- ifelse(y < q[2], 0, 
       ifelse(y < q[3] & y >= q[3-1], 1, 
       ifelse(y < q[4] & y >= q[4-1], 2, 
       ifelse(y < q[5] & y >= q[5-1], 3, 
       ifelse(y < q[6] & y >= q[6-1], 4,
       ifelse(y < q[7] & y >= q[7-1], 5,
       ifelse(y < q[8] & y >= q[8-1], 6,
       ifelse(y < q[9] & y >= q[9-1], 7,
       ifelse(y < q[10] & y >= q[10-1], 8,NA)))))))))
length(q_q)
mean(q_q)

#hist(q_q, breaks = c(0:(k+1)),xlim = range(c(0:(k+1))))
#axis(1, c(0:(k+1)), las = 1)

stat_series <- rbind(c(0:8), p_p, cumsum(p_p), cumsum(p_p) / n)
stat_series



q_q_sort <- sort(q_q)
q


library(fitdistrplus)
library(ggplot2)
dev.off()



    plot(ecdf(stat_series[4,] * k), col = "red", lwd = 1, verticals = F)

    plot(ecdf(q * k), col = "black", lwd = 1, verticals = F, add = T)
  
length(stat_series[4,] * k)
length(q * k)
plot(ecdf(cumsum(q)))
plot(ecdf(cumsum(stat_series[4,])), col = "red", add = T)
#plot(stat_series[4,], type = "s")
axis(1, c(0:(k)), las = 1)

kolm_stat <- max(abs((stat_series[4,] - q)))

mean(stat_series[4,])
mean(q)

sd(stat_series[4,])
sd(q)

sqrt(n) * kolm_stat
pbinom(100, 140, 0.7)

#quantile(, .15)


length(q_q / k)
length(y)

y*k
q_q

ks_test <- ks.test(unique(sort(q_q / k)), pbinom(0.1, 140, 0.7))
ks_test

k_alpha <- sqrt(-(1/2) * log2( (1 - 0.0001)/2 )) 
k_alpha

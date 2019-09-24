k <- 8
p1 <- 0.7
n <- 140
p <- rep(NA, k+1)
q <- rep(NA, k+1)

for (i in 0:k)
{
  p[i+1] <- choose(k, i)*p1^(i)*(1-p1)^(k-i)
}
p

q <- cumsum(p)

y <- runif(n, 0, 1)
p_p <- rep(0,k+1)

p_p[1] <- sum(y < q[1])
for (i in 2:(k+1))
{
  p_p[i-1] <- sum(ifelse(y < q[i] & y >= q[i-1], 1, 0))
}

#sum(p_p)

q_q <- rep(NA,k+1)

q_q <- ifelse(y < q[1], 0, 
       ifelse(y < q[2] & y >= q[2-1], 1, 
       ifelse(y < q[3] & y >= q[3-1], 2, 
       ifelse(y < q[4] & y >= q[4-1], 3, 
       ifelse(y < q[5] & y >= q[5-1], 4,
       ifelse(y < q[6] & y >= q[6-1], 5,
       ifelse(y < q[7] & y >= q[7-1], 6,
       ifelse(y < q[8] & y >= q[8-1], 7,
       ifelse(y < q[9] & y >= q[9-1], 8,0)))))))))
length(q_q)
mean(q_q)

hist(q_q, breaks = c(0:(k+1)),xlim = range(c(0:(k+1))))
axis(1, c(0:(k+1)), las = 1)

stat_series <- rbind(c(0:8), p_p, p_p / n)
stat_series

q_q_sort <- sort(q_q)

library(fitdistrplus)
library(ggplot2)
dev.off()
plot(ecdf(sort(q_q_sort)), col = "green")
#lines (sort(q_q_sort), (1:n)/n, type = 's', col="blue")
fit_bin <- fitdist(q_q_sort, "nbinom", discrete = T)
plot(cumsum(stat_series[3,-length(stat_series)]), type = "s")
ggplot(as.data.frame(q_q_sort), aes(q_q_sort)) + 
  stat_ecdf(geom = "step") +
  geom_step()
#cdfcomp(fit_bin)  
unique(q_q_sort)
##############################
plot(dlnorm(c(0:1e4), 2, sqrt(0.2)))

x <-xtable(B,align=rep("",ncol(B)+1), digits = 3)
print(x, floating=FALSE, tabular.environment="bmatrix", 
      hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)

library(xtable)
k <- 8
p1 <- 0.7
n <- 140

distr_series_table <- as.data.frame(rbind(c(0:k),
                            dbinom(c(0:k), k, p1)),
                            row.names = c("Random Value", "Probability")) 
colnames(distr_series_table) <- c(0:k)
sum(distr_series_table[2,])
distr_series_table

distr_series_table <- rbind(distr_series_table,
                            cumsum(dbinom(c(0:k), k, p1)))
row.names(distr_series_table)[3] <- "Delta"
distr_series_table


x <-xtable(distr_series_table,align=rep("",ncol(distr_series_table)+1), digits = 3)
print(x, floating=FALSE, tabular.environment="bmatrix", 
      hline.after=NULL, include.rownames=T, include.colnames=F)

sum(distr_series_table[2,])

distr_series_table <- rbind(distr_series_table)

set.seed(1337)
rand_unif <- runif(n, 0, 1)
head(rand_unif)

emp_sample <- ifelse(rand_unif < distr_series_table[3,1], 0, 
      ifelse(rand_unif < distr_series_table[3,2] & rand_unif >= distr_series_table[3,2-1], 1, 
      ifelse(rand_unif < distr_series_table[3,3] & rand_unif >= distr_series_table[3,3-1], 2, 
      ifelse(rand_unif < distr_series_table[3,4] & rand_unif >= distr_series_table[3,4-1], 3, 
      ifelse(rand_unif < distr_series_table[3,5] & rand_unif >= distr_series_table[3,5-1], 4,
      ifelse(rand_unif < distr_series_table[3,6] & rand_unif >= distr_series_table[3,6-1], 5,
      ifelse(rand_unif < distr_series_table[3,7] & rand_unif >= distr_series_table[3,7-1], 6,
      ifelse(rand_unif < distr_series_table[3,8] & rand_unif >= distr_series_table[3,8-1], 7,
      ifelse(rand_unif < distr_series_table[3,9] & rand_unif >= distr_series_table[3,9-1], 8,NA)))))))))

emp_sample

##
sum(emp_sample == 2)
hist_tmp <- hist(emp_sample, breaks = c(0:k))
hist_tmp$counts
hist_tmp$breaks

stat_series <- as.data.frame(rbind(c(0:k), c(0, hist_tmp$counts), (c(0, hist_tmp$counts) / n) ), row.names = c("Simulated values", "Frequencies", "Relative frequencies"))
colnames(stat_series) <- c(0:8)


######################################

p <- dbinom(c(0:k), k, p1)
cumsum(p)
cumsum(as.list(distr_series_table[2,]))


q <- pbinom(c(0:8), 8, 0.7)
set.seed(161)
rand_unif <- runif(n, 0, 1)
p_p <- rep(0,k+2)


p_p[1] <- sum(rand_unif < q[1])


for (i in 2:(k+2))
{
  p_p[i] <- sum(ifelse(rand_unif < q[i] & rand_unif >= q[i-1], 1, 0))
}
p_p
#sum(p_p)


q_q <- rep(NA,k+1)

q_q <- ifelse(rand_unif < q[2], 0, 
       ifelse(rand_unif < q[3] & rand_unif >= q[3-1], 1, 
       ifelse(rand_unif < q[4] & rand_unif >= q[4-1], 2, 
       ifelse(rand_unif < q[5] & rand_unif >= q[5-1], 3, 
       ifelse(rand_unif < q[6] & rand_unif >= q[6-1], 4,
       ifelse(rand_unif < q[7] & rand_unif >= q[7-1], 5,
       ifelse(rand_unif < q[8] & rand_unif >= q[8-1], 6,
       ifelse(rand_unif < q[9] & rand_unif >= q[9-1], 7,
       ifelse(rand_unif < q[10] & rand_unif >= q[10-1], 8,NA)))))))))
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
length(rand_unif)

rand_unif*k
q_q

ks_test <- ks.test(unique(sort(q_q / k)), pbinom(0.1, 140, 0.7))
ks_test

k_alpha <- sqrt(-(1/2) * log2( (1 - 0.0001)/2 )) 
k_alpha

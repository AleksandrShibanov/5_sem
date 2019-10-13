k <- 8
p1 <- 0.7
n <- 140
set.seed(1337)
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



sum(distr_series_table[2,])

distr_series_table <- rbind(distr_series_table)


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
##############################################################################



################################################################################
cp_ci_LB.01 <- qbeta(0.1/2, sum(emp_sample), 
                     n*k - sum(emp_sample) + 1)
cp_ci_LB.005 <- qbeta(0.05/2, sum(emp_sample), 
                      n*k - sum(emp_sample) + 1)
cp_ci_LB.002 <- qbeta(0.02/2, sum(emp_sample), 
                      n*k - sum(emp_sample) + 1)

cp_ci_UB.01 <- qbeta(1 - 0.1/2, sum(emp_sample) + 1, 
                     n*k - sum(emp_sample))
cp_ci_UB.005 <- qbeta(1 - 0.05/2, sum(emp_sample) + 1, 
                      n*k - sum(emp_sample))
cp_ci_UB.002 <- qbeta(1 - 0.02/2, sum(emp_sample) + 1, 
                      n*k - sum(emp_sample))

cp_cis <- as.data.frame( matrix(c(cp_ci_LB.01, cp_ci_UB.01,
                                  cp_ci_LB.005, cp_ci_UB.005,
                                  cp_ci_LB.002, cp_ci_UB.002), 
                                byrow = T, ncol = 2))
colnames(cp_cis) <- c("Lower", "Upper")
rownames(cp_cis) <- c("0.1", "0.05", "0.02")
cp_cis
##################################################

##################################################
stat1 <- sum(emp_sample)
stat1
uup <- function(theta) qbinom(0.02/2, n*k, theta)
lou <- function(theta) qbinom(1 - 0.02/2, n*k, theta)
png(filename = "../img/quantiles.png", 
    width = 1600, height = 1200,
    pointsize = 24, res = 96)
plot(uup, col = "red", xlab = "",ylab = "", lwd = 3)
plot(lou, col = "blue", lwd = 3, add = T)
abline(h = stat1, col = "green", lwd = 2, lty = 2)
legend("bottomright", 
       c("Quantile 0.02", "Quantile 1-0.02", "806"), 
       lty=c(1,1,2), 
       fill=c("red", "blue", "green"))
dev.off()
####################################################

####################################################

foo <- function(p) (sum(emp_sample) - n*k*p)/(sqrt(n*k*p*(1-p)))
png(filename = "../img/foo.png", 
    width = 1600, height = 1200,
    pointsize = 24, res = 96)
plot(foo, col = "red", lwd = 2, xlab = "p", ylab = "foo(p)")
dev.off()




#####################################################
library(rootSolve)

clt_ci_LB.01_foo <- function(p) (sum(emp_sample) - n*k*p)/
  (sqrt(n*k*p*(1-p))) - qnorm(1-0.1/2)
clt_ci_UB.01_foo <- function(p) (sum(emp_sample) - n*k*p)/
  (sqrt(n*k*p*(1-p))) + qnorm(1-0.1/2)

clt_ci_LB.005_foo <- function(p) (sum(emp_sample) - n*k*p)/
  (sqrt(n*k*p*(1-p))) - qnorm(1-0.05/2)
clt_ci_UB.005_foo <- function(p) (sum(emp_sample) - n*k*p)/
  (sqrt(n*k*p*(1-p))) + qnorm(1-0.05/2)

clt_ci_LB.002_foo <- function(p) (sum(emp_sample) - n*k*p)/
  (sqrt(n*k*p*(1-p))) - qnorm(1-0.02/2)
clt_ci_UB.002_foo <- function(p) (sum(emp_sample) - n*k*p)/
  (sqrt(n*k*p*(1-p))) + qnorm(1-0.02/2)

clt_ci_LB.01 <- uniroot(clt_ci_LB.01_foo, c(0.1, 0.9))$root
clt_ci_UB.01 <- uniroot(clt_ci_UB.01_foo, c(0.1, 0.9))$root

clt_ci_LB.005 <- uniroot(clt_ci_LB.005_foo, c(0.1, 0.9))$root
clt_ci_UB.005 <- uniroot(clt_ci_UB.005_foo, c(0.1, 0.9))$root

clt_ci_LB.002 <- uniroot(clt_ci_LB.002_foo, c(0.1, 0.9))$root
clt_ci_UB.002 <- uniroot(clt_ci_UB.002_foo, c(0.1, 0.9))$root

clt_cis <- as.data.frame( matrix(c(clt_ci_LB.01, clt_ci_UB.01,
                                  clt_ci_LB.005, clt_ci_UB.005,
                                  clt_ci_LB.002, clt_ci_UB.002), 
                                byrow = T, ncol = 2))
colnames(clt_cis) <- c("Lower", "Upper")
rownames(clt_cis) <- c("0.1", "0.05", "0.02")
clt_cis

compare_CI <- as.data.frame(matrix(c(clt_ci_LB.01, cp_ci_LB.01, 
                                     clt_ci_UB.01, cp_ci_UB.01,
                                     clt_ci_LB.005, cp_ci_LB.005,
                                     clt_ci_UB.005, cp_ci_UB.005,
                                     clt_ci_LB.002, cp_ci_LB.002,
                                     clt_ci_UB.002, cp_ci_UB.002), 
                                   ncol = 2, byrow = T))


theor_distr <- rbinom(n, k, p1)
distr_UB <- rbinom(n, k, cp_ci_UB.002)
distr_LB <- rbinom(n, k, cp_ci_LB.002)

png(filename = "../img/cdf_with_cis_1.png", 
    width = 1600, height = 1200,
    pointsize = 24, res = 96)
plot(ecdf(theor_distr), 
     col = "red", lwd = 3, verticals = T, axes = F,
     xlim = c(0,k+1), ylim = c(0,1.2),
     xlab = "Value", ylab = "CDF", main = "CDF with CIs")
plot(ecdf(distr_LB), 
     col = "black", lwd = 2, verticals = T, add = T)
plot(ecdf(distr_UB), 
     col = "blue", lwd = 2, verticals = T, add = T)
axis(1, c(1:k))
axis(2, seq(0.0, 1.2, 0.2), las = 1)
grid(nx = k+1, ny = 1.2 / 0.2)
legend("bottomright", c("Theoretical", "Lower", "Upper"), 
       lty=c(1,1,1), 
       fill=c("red", "black", "blue"))
dev.off()



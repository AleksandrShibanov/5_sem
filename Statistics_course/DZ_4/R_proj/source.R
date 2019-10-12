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
##############################################################################



################################################################################
cp_ci_LB.01 <- qbeta(0.1/2, sum(emp_sample), n*k - sum(emp_sample) + 1)
cp_ci_LB.005 <- qbeta(0.05/2, sum(emp_sample), n*k - sum(emp_sample) + 1)
cp_ci_LB.002 <- qbeta(0.02/2, sum(emp_sample), n*k - sum(emp_sample) + 1)

cp_ci_UB.01 <- qbeta(1 - 0.1/2, sum(emp_sample) + 1, n*k - sum(emp_sample))
cp_ci_UB.005 <- qbeta(1 - 0.05/2, sum(emp_sample) + 1, n*k - sum(emp_sample))
cp_ci_UB.002 <- qbeta(1 - 0.02/2, sum(emp_sample) + 1, n*k - sum(emp_sample))


library(rootSolve)

clt_ci_LB.01_foo <- function(p) (sum(emp_sample) - n*k*p)/(sqrt(n*k*p*(1-p))) - qnorm(1-0.1/2)
clt_ci_UB.01_foo <- function(p) (sum(emp_sample) - n*k*p)/(sqrt(n*k*p*(1-p))) + qnorm(1-0.1/2)

clt_ci_LB.005_foo <- function(p) (sum(emp_sample) - n*k*p)/(sqrt(n*k*p*(1-p))) - qnorm(1-0.05/2)
clt_ci_UB.005_foo <- function(p) (sum(emp_sample) - n*k*p)/(sqrt(n*k*p*(1-p))) + qnorm(1-0.05/2)

clt_ci_LB.002_foo <- function(p) (sum(emp_sample) - n*k*p)/(sqrt(n*k*p*(1-p))) - qnorm(1-0.02/2)
clt_ci_UB.002_foo <- function(p) (sum(emp_sample) - n*k*p)/(sqrt(n*k*p*(1-p))) + qnorm(1-0.02/2)

clt_ci_LB.01 <- uniroot(clt_ci_LB.01_foo, c(0.1, 0.9))$root
clt_ci_UB.01 <- uniroot(clt_ci_UB.01_foo, c(0.1, 0.9))$root

clt_ci_LB.005 <- uniroot(clt_ci_LB.005_foo, c(0.1, 0.9))$root
clt_ci_UB.005 <- uniroot(clt_ci_UB.005_foo, c(0.1, 0.9))$root

clt_ci_LB.002 <- uniroot(clt_ci_LB.002_foo, c(0.1, 0.9))$root
clt_ci_UB.002 <- uniroot(clt_ci_UB.002_foo, c(0.1, 0.9))$root


compare_CI <- as.data.frame(matrix(c(clt_ci_LB.01, cp_ci_LB.01, 
                                     clt_ci_UB.01, cp_ci_UB.01,
                                     clt_ci_LB.005, cp_ci_LB.005,
                                     clt_ci_UB.005, cp_ci_UB.005,
                                     clt_ci_LB.002, cp_ci_LB.002,
                                     clt_ci_UB.002, cp_ci_UB.002), ncol = 2, byrow = T))


theor_distr <- rbinom(n, k, p1)
distr_UB <- rbinom(n, k, cp_ci_UB.01)
distr_LB <- rbinom(n, k, cp_ci_LB.01)

plot(ecdf(theor_distr), 
     col = "red", lwd = 3, verticals = T, axes = F,
     xlim = c(0,k+1), ylim = c(0,1.2),
     xlab = "Value", ylab = "CDF", main = "Theoretical and Emperical CDF")
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




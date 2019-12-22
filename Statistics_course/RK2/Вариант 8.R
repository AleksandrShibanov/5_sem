########################################
#1
alpha <- 0.05
n <- 100
ss <- 3.882
a0 <- -3
a1 <- -2

cc <- qt(1-alpha, n-1)*ss/sqrt(n) + a0

pnorm(((-2.355-a1)/4) * sqrt(n))




#####################################
#3
CIr(rv, n, 0.95)


rv <- -0.21
n <- 93
alpha <- 0.05
CIr_lower_bound <- tanh(atanh(rv) - rv/(2*(n-1)) 
                        - qnorm(1-alpha/2)/sqrt(n-3))
CIr_lower_bound
CIr_upper_bound <- tanh(atanh(rv) - rv/(2*(n-1)) 
                        + qnorm(1-alpha/2)/sqrt(n-3))
CIr_upper_bound



crit_mn1 <- tanh(qnorm(alpha)/sqrt(n-3))
crit_mn1


crit_mn2 <- qt(alpha, n-2)/(sqrt(n-2+(qt(alpha, n-2))^2))
crit_mn2

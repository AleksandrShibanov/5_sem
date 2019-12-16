library(psychometric)
CIr(rv, n, 0.99)


rv <- 0.15
n <- 39
alpha <- 0.01
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
##############################################################
##############################################################
library(psychometric)
CIr(0.15,39,0.99)
CIrdif(0.71,0.85,28,39,0.99)


qnorm(0.995)
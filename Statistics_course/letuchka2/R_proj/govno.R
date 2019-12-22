x <- c(-0.04, -0.02, 0, 0.02, 0.04) # Viborka -- seredini intervalov
x_lev <- seq(from = -0.05, to = 0.03, by = 0.02)
x_prav <- seq(from = -0.03, to = 0.05, by = 0.02)
nu <- c(36, 29, 19, 18, 18) # Chastoti

n <- sum(nu)
n
alpha <- 0.1


mean_x <- as.numeric((x %*% nu)/n)
mean_x
sd_x <- sqrt(sum((nu*(x - mean_x)^2))) / sqrt(n)
sd_x

p_i <- pnorm(x_prav, mean = mean_x, sd = sd_x) - pnorm(x_lev, mean = mean_x, sd = sd_x)
sum(p_i)
npi <- n * p_i
npi

chi_sq <- sum(  (npi - nu)^2 /npi)
chi_sq

qchisq(1-alpha,2)


#########
rm(list = ls())


x <- 0:6 # Viborka 

nu <- c(400, 167, 29, 3, 0, 0, 1) # Chastoti

n <- sum(nu)
n
alpha <- 0.05

mean_x <- as.numeric((x %*% nu)/n)
mean_x

pi_bez_posl <- dpois(x[-length(x)], lambda = mean_x)
p_i <- c(pi_bez_posl, 1-sum(pi_bez_posl))
p_i
sum(p_i)

npi <- n * p_i
npi

chi_sq <- ( (npi[1] - nu[1])^2 / npi[1] ) + ( (npi[2] - nu[2])^2 / npi[2] ) + 
  ( (npi[3] + npi[4] + npi[5] + npi[6] + npi[7] - nu[3] - nu[4] - nu[5] - nu[6] - nu[7])^2 /
      (npi[3] + npi[4] + npi[5] + npi[6] + npi[7]) )

chi_sq
qchisq(1-alpha, 1)

##########################
rm(list = ls())

alpha <- 0.05
x <- 1:12 # Viborka 

nu <- c(7280, 6957, 7883, 7884, 7892, 7609, 7585, 7393, 7203, 6903, 6552, 7132)
sum(nu)

npi <- 88273/365 * c(31,28,31,30,31,30,31,31,30,31,30,31)


chi_sq <- sum((nu-npi)^2 / npi)
qchisq(1-alpha,11)






########################################################################
# ??????? 1
########################################################################
# ?????? 1
rm(list = ls())
x <- 0:4

nu <- c(132,43,20,3,2)
alpha <- 0.1


n <- sum(nu)
 
mean_x <- as.numeric((x %*% nu)/n)
mean_x

pi_bez_posl <- dpois(x[-length(x)], lambda = mean_x)
p_i <- c(pi_bez_posl, 1-sum(pi_bez_posl))
p_i
sum(p_i)

npi <- n * p_i
npi

chi_sq <- ( (npi[1] - nu[1])^2 / npi[1] ) + ( (npi[2] - nu[2])^2 / npi[2] ) + 
  ( (npi[3] + npi[4] + npi[5] - nu[3] - nu[4] - nu[5])^2 /
      (npi[3] + npi[4] + npi[5]) )

chi_sq
qchisq(1-alpha, 1)
####################
# ?????? 2
rm(list = ls())

alpha = 0.05

x <- seq(from = 5.10, to = 5.80, by = 0.10) # Viborka -- seredini intervalov
x_lev <- x - 0.05
x_prav <- x + 0.05
nu <- c(5,8,12,20,26,15,10,4) # Chastoti

n <- sum(nu)
n


mean_x <- as.numeric((x %*% nu)/n)
as.numeric((x %*% nu))
mean_x
sd_x <- sqrt(sum((nu*(x - mean_x)^2))) / sqrt(n)
sd_x

pi_1 <- pnorm(x_prav[1], mean = mean_x, sd = sd_x)
pi_ser <- pnorm(x_prav[-c(1, length(x_prav))], mean = mean_x, sd = sd_x) - pnorm(x_lev[-c(1, length(x_lev))], mean = mean_x, sd = sd_x)
pi_kon <- 1 - pi_1 -sum(pi_ser)
p_i <- c(pi_1, pi_ser, pi_kon)
sum(p_i)
npi <- n * p_i
npi

chi_sq <- ( (npi[1] + npi[2] - nu[1] - nu[2])^2 / (npi[1] + npi[2]) ) +
  ( (npi[3] - nu[3])^2 / npi[3] ) + 
  ( (npi[4] - nu[4])^2 / npi[4] ) + 
  ( (npi[5] - nu[5])^2 / npi[5] ) + 
  ( (npi[6] - nu[6])^2 / npi[6] ) + 
  ( (npi[7] + npi[8] - nu[7] - nu[8])^2 /
      (npi[7] + npi[8] ))

chi_sq

qchisq(1-alpha,6-1-2)



########################################################################
# ??????? 2
########################################################################
# ?????? 1
rm(list = ls())
x <- 0:7

nu <- c(112,168,130,68,32,5,1,1)
alpha <- 0.05


n <- sum(nu)
n

mean_x <- 1.5

pi_bez_posl <- dpois(x[-length(x)], lambda = mean_x)
p_i <- c(pi_bez_posl, 1-sum(pi_bez_posl))
p_i
sum(p_i)

npi <- n * p_i
npi

chi_sq <- ( (npi[1] - nu[1])^2 / npi[1] ) + 
  ( (npi[2] - nu[2])^2 / npi[2] ) + 
  ( (npi[3] - nu[3])^2 / npi[3] ) + 
  ( (npi[4] - nu[4])^2 / npi[4] ) + 
  ( (npi[5] - nu[5])^2 / npi[5] ) + 
  ( (npi[6] + npi[7] + npi[8] - nu[6] - nu[7] - nu[8])^2 /
      (npi[6] + npi[7] + npi[8]) )

chi_sq
qchisq(1-alpha, 6-2)
####################
# ?????? 2
rm(list = ls())

alpha <- 0.05
matr <- matrix(c(30472, 3238, 33710, 
                 3364, 9468, 12832,
                 33836, 12706, 46542), ncol = 3, byrow = T)
matr

n <- 46542
chi_sq <- n * ((matr[1,1])^2/(matr[3,1] * matr[1,3]) + 
                 (matr[1,2])^2 / (matr[3,2] * matr[1,3]) +
                 (matr[2,1])^2 / (matr[3,1] * matr[2,3]) +
                 (matr[2,2])^2 / (matr[3,2] * matr[2,3]) - 1
               )
chi_sq

npi_1_1 <- (matr[1,3] * matr[3,1]) / matr[3,3]
npi_1_2 <- (matr[3,2] * matr[1,3]) / matr[3,3]
npi_2_1 <- (matr[3,1] * matr[2,3]) / matr[3,3]
npi_2_2 <- (matr[3,2] * matr[2,3]) / matr[3,3]

chi_sq_1 <- ( (matr[1,1] - npi_1_1)^2 / npi_1_1 + 
                (matr[1,2] - npi_1_2)^2 / npi_1_2 + 
                (matr[2,1] - npi_2_1)^2 / npi_2_1 + 
                (matr[2,2] - npi_2_2)^2 / npi_2_2 
              )
chi_sq_1

qchisq(1-alpha, (2-1)*(2-1))
chisq.test(matr[-3,-3])

########################################################################
# ??????? 4
########################################################################
# ?????? 1
rm(list = ls())

x <- 0:5

nu <- c(6,16,36,27,11,4)
alpha <- 0.1


n <- sum(nu)
n

mean_x <- as.numeric((x %*% nu)/n)
mean_x

pi_bez_posl <- dpois(x[-length(x)], lambda = mean_x)
p_i <- c(pi_bez_posl, 1-sum(pi_bez_posl))
p_i
sum(p_i)

npi <- n * p_i
npi


chi_sq <- sum(  (npi - nu)^2 /npi)
chi_sq
qchisq(1-alpha, 6-2)

####################
# ?????? 2
rm(list = ls())

alpha <- 0.01
matr <- matrix(c(1768, 807, 180, 47,
                 946, 1387, 746, 53, 
                 115, 438, 288, 16), ncol = 4, byrow = T)
chisq.test(matr)
matr <- rbind(matr, colSums(matr))
matr <- cbind(matr, rowSums(matr))
matr

n <- 6791
chi_sq <- n * ((matr[1,1])^2/(matr[4,1] * matr[1,5]) + 
                 (matr[1,2])^2 / (matr[4,2] * matr[1,5]) +
                 (matr[1,3])^2 / (matr[4,3] * matr[1,5]) +
                 (matr[1,4])^2 / (matr[4,4] * matr[1,5]) +
                 
                 (matr[2,1])^2 / (matr[4,1] * matr[2,5]) +
                 (matr[2,2])^2 / (matr[4,2] * matr[2,5]) +
                 (matr[2,3])^2 / (matr[4,3] * matr[2,5]) +
                 (matr[2,4])^2 / (matr[4,4] * matr[2,5]) +
                 
                 (matr[3,1])^2 / (matr[4,1] * matr[3,5]) +
                 (matr[3,2])^2 / (matr[4,2] * matr[3,5]) +
                 (matr[3,3])^2 / (matr[4,3] * matr[3,5]) +
                 (matr[3,4])^2 / (matr[4,4] * matr[3,5]) +
                 
               - 1
)
chi_sq

npi_1_1 <- (matr[1,5] * matr[4,1]) / matr[4,5]
npi_1_2 <- (matr[1,5] * matr[4,2]) / matr[4,5]
npi_1_3 <- (matr[1,5] * matr[4,3]) / matr[4,5]
npi_1_4 <- (matr[1,5] * matr[4,4]) / matr[4,5]

npi_2_1 <- (matr[2,5] * matr[4,1]) / matr[4,5]
npi_2_2 <- (matr[2,5] * matr[4,2]) / matr[4,5]
npi_2_3 <- (matr[2,5] * matr[4,3]) / matr[4,5]
npi_2_4 <- (matr[2,5] * matr[4,4]) / matr[4,5]

npi_3_1 <- (matr[3,5] * matr[4,1]) / matr[4,5]
npi_3_2 <- (matr[3,5] * matr[4,2]) / matr[4,5]
npi_3_3 <- (matr[3,5] * matr[4,3]) / matr[4,5]
npi_3_4 <- (matr[3,5] * matr[4,4]) / matr[4,5]

chi_sq_1 <- ( (matr[1,1] - npi_1_1)^2 / npi_1_1 + 
                (matr[1,2] - npi_1_2)^2 / npi_1_2 + 
                (matr[1,3] - npi_1_3)^2 / npi_1_3 + 
                (matr[1,4] - npi_1_4)^2 / npi_1_4 +
                
                (matr[2,1] - npi_2_1)^2 / npi_2_1 + 
                (matr[2,2] - npi_2_2)^2 / npi_2_2 + 
                (matr[2,3] - npi_2_3)^2 / npi_2_3 + 
                (matr[2,4] - npi_2_4)^2 / npi_2_4 + 
                
                (matr[3,1] - npi_3_1)^2 / npi_3_1 + 
                (matr[3,2] - npi_3_2)^2 / npi_3_2 + 
                (matr[3,3] - npi_3_3)^2 / npi_3_3 + 
                (matr[3,4] - npi_3_4)^2 / npi_3_4 
                
)
chi_sq_1


###############################################################################
rm(list = ls())
alpha <- 0.1
qchisq(1-alpha, 2)

matr <- matrix(c(29, 38, 53,
                 1, 2, 7), ncol = 3, byrow = T)
matr
chisq.test(matr)
matr <- rbind(matr, colSums(matr))
matr <- cbind(matr, rowSums(matr))
matr

n <- 130
chi_sq <- n * ((matr[1,1])^2/(matr[3,1] * matr[1,4]) + 
                 (matr[1,2])^2 / (matr[3,2] * matr[1,4]) +
                 (matr[1,3])^2 / (matr[3,3] * matr[1,4]) +
                 
                 (matr[2,1])^2 / (matr[3,1] * matr[2,4]) +
                 (matr[2,2])^2 / (matr[3,2] * matr[2,4]) +
                 (matr[2,3])^2 / (matr[3,3] * matr[2,4]) +
                 
                 - 1
)
chi_sq

npi_1_1 <- (matr[1,5] * matr[4,1]) / matr[4,5]
npi_1_2 <- (matr[1,5] * matr[4,2]) / matr[4,5]
npi_1_3 <- (matr[1,5] * matr[4,3]) / matr[4,5]
npi_1_4 <- (matr[1,5] * matr[4,4]) / matr[4,5]

npi_2_1 <- (matr[2,5] * matr[4,1]) / matr[4,5]
npi_2_2 <- (matr[2,5] * matr[4,2]) / matr[4,5]
npi_2_3 <- (matr[2,5] * matr[4,3]) / matr[4,5]
npi_2_4 <- (matr[2,5] * matr[4,4]) / matr[4,5]

npi_3_1 <- (matr[3,5] * matr[4,1]) / matr[4,5]
npi_3_2 <- (matr[3,5] * matr[4,2]) / matr[4,5]
npi_3_3 <- (matr[3,5] * matr[4,3]) / matr[4,5]
npi_3_4 <- (matr[3,5] * matr[4,4]) / matr[4,5]

chi_sq_1 <- ( (matr[1,1] - npi_1_1)^2 / npi_1_1 + 
                (matr[1,2] - npi_1_2)^2 / npi_1_2 + 
                (matr[1,3] - npi_1_3)^2 / npi_1_3 + 
                (matr[1,4] - npi_1_4)^2 / npi_1_4 +
                
                (matr[2,1] - npi_2_1)^2 / npi_2_1 + 
                (matr[2,2] - npi_2_2)^2 / npi_2_2 + 
                (matr[2,3] - npi_2_3)^2 / npi_2_3 + 
                (matr[2,4] - npi_2_4)^2 / npi_2_4 + 
                
                (matr[3,1] - npi_3_1)^2 / npi_3_1 + 
                (matr[3,2] - npi_3_2)^2 / npi_3_2 + 
                (matr[3,3] - npi_3_3)^2 / npi_3_3 + 
                (matr[3,4] - npi_3_4)^2 / npi_3_4 
              
)
chi_sq_1
qchisq(1-0.01, 4)

#############################################
rm(list = ls())
x <- c(-1.2, -1.15, -0.91, -0.29, -0.12, 0.16, 1.06, 1.09, 1.22, 1.29)
ks.test(x, "pnorm")

library(DiceDesign)
unif.test.quantile("ks", 10, 0.05)
pnorm(x)
k <- 1:10
n <- 10
h <- (2 * k - 1)/(2*n)

abs(h-pnorm(x)) + 1/(2*n)
install.packages("BoutrosLab.plotting.general")
library(BoutrosLab.plotting.general)






############################
#1##########################
############################
rm(list = ls())
ti <- 0:10
u <- c(100,75, 55, 40, 30, 20, 15,10,10,5,5)
lm(log(u)~ti)
plot(ti,log(u))

f <- matrix(c(1,1,1,1,1,1,1,1,1,1,1, -ti), ncol = 2)
ft_f <- t(f) %*% f

solve(ft_f) %*% t(f) %*% log(u)

bb <- solve(t(f) %*% f) %*% t(f) %*% log(u)

exp(4.613)

sum(ti)








#############################
#2###########################
#############################
rm(list = ls())
alpha <- 0.01
qt(1-alpha/2, 37)
tb <- 0.15/sqrt(1-0.15^2) * sqrt(37)
x <- c(rep(20,4), rep(25,14), rep(30,46), rep(35,16), rep(40,20))
y <- c(rep(16,4), rep(16,6), rep(26,8), rep(26,10), rep(36,32), 
       rep(46,4), rep(36,3), rep(46,12), rep(56,1),rep(36,9), 
       rep(46,6),rep(56,5))
f <- matrix(c(rep(1,100), rep(20,4), rep(25,14), rep(30,46), 
              rep(35,16), rep(40,20)), ncol = 2)
f
length(y)
solve(t(f) %*% f) %*% t(f) %*% y

lm(y~x)
plot(x,y)


################
#4##############
################
rm(list = ls())
x <- 0:7
y <- c(112,168,130,68,32,5,1,1)
alpha <- 0.05
n <- sum(y)
mean_x <- x%*%y / n
mean_x

pi_bez_posl <- dpois(x[-length(x)], lambda = mean_x)
p_i <- c(pi_bez_posl, 1-sum(pi_bez_posl))
p_i
sum(p_i)

npi <- n * p_i
npi

chi_sq <- ( (npi[1] - y[1])^2 / npi[1] ) + ( (npi[2] - y[2])^2 / npi[2] ) + 
 ( (npi[3] - y[3])^2 / npi[3])  + ( (npi[4] - y[4])^2 / npi[4] ) +( (npi[5] - y[5])^2 / npi[5] ) +
  ( (npi[6] + npi[7] + npi[8] - y[6] - y[7] -y[8])^2 /
      (npi[6] + npi[7] + npi[8]) )

chi_sq
qchisq(1-alpha, 4)

#############
#5###########
#############
rm(list = ls())

x <- seq(2,12,2)
x
mk <- c(2,4,4,3,5,2)
mk
n <- sum(mk)
mk20 <- mk / 20

alpha <- 0.01
yk <- cumsum(mk20)
yk

k <- 1:6
k

vv <- cumsum(rep(1/6,6))
vv

(2*k - 1)/(2*6)


abs(yk - (2*k - 1)/(2*6)) + 1/(2*6)
max(abs(yk - (2*k - 1)/(2*6)) + 1/(2*6))

##########################################
# Normal distribution 1
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

###################################################################################
###################################################################################
# Poisson distribution 1

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


###################################################################################
###################################################################################
# Uniform distribution

alpha <- 0.05
x <- 1:12 # Viborka 

nu <- c(7280, 6957, 7883, 7884, 7892, 7609, 7585, 7393, 7203, 6903, 6552, 7132)
sum(nu)

npi <- 88273/365 * c(31,28,31,30,31,30,31,31,30,31,30,31)


chi_sq <- sum((nu-npi)^2 / npi)
qchisq(1-alpha,11)




###################################################################################
###################################################################################
# Poisson distribution 2

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



###################################################################################
###################################################################################
# Normal distribution 2


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


###################################################################################
###################################################################################
# Poisson distribution 3


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

###################################################################################
###################################################################################
# Poisson distribution 4

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

###################################################################################
###################################################################################
# Poisson distribution 5

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
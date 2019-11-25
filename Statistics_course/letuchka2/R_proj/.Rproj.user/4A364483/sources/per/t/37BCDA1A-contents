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

pi <- pnorm(x_prav, mean = mean_x, sd = sd_x) - pnorm(x_lev, mean = mean_x, sd = sd_x)
sum(pi)
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
pi <- c(pi, 1-sum(pi_bez_posl))
pi
sum(pi)

npi <- n * pi
npi

chi_sq <- ( (npi[1] - nu[1])^2 / npi[1] ) + ( (npi[2] - nu[2])^2 / npi[2] ) + 
  ( (npi[3] + npi[4] + npi[5] + npi[6] + npi[7] - nu[3] - nu[4] - nu[5] - nu[6] - nu[7])^2 /
      (npi[3] + npi[4] + npi[5] + npi[6] + npi[7]) )

chi_sq
qchisq(1-alpha, 1)

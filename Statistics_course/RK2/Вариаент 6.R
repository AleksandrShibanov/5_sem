###########################################
#3
CIr(rv, n, 0.95)


rv <- 0.58
n <- 28
alpha <- 0.05
CIr_lower_bound <- tanh(atanh(rv) - rv/(2*(n-1)) 
                        - qnorm(1-alpha/2)/sqrt(n-3))
CIr_lower_bound
CIr_upper_bound <- tanh(atanh(rv) - rv/(2*(n-1)) 
                        + qnorm(1-alpha/2)/sqrt(n-3))
CIr_upper_bound


##############################################
#5

alpha <- 0.1
beta <- 0.15


A <- (1-beta)/alpha
B <- beta/(1-alpha)

p0 <- 1/4
p1 <- 1/3

M0Yk <- p0*log(p1/p0) + (1-p0)*log((1-p1)/(1-p0))
M0Yk
M1Yk <- p1*log(p1/p0) + (1-p1)*log((1-p1)/(1-p0))
M1Yk

M0_nu <- (alpha*log(A) + (1-alpha)*log(B))/M0Yk
M1_nu <- (beta*log(B) + (1-beta)*log(A))/M1Yk


##################################################
#1
alpha <- 0.01
matr <- matrix(c(197, 3, 200, 
                 843, 7, 850,
                 1040, 10, 1050), ncol = 3, byrow = T)
matr

n <- 1050
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

##################################################
#2
m0 <- 40
m1 <- 40.3

n <- 36
sigma1 <- 1

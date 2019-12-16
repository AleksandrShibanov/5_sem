####################################################################
# 3x3 matrix
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


####################################################################
####################################################################
# 4x5 matrix
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

####################################################################
####################################################################
# 3x4 matrix

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


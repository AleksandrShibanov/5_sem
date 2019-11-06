library(xtable)
A <- matrix(c(12,1,2,3,
              1,12,3,-2,
              2,3,12,1,
              3,-2,1,12), byrow = T, ncol = 4)
phi <- 1/2 * atan(1/((A[1,1] -A[4,4])/(2 * A[1,4])))

Q <- matrix(c(cos(phi),0,0,-sin(phi),
              0,1,0,0,
              0,0,1,0,
              sin(phi),0,0,cos(phi)), byrow = T, ncol = 4)
Q_t <- t(Q)

A1 <- Q_t %*% A %*% Q



############
phi1 <- 1/2 * atan(1/((A1[2,2] -A1[3,3])/(2 * A1[2,3])))

Q1 <- matrix(c(1,0,0,0,
               0,cos(phi1),-sin(phi1),0,
               0,sin(phi1),cos(phi1),0,
               0,0,0,1), byrow = T, ncol = 4)
Q1_t <- t(Q1)

A2 <- Q1_t %*% A1 %*% Q1




############
phi2 <- 1/2 * atan(1/((A2[1,1] -A2[3,3])/(2 * A2[1,3])))

Q2 <- matrix(c(cos(phi2),0,-sin(phi2),0,
               0,1,0,0,
               sin(phi2),0,cos(phi2),0,
               0,0,0,1), byrow = T, ncol = 4)

Q2_t <- t(Q2)

A3 <- Q2_t %*% A2 %*% Q2









##############
phi3 <- 1/2 * atan(1/((A3[2,2] -A3[4,4])/(2 * A3[2,4])))

Q3 <- matrix(c(1,0,0,0,
               0,cos(phi3),0,-sin(phi3),
               0,0,1,0,
               0,sin(phi3),0,cos(phi3)), byrow = T, ncol = 4)

Q3_t <- t(Q3)

A4 <- Q3_t %*% A3 %*% Q3


##############
phi4 <- 1/2 * atan(1/((A4[3,3] -A4[4,4])/(2 * A4[3,4])))

Q4 <- matrix(c(1,0,0,0,
               0,1,0,0,
               0,0,cos(phi4),-sin(phi4),
               0,0,sin(phi4),cos(phi4)), byrow = T, ncol = 4)

Q4_t <- t(Q4)

A5 <- Q4_t %*% A4 %*% Q4



##############
phi5 <- 1/2 * atan(1/((A5[1,1] -A5[2,2])/(2 * A5[1,2])))

Q5 <- matrix(c(cos(phi5),-sin(phi5),0,0,
               sin(phi5),cos(phi5),0,0,
               0,0,1,0,
               0,0,0,1), byrow = T, ncol = 4)

Q5_t <- t(Q5)

A6 <- Q5_t %*% A5 %*% Q5



##############
phi6 <- 1/2 * atan(1/((A6[1,1] -A6[4,4])/(2 * A6[1,4])))

Q6 <- matrix(c(cos(phi6),0,0,-sin(phi6),
              0,1,0,0,
              0,0,1,0,
              sin(phi6),0,0,cos(phi6)), byrow = T, ncol = 4)

Q6_t <- t(Q6)

A7 <- Q6_t %*% A6 %*% Q6


##############
phi7 <- 1/2 * atan(1/((A7[2,2] -A7[3,3])/(2 * A7[2,3])))

Q7 <- matrix(c(1,0,0,0,
               0,cos(phi7),-sin(phi7),0,
               0,sin(phi7),cos(phi7),0,
               0,0,0,1), byrow = T, ncol = 4)

Q7_t <- t(Q7)

A8 <- Q7_t %*% A7 %*% Q7

eigen(A)$values

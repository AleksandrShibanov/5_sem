N <- 9
n <- 53
alpha <- (n - 50) / 100
A <- matrix(c(50 * (1 + 0.5 * N + alpha),
               50 * (1 + 0.5 * N),
               50 * (1 + 0.5 * N),
               50.1 * (1 + 0.5 * N),
               49.9 * (1 + 0.5 * N + alpha),
               50 * (1 + 0.5 * N),
               49.9 * (1 + 0.5 * N),
               50 * (1 + 0.5 * N),
               50.1 * (1 + 0.5 * N + alpha)),
               nrow = 3, ncol = 3, byrow = T)
A
B <- matrix(c(50 * (3 + 1.5* N + alpha),
              50 * (3 + 1.5* N + alpha),
              50 * (3 + 1.5* N + alpha)))
B
B_dB <- matrix(c(50 * (1 + 0.01) * (3 + 1.5* N + alpha),
                 50 * (1 - 0.01) * (3 + 1.5* N + alpha),
                 50 * (1 + 0.01) * (3 + 1.5* N + alpha)))
B_dB

A_inv <- solve(A)

A_inv_norm <- norm(A_inv, "i")
A_norm <- norm(A, "i")

cond_A <- A_inv_norm * A_norm
cond_A
###################################################################################
#
X <- solve(A, B)
X
A %*% X

delta_B <- B_dB - B
delta_B

delta_B_norm <- norm(delta_B, "i")
delta_B_norm

B_norm <- norm(B, "i")
B_norm

delta_X <- solve(A, delta_B)
delta_X

X_norm <- norm(X, "i")
X_norm
delta_X_norm <- norm(delta_X, "i")
delta_X_norm

(delta_X_norm / X_norm) <= cond_A * (delta_B_norm / B_norm)

######################################################################################
rm(list = ls())
N <- 9
n <- 53
alpha <- (n - 50) / 100
lambda <- 0.6 - alpha
f <- function(x) cos(x)
a <- 0
b <- 1
h <- (b - a) / 10

s1 <- a + h / 2
s2 <- s1 + h
s3 <- s2 + h
s4 <- s3 + h
s5 <- s4 + h
s6 <- s5 + h
s7 <- s6 + h
s8 <- s7 + h
s9 <- s8 + h
s10 <- s9 + h

s <- c(s1, s2, s3, s4, s5, s6, s7, s8, s9, s10)
t <- s
s[2]

a_ij <- matrix(rep(NA, 100), nrow = 10, ncol = 10)
for (i in 1:10)
{
  for (j in 1:10)
  {
    a_ij[i,j] <- cos(s[i] * t[j]) * h
  }
}

qu_ij <- diag(10) + lambda * a_ij
qu_ij

qu_ij_inv <- solve(qu_ij)
qu_ij_inv

qu_ij_norm <- norm(qu_ij, "i")
qu_ij_norm

qu_ij_inv_norm <- norm(qu_ij_inv)
qu_ij_inv_norm

cond_q <- qu_ij_norm * qu_ij_inv_norm
cond_q

X <- matrix(rep(1,10), ncol = 1)
B <- qu_ij %*% X

delta_B <- 0.01 * B[ifelse()]

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
library(matlib)
library(xtable)
showEqn(round(A, 4), B, latex=TRUE)
showEqn(round(A, 4), B_dB, latex=TRUE)

x <-xtable(A,align=rep("",ncol(A)+1), digits = 3)
print(x, floating=FALSE, tabular.environment="bmatrix", 
      hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)

x <-xtable(B,align=rep("",ncol(B)+1), digits = 3)
print(x, floating=FALSE, tabular.environment="bmatrix", 
      hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)

x <-xtable(A_inv,align=rep("",ncol(A_inv)+1), digits = 3)
print(x, floating=FALSE, tabular.environment="bmatrix", 
      hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)

x <-xtable(B_dB,align=rep("",ncol(B_dB)+1), digits = 3)
print(x, floating=FALSE, tabular.environment="bmatrix", 
      hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)
###################################################################################
#
X <- solve(A, B)


x <-xtable(X,align=rep("",ncol(X)+1), digits = 7)
print(x, floating=FALSE, tabular.environment="bmatrix", 
      hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)

A %*% X

delta_B <- B_dB - B
delta_B

delta_B_norm <- norm(delta_B, "i")
delta_B_norm

B_norm <- norm(B, "i")
B_norm

delta_X <- solve(A, delta_B)
delta_X

x <-xtable(delta_X,align=rep("",ncol(delta_X)+1), digits = 7)
print(x, floating=FALSE, tabular.environment="bmatrix", 
      hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)

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
f <- function(x) atan(x)
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
    a_ij[i,j] <- f(s[i] * t[j]) * h
  }
}

x <-xtable(a_ij,align=rep("",ncol(a_ij)+1), digits = 7)
print(x, floating=FALSE, tabular.environment="bmatrix", 
      hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)

e_plus_lambda_a <- diag(10) + lambda * a_ij # E + lambda*A
e_plus_lambda_a

x <-xtable(e_plus_lambda_a,align=rep("",ncol(e_plus_lambda_a)+1), digits = 7)
print(x, floating=FALSE, tabular.environment="bmatrix", 
      hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)

e_plus_lambda_a_inv <- solve(e_plus_lambda_a)
e_plus_lambda_a_inv

x <-xtable(e_plus_lambda_a_inv,align=rep("",ncol(e_plus_lambda_a_inv)+1), digits = 6)
print(x, floating=FALSE, tabular.environment="bmatrix", 
      hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)

e_plus_lambda_a_norm <- norm(e_plus_lambda_a, "i")
e_plus_lambda_a_norm

e_plus_lambda_a_inv_norm <- norm(e_plus_lambda_a_inv, "i")
e_plus_lambda_a_inv_norm

cond_e_pl_lm <- e_plus_lambda_a_norm * e_plus_lambda_a_inv_norm
cond_e_pl_lm

X <- matrix(rep(1,10), ncol = 1)
B <- e_plus_lambda_a %*% X
B_norm <- norm(B, "i")

x <-xtable(B,align=rep("",ncol(B)+1), digits = 6)
print(x, floating=FALSE, tabular.environment="bmatrix", 
      hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)


delta_B <- 0.01 * as.matrix(ifelse(seq(1,10,1) %% 2, B, -B))
delta_B

x <-xtable(delta_B,align=rep("",ncol(delta_B)+1), digits = 6)
print(x, floating=FALSE, tabular.environment="bmatrix", 
      hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)

delta_B_norm <- norm(delta_B, "i")
delta_B_norm

B_pl_delta_B <- B + delta_B
B_pl_delta_B

x <-xtable(B_pl_delta_B,align=rep("",ncol(B_pl_delta_B)+1), digits = 6)
print(x, floating=FALSE, tabular.environment="bmatrix", 
      hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)

B_pl_delta_B_norm <- norm(B_pl_delta_B, "i")
B_pl_delta_B_norm

X_plus_delta_X <- solve(e_plus_lambda_a, B + delta_B)
X_plus_delta_X

x <-xtable(X_plus_delta_X,align=rep("",ncol(X_plus_delta_X)+1), digits = 6)
print(x, floating=FALSE, tabular.environment="bmatrix", 
      hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)

delta_X <- X_plus_delta_X - 1
delta_X

x <-xtable(delta_X,align=rep("",ncol(delta_X)+1), digits = 6)
print(x, floating=FALSE, tabular.environment="bmatrix", 
      hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)

X_approx <- X_plus_delta_X - delta_X
X_approx

delta_X_norm <- norm(delta_X, "i")
delta_X_norm
X_approx_norm <- norm(X_approx, "i")
X_approx_norm

relative_error <- delta_X_norm / X_approx_norm
relative_error
cond_e_pl_lm * (delta_B_norm / B_norm)


temp <- B + delta_B

A_divided2 <- matrix(rep(NA, 100), nrow = 10, ncol = 10)

for (i in 1:10)
{
  for (j in 1:10)
  {
    A_divided2[i,j] <- e_plus_lambda_a[i,j] / temp[i]
  }
}
A_divided2

x <-xtable(A_divided2,align=rep("",ncol(A_divided2)+1), digits = 6)
print(x, floating=FALSE, tabular.environment="bmatrix", 
      hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)


A_divided2_inv <- solve(A_divided2)

x <-xtable(A_divided2_inv,align=rep("",ncol(A_divided2_inv)+1), digits = 6)
print(x, floating=FALSE, tabular.environment="bmatrix", 
      hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)


X_sec <- A_divided2_inv %*% matrix(rep(1,10), ncol = 1)
X_sec

x <-xtable(matrix(rep(1,10), ncol = 1),align=rep("",ncol(matrix(rep(1,10), ncol = 1))+1), digits = 6)
print(x, floating=FALSE, tabular.environment="bmatrix", 
      hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)

x <-xtable(X_sec,align=rep("",ncol(X_sec)+1), digits = 6)
print(x, floating=FALSE, tabular.environment="bmatrix", 
      hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)

delta_X_sec <- 1 - X_sec
delta_X_sec

x <-xtable(delta_X_sec,align=rep("",ncol(delta_X_sec)+1), digits = 6)
print(x, floating=FALSE, tabular.environment="bmatrix", 
      hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)

delta_X_sec_norm <- norm(delta_X_sec, "i")
delta_X_sec_norm

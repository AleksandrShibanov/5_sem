alpha  <-  0.1
a0 <- 7.5
sigma0 <- 2.4
a1 <- 8
sigma1 <- 2.5
eps <- 0.1
n <- 100

df <- unlist(read.csv("data.csv", header = F, sep = ";"), use.names = F)
df

summary(df)
df_mean <- mean(df)
df_sd <- sd(df)
df_len <- length(df)
df_df <- length(df) - 1
df_min <- min(df)
df_max <- max(df)
df_var <- var(df)

c1 <- a0 + (qnorm(1-alpha))/(sqrt(df_len)) * sigma1
beta <- pnorm((c1-a1)/sigma1 * sqrt(df_len))


A <- (1-beta)/alpha
B <- beta/(1-alpha)

M0Yk <- -(a1-a0)^2 / (2*sigma1^2)
M1Yk <- (a1-a0)^2 / (2*sigma1^2)

M0_nu <- (alpha*log(A) + (1-alpha)*log(B))/M0Yk
M1_nu <- (beta*log(B) + (1-beta)*log(A))/M1Yk

C1 <- c1
C2 <- 100 * C1
C3 <- 100 * (a0^2-a1^2)/(2*sigma1^2) + C2 * (a1-a0)/(sigma1^2)
C <- exp(C3)








library(nortest)
pearson.test(df)

alpha  <-  0.05
a0 <- -4
sigma0 <- 1.4
a1 <- -4.5
sigma1 <- 1.5
eps <- 0.05
n <- 90

df <- unlist(read.csv("data_Alina.csv", header = F, sep = ";"), use.names = F)
df

summary(df)
df_mean <- mean(df)
df_sd <- sd(df)
df_len <- length(df)
df_df <- length(df) - 1
df_min <- min(df)
df_max <- max(df)
df_var <- var(df)

c1 <- a0 + (qnorm(alpha))/(sqrt(df_len)) * sigma1
beta <- 1 - pnorm((c1-a1)/sigma1 * sqrt(df_len))


A <- (1-beta)/alpha
B <- beta/(1-alpha)

M0 <- -(a1-a0)^2 / (2*sigma1^2)
M1 <- (a1-a0)^2 / (2*sigma1^2)

M0_nu <- (alpha*log(A) + (1-alpha)*log(B))/M0
M1_nu <- (beta*log(B) + (1-beta)*log(A))/M1

f <- function(data,x)
{
  return(prod(exp(  ( (data * (a1 - a0))/(sigma1^2) ) + ( (a0^2 - a1^2)/(2*sigma1^2) )  )))
}
f(df)
curve(f(df,x),0,100)

# v.0 <- function(x)
# {
#   2*x+5
# }
# 
# v.1 <- function(x)
# {
#   x^2-2*x-8
# }
# 
# n <- 10
# 
# v.k <- list()
# 
# makefunc <- function(x) { x; function() x }
# 
# for (i in c(2:n))
# {
#   v.k[[i]] <- function(x, i)
#   {
#     (x + 2) * (1 - x)^i
#   }
# }
# 
# v.k[[2]](2)

A <- read.csv("df.csv", header = F, sep = ";")
A <- A[-length(A)]

A <- as.matrix(A)
A_1 <- as.numeric(A)

A <- matrix(c(450, -5319/20, -63909/140, -245187/280)
            , nrow = 10, ncol = 10)

qqq <- rep(NA, 10)

library(rSymPy) 
x <- Var("x")
i <- 2
i <- Var("2")
sympy("integrate( (x + 2) * (1 - x)**as.symbol(i) )")  



for (i in c(2:n))
{
  qqq[i] <- integral()
}

foo <- function(i)
{
  return((x + 2) * (1 - x)^i)
}
integral(foo)





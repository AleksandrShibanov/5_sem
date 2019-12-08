N <- 6
n <- 53
f <- function(t)
{
  (10 + 0.5*N)/(1 + (20 + 0.25*N)*(1 + 0.05*(53-n)) * t^2) 
}
  
x <- seq(from = -1, to = 1, by = 2/20)

y <- f(xi)
dat <- data.frame(cbind(x, y))

s <- function(t)
{
  
}
f(1)


n <- 50
r0 <- 0.687
alpha <- 0.05
r_1 <- tanh(atanh(r0)-r0/(2*(n-1)) - (qnorm(1-alpha/2))/sqrt(n-3))
r_2 <- tanh(atanh(r0)-r0/(2*(n-1)) + (qnorm(1-alpha/2))/sqrt(n-3))

install.packages("psychometric")
library(psychometric)
CIr(0.687,50,0.95)
CIrdif(.657, .430, 62, 143)
install.packages("plot3D")
library(plot3D)

##  Simulate data:
set.seed(2002)
x <- rnorm(1000)
y <- rnorm(1000)

##  Create cuts:
x_c <- cut(x, 20)
y_c <- cut(y, 20)

##  Calculate joint counts at cut levels:
z <- table(x_c, y_c)

##  Plot as a 3D histogram:
hist3D(z=z, border="black")

##  Plot as a 2D heatmap:
image2D(z=z, border="black")


x <- rchisq(1000, df = 4)
hs <- hist(x, breaks = 15)


VV   <- volcano[seq(1, 87, 15), seq(1, 61, 15)]
hist3D(z = VV, scale = FALSE, expand = 0.01, border = "black")


hist3D(z = VV, scale = FALSE, expand = 0.01, 
       alpha = 0.5, opaque.top = TRUE, border = "black")

hist3D(z = VV, scale = FALSE, expand = 0.01, facets = FALSE, lwd = 2)

hist3D(z = VV, scale = FALSE, expand = 0.01, facets = NA)

clim <- range(volcano)
persp3D(z = volcano, zlim = c(100, 600), clim = clim, 
        box = FALSE, plot = F)

persp3D(z = volcano + 200, clim = clim, colvar = volcano, 
        add = TRUE, colkey = FALSE, plot = F)

persp3D(z = volcano + 400, clim = clim, colvar = volcano, 
        add = TRUE, colkey = FALSE)    # plot = TRUE by default

image2D(z=z, border="black")
#

CIr(0.15,39,0.9)
CIrdif(0.71,0.85,28,39,0.99)


qnorm(0.995)






(atanh(-0.87)-atanh(-0.65))/(sqrt(1/121 +1/144))





tanh(qnorm(0.1)/sqrt(49))
atanh()
###
library(rSymPy)

lagrange.poly <- function(x, y) {
  
  l <- list() # List to store Lagrangian polynomials L_{1,2,3,4}
  k <- 1
  
  for (i in x) {
    # Set the numerator and denominator of the Lagrangian polynomials to 1 and build them up
    num <- 1
    denom <- 1
    
    # Remove the current x value from the iterated list
    p <- x[! x %in% i]
    
    # For the remaining points, construct the Lagrangian polynomial by successively 
    # appending each x value
    for (j in p) {
      num <- paste(num, "*", "(", 'x', " - ", as.character(j), ")", sep = "", collapse = "")
      denom <- paste(denom, "*", "(", as.character(i)," - ", as.character(j), ")", sep = "", collapse = "")
    }
    
    # Set each Lagrangian polynomial in rSymPy to simplify later.
    l[k] <- paste("(", num, ")", "/", "(", denom, ")", sep = "", collapse = "")
    k <- k + 1
  }
  
  # Similar to before, we construct the final Lagrangian polynomial by successively building 
  # up the equation by iterating through the polynomials L_{1,2,3,4} and the y values 
  # corresponding to the x values.
  eq <- 0
  
  for (i in 1:length(y)) {
    eq <- paste(eq, '+', as.character(y[i]), "*", l[[i]], sep = "", collapse = "")
  }
  
  # Define x variable for rSymPy to simplify
  x <- Var('x')
  
  # Simplify the result with rSymPy and return the polynomial
  return(sympy(paste("simplify(", eq, ")")))
}

lagrange.poly(xi, fi)

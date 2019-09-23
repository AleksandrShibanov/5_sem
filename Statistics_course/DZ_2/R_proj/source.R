xx <- runif(140, 0, 1)
x1 <- xx[xx < 0.7]
x2 <- xx[xx >= 0.7]
length(x1)
length(x2)




##############################
plot(dlnorm(c(0:1e4), 2, sqrt(0.2)))


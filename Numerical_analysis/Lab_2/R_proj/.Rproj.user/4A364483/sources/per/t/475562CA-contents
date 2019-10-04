tab2<- read.csv("../table_2_N_9.csv", header = F, dec = ',', sep = "\n")
tab3 <- read.csv("../table_4.csv", header = T, dec = ',', sep = ";")
x <- c(1:20)
y <- tab2$V1
plot(x, tab2$V1)

fit <- lm(y ~ poly(x,6))
points(x, predict(fit), type="l")
summary(fit)


summary(tab2)
plot(c(1:20),tab2$V1, ylim = c(10,20))
q <- seq(from=0, to=20, by=0.1)
model <- lm(tab2$V1 ~ poly(tab2$V1,6))
summary(model)
confint(model, level=0.95)
predicted_intervals <- predict(model, interval = 'confidence', level = 0.99)
lines(tab2$V1,predicted_intervals[,1],col='green',lwd=3)
lines(tab2$V1,predicted_intervals[,2],col='black',lwd=1)
lines(tab2$V1,predicted_intervals[,3],col='black',lwd=1)


plot(model)
dev.off()




file <- read.csv("doc.csv", header = F) #???????????? ????????????
####################################################
#1
max_element <- max(file$V1) #???????????????????????? ?????????????? ??????????????
max_element
min_element <- min(file$V1) #?????????????????????? ?????????????? ??????????????
min_element
mean_element <- mean(file$V1)
w <- max_element - min_element #???????????? ??????????????
w
sort(file$V1) #???????????????????? ?????????????? ???? ??????????????????????
n <- length(file$V1) #???????????????????? ????????????
n
#####################################################
#2
numofint = round(1 + log2(length(file$V1))) #?????????? ???????????????????? ???? ?????????????? ???????????????????? 
numofint
width<- w / numofint # ???????????? ??????????????????
width
mean(file$V1)
#####################################################
#####################################################
plot1 <- hist(file$V1, col="gray70",
              breaks = seq(min_element, max_element, by = width), 
              xlim = c(0, 25), ylim = c(0.00,0.12), axes = F, freq = F,
              main = "Histogram with Chisq density", plot = F)

relative_freq <- plot1$counts / length(file$V1) #
relative_freq

relative_freq/width
plot1$density
plot1$breaks

ppp<-plot1$mids - width/2
plot1$breaks

p1 <- pchisq(plot1$breaks[2], mean_element)

p2 <- pchisq(plot1$breaks[3], mean_element) - pchisq(plot1$breaks[2], mean_element)
p3 <- pchisq(plot1$breaks[4], mean_element) - pchisq(plot1$breaks[3], mean_element)
p4 <- pchisq(plot1$breaks[5], mean_element) - pchisq(plot1$breaks[4], mean_element)
p5 <- pchisq(plot1$breaks[6], mean_element) - pchisq(plot1$breaks[5], mean_element)
p6 <- pchisq(plot1$breaks[7], mean_element) - pchisq(plot1$breaks[6], mean_element)
p7 <- pchisq(plot1$breaks[8], mean_element) - pchisq(plot1$breaks[7], mean_element)
p8 <- 1 - p1 - p2 - p3 - p4 - p5 - p6 - p7
p1+p2+p3+p4+p5+p6+p7+p8
pt <- c(p1,p2,p3,p4,p5,p6,p7,p8)
npt <- pt * n

chi_sq <- sum((npt[-(7:8)] -  plot1$counts[-c(7:8)])^2/(npt[-(7:8)]) + 
  (npt[7] + npt[8] -  plot1$counts[7] -  plot1$counts[8])^2 / (npt[7] + npt[8]))

chi_sq <- sum((npt[-(7:8)] - plot1$counts[-c(7:8)])^2 /(npt[-(7:8)]) + 
                (npt[7] + npt[8] - plot1$counts[7] - plot1$counts[8])^2 / (npt[7] + npt[8]))

sum(chi_sq)
qchisq(0.95,5)
chisq.test(file)
sum(npt)
(npt[1]-9)^2/npt[1]+(npt[2]-30)^2/npt[2]+(npt[3]-34)^2/npt[3]+(npt[4]-20)^2/npt[4+(npt[5]-15)^2/npt[5]]+(npt[6]-6)^2/npt[6]+(npt[7]+npt[8]-6)^2/(npt[7]+npt[8])
pchisq(plot1$breaks[-2], mean_element) - pchisq(plot1$breaks[-length(plot1$breaks)], mean_element)
plot1$breaks[-1]
plot1$breaks[-length(plot1$breaks)]

par(mar = c(3, 3, 2, 1), xaxs = "i", yaxs = "i")
plot1 <- hist(file$V1, col="gray70",
              breaks = seq(min_element, max_element, by = width), 
              xlim = c(0, 25), ylim = c(0.00,0.12), axes = F, freq = F,
              main = "Histogram with Chisq density")
axis(1, seq(0, 25, 1))
axis(2, seq(0.00, 0.12, 0.01), las = 1)
curve(dchisq(x, df=10), 0.15, 25, 
      xlim = c(0,20), add = T, col = "blue", lwd = 3)

####################################################
####################################################
#3
png(filename = "../img/Histogram.png", #???????????????????? ??????????????????????
    width = 1920, height = 1080,
    pointsize = 24, res = 96 * 1.25)
paramentrs(mar = c(3, 3, 2, 1), xaxs = "i", yaxs = "i")
plot1 <- hist(file$V1, col="gray70",
            breaks = seq(min_element, max_element, by = width), 
            xlim = c(0, 25), ylim = c(0.00,0.12), axes = F, freq = F,
            main = "Histogram")
axis(1, seq(0, 25, 1))
axis(2, seq(0.00, 0.12, 0.01), las = 1)
dev.off()

f<-cbind(plot1$breaks[-length(plot1$breaks)],plot1$counts) # f
p <- plot1$counts / length(file$V1) # p=f[2]/n
sum(p)# =1
f1<-p/w #f1
f1
####################################################
#4
mean_element <- mean(file$V1) #???????????????????? ??????????????
mean_element
variance_element <- var(file$V1) #???????????????????? ??????????????????
variance_element

####################################################
#5

### ?????????? ?????????????????????????? ?? ?????????????????????? ????????????=5.242, ??????????=0.523
png(filename = "../img/hist_with_gamma_dens.png", 
    width = 1920, height = 1080,
    pointsize = 24, res = 96 * 1.25)
par(mar = c(3, 3, 2, 1), xaxs = "i", yaxs = "i")
plot1 <- hist(file$V1, col="gray70",
              breaks = seq(min_element, max_element, by = width), 
              xlim = c(0, 25), ylim = c(0.00,0.12), axes = F, freq = F,
              main = "Histogram with Gamma density")
axis(1, seq(0, 25, 1))
axis(2, seq(0.00, 0.12, 0.01), las = 1)
curve(dgamma(x, shape=5.242, scale=1/0.523 ), 0.12, 25, 
      xlim = c(0,20), add = T, col = "red", lwd = 3)
dev.off()

# ???? ?????????????? ?????????????????????????? ?? ???????????? ???????????????? ??????????????=10.022
png(filename = "../img/hist_with_chisq_dens.png", 
    width = 1920, height = 1080,
    pointsize = 24, res = 96 * 1.25)
par(mar = c(3, 3, 2, 1), xaxs = "i", yaxs = "i")
plot1 <- hist(file$V1, col="gray70",
              breaks = seq(min_element, max_element, by = width), 
              xlim = c(0, 25), ylim = c(0.00,0.12), axes = F, freq = F,
              main = "Histogram with Chisq density")
axis(1, seq(0, 25, 1))
axis(2, seq(0.00, 0.12, 0.01), las = 1)
curve(dchisq(x, df=10.02202 ), 0.15, 25, 
      xlim = c(0,20), add = T, col = "blue", lwd = 3)
dev.off()

### ?????????? ?? ???? ?????????????? ?????????????????????????? ???? ?????????? ??????????????
png(filename = "../img/hist_with_gamma_and_chisq_dens.png", 
    width = 1920, height = 1080,
    pointsize = 24, res = 96 * 1.25)
par(mar = c(3, 3, 2, 1), xaxs = "i", yaxs = "i")
plot1 <- hist(file$V1, col="gray70",
              breaks = seq(min_element, max_element, by = width), 
              xlim = c(0, 25), ylim = c(0.00,0.12), axes = F, freq = F,
              main = "Histogram with Gamma and Chisq density")
axis(1, seq(0, 25, 1))
axis(2, seq(0.00, 0.12, 0.01), las = 1)
curve(dgamma(x, shape=5.242, scale=1/0.523 ), 0.12, 25, 
      xlim = c(0,20), add = T, col = "red", lwd = 3)
curve(dchisq(x, df=10.02202 ), 0.15, 25, 
      xlim = c(0,20), add = T, col = "blue", lwd = 3)
dev.off()

####################################################
#6
#???????????????????????? ?? ?????????????????????????? ?????????????? ?????????? ??????????????????????????
png(filename = "../img/emp_and_theor_CDF_gamma.png", 
    width = 1920, height = 1080,
    pointsize = 24, res = 96 * 1.25)
plot(ecdf(x), 
     main = "Empirical and theoritical CDF for the Gamma density", 
     lwd = 2, col = "green",
     xlab = "", ylab = "")
lines (x, (1:n)/n, type = 's', 
       col="green", lwd = 2)
curve(pgamma(x, shape=5.242, scale=1/0.523), 25, 1, 
      xlim = c(0,25), add = T, 
      col = "red", lwd = 3)
axis(1, seq(0, 25, 1))
dev.off()

#???????????????????????? ?? ?????????????????????????? ?????????????? ???? ?????????????? ??????????????????????????
png(filename = "../img/emp_and_theor_CDF_chisq.png", 
    width = 1920, height = 1080,
    pointsize = 24, res = 96 * 1.25)
plot(ecdf(x), 
     main = "Empirical and theoritical CDF for the Chisq density", 
     lwd = 2, col = "green",
     xlab = "", ylab = "")
lines (x, (1:n)/n, type = 's', 
       col="green", lwd = 2)
curve(pchisq(x, df=10.02202), 25, 1, 
      xlim = c(0,20), add = T, 
      col = "blue", lwd = 3)
axis(1, seq(0, 25, 1))
dev.off()

#???????????????????????? ?? ?????????????????????????? ?????????????? ?????????? ?? ???? ?????????????? ??????????????????????????
png(filename = "../img/emp_and_theor_CDF_gamma_chisq.png", 
    width = 1920, height = 1080,
    pointsize = 24, res = 96 * 1.25)
plot(ecdf(x), 
     main = "Empirical and theoritical CDF for the Gamma and Chisq density", 
     lwd = 2, col = "green",
     xlab = "", ylab = "")
lines (x, (1:n)/n, type = 's', 
       col="green", lwd = 2)
curve(pgamma(x, shape=5.242, scale=1/0.523), 25, 1, 
      xlim = c(0,25), add = T, 
      col = "red", lwd = 3)
curve(pchisq(x, df=10.02202), 25, 1, 
      xlim = c(0,20), add = T, 
      col = "blue", lwd = 3)
axis(1, seq(0, 25, 1))
dev.off()

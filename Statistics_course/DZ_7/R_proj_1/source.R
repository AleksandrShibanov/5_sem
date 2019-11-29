df <- read.csv("enrika.csv", header = F, sep = ";") #data import
df$V1
##############################################################################
#1
max_el <- max(df)
max_el
min_el <- min(df)
min_el
range_el <- max_el - min_el
range_el
sort(df$V1)
length(df)
###############################################################################
#2
num_bins = round(1 + log2(length(df$V1)))
num_bins

bin_width <- range_el / num_bins
bin_width


png(filename = "../img/hist_without_dens.png", 
    width = 1920, height = 1080,
    pointsize = 24, res = 96 * 1.25)
par(mar = c(3, 3, 2, 1), xaxs = "i", yaxs = "i")
pl1 <- hist(df$V1,
            breaks = seq(min_el, max_el, by = bin_width), 
            xlim = c(0, 20), ylim = c(0.00,0.10), axes = F, freq = F,
            main = "Histogram of data")
axis(1, seq(0, 20, 1))
axis(2, seq(0.00, 0.10, 0.01), las = 1)
grid(nx = 20, ny = 10, equilogs = F)
dev.off()

#$###########################################################################
#$###########################################################################
pl1 <- hist(df$V1,
            breaks = seq(min_el, max_el, by = bin_width), 
            xlim = c(-10, 10), ylim = c(0.00,0.10), axes = F, freq = F,
            main = "Histogram of data", plot = F)

n <- length(df$V1)

relative_freq <- pl1$counts / length(df$V1)
relative_freq

relative_freq/bin_width

pl1$density
pl1$breaks


pl1$breaks

a <- min(df)
b <- max(df)

pt1 <- c(punif(pl1$breaks[2],a,b),
         punif(pl1$breaks[-c(1:2,length(pl1$breaks))], a,b)
        - punif(pl1$breaks[-c(1,(length((pl1$breaks))-1):
                                length((pl1$breaks)))], a,b))
pt1
pt <- c(pt1, 1-sum(pt1))
pt

npt <- pt * n
npt

chi_sq <- sum((npt - pl1$counts)^2/(npt))
chi_sq

qchisq(0.98,5)





png(filename = "../img/hist_with_unif_dens_enrika.png", 
    width = 1920, height = 1080,
    pointsize = 24, res = 96 * 1.25)
par(mar = c(3, 3, 2, 1), xaxs = "i", yaxs = "i")
pl1 <- hist(df$V1,
            breaks = seq(min_el, max_el, by = bin_width), 
            xlim = c(-10, 10), ylim = c(0.00,0.10), axes = F, freq = F,
            main = "Histogram of data")
axis(1, seq(-10, 10, 1))
axis(2, seq(0.00, 0.10, 0.01), las = 1)
grid(nx = 20, ny = 10, equilogs = F)
curve(dunif(x, a, b), a, b, 
      xlim = c(-10,10), add = T, col = "red", lwd = 3)
legend("topright", c("uniform density"), 
       lty=c(1), 
       fill=c("red"))
dev.off()


#$###########################################################################
#$##########################################################################
relative_freq <- pl1$counts / length(df$V1)
relative_freq


mean_el <- mean(df$V1)
mean_el
median_el <- median(df$V1)
median_el

range_el
var_el <- var(df$V1)
var_el
sd_el <- sd(df$V1)
sd_el

##########################################################################
#3
library(fitdistrplus)
library(logspline)
library(MASS)



dev.off()

png(filename = "../img/cullen_and_frey_graph.png", 
    width = 1920, height = 1080,
    pointsize = 24, res = 96 * 1.25)
descdist(df$V1,method = "sample", boot = 1e4)
dev.off()












library(scales)
res <- rescale(df$V1)
res

fit.weibull <- fitdist(df$V1, "weibull")
fit.norm <- fitdist(df$V1, "norm", method = "mme")
fit.uniform <- fitdist(df$V1, "unif", method = "mme")
fit.beta <- fitdist(res, "beta", method = "mme")



png(filename = "../img/fit_norm.png", 
    width = 1920, height = 1080,
    pointsize = 24, res = 96 * 1)
plot(fit.norm)
dev.off()

png(filename = "../img/fit_unif.png", 
    width = 1920, height = 1080,
    pointsize = 24, res = 96 * 1)
plot(fit.uniform)
dev.off()

png(filename = "../img/fit_beta.png", 
    width = 1920, height = 1080,
    pointsize = 24, res = 96 * 1)
plot(fit.beta)
dev.off()





fit.uniform$cor
fit.uniform$aic
fit.norm$aic
fit.weibull$aic
cdfcomp(list(fit.norm, fit.weibull), legendtext = c("normal", "weibull"))
denscomp(list(fit.norm, fit.weibull), legendtext = c("normal", "weibull"))
qqcomp(list(fit.norm, fit.weibull), legendtext = c("normal", "weibull"))
ppcomp(list(fit.norm, fit.weibull), legendtext = c("normal", "weibull"))



stat_normal <- gofstat(fit.norm, 
                       fitnames = c("normal"))
stat_unif <- gofstat(fit.uniform, 
                     fitnames = c("uniform"))
stat_beta <- gofstat(fit.beta, 
                     fitnames = c("beta"))

stat_table <- cbind(rbind(stat_normal$ks, stat_normal$cvm),  
                    rbind(stat_unif$ks, stat_unif$cvm),
                    rbind(stat_beta$ks, stat_beta$cvm))
rownames(stat_table) <- c("Kolmogorov-Smirnov statistic", 
                          "Cramer-von Mises statistic")
stat_table

stat_beta$cvmtest
stat_normal



############################################################################
#4


png(filename = "../img/hist_with_unif_dens.png", 
    width = 1920, height = 1080,
    pointsize = 24, res = 96 * 1.25)
par(mar = c(3, 3, 2, 1), xaxs = "i", yaxs = "i")
pl1 <- hist(df$V1,
            breaks = seq(min_el, max_el, by = bin_width), 
            xlim = c(0, 20), ylim = c(0.00,0.10), axes = F, freq = F,
            main = "Histogram of data")
axis(1, seq(0, 20, 1))
axis(2, seq(0.00, 0.10, 0.01), las = 1)
grid(nx = 20, ny = 10, equilogs = F)
curve(dunif(x, 2.5978, 17.9383), 2.5978, 17.9383, 
      xlim = c(0,20), add = T, col = "red", lwd = 3)
legend("topright", c("uniform density"), 
       lty=c(1), 
       fill=c("red"))
dev.off()

#############################################################################
#5
n <- length(df$V1)
x <- sort(df$V1)
vals <- unique(x)
rval <- approxfun(vals, 
                  cumsum(tabulate(match(x, vals)))/n, 
                  method = "constant", yleft = 0, yright = 1, f = 0,
                  ties = "ordered")

png(filename = "../img/emp_and_theor_CDF.png", 
    width = 1920, height = 1080,
    pointsize = 24, res = 96 * 1.25)
plot(ecdf(x), 
     main = "Empirical and theoritical distribution functions", 
     lwd = 3, col = "lightgreen",
     xlab = "", ylab = "")
lines (x, (1:n)/n, type = 's', 
       col="blue", lwd = 2)
curve(punif(x, 2.5978, 17.9383), 2.5978, 17.9383, 
      xlim = c(0,20), add = T, 
      col = "red", lwd = 3)
legend("bottomright", 
       c("emperical CDF", "theoritical CDF"), 
       lty = 1, col = c("blue", "red"))
axis(1, seq(0, 20, 1))
dev.off()
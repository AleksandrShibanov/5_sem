n <- 120

set.seed(1337)
rand_vect <- runif(n, 0, 1)
head(rand_vect, 5)

emp_sample <- qlnorm(rand_vect, meanlog = 2, sdlog = sqrt(0.2))
emp_sample

##
library(fitdistrplus)

png(filename = "../img/graphics_1.png", 
    width = 1920, height = 1080,
    pointsize = 24, res = 96)
plotdist(emp_sample, distr = "lnorm", list(2,sqrt(0.2)),
         histo = T, demp = T)
dev.off()
##

emp_mean <- mean(emp_sample)
emp_mean

theor_mean <- mean(theor_distr)
theor_mean


emp_sd <- sd(emp_sample)
emp_sd

theor_sd <- sd(theor_distr)
theor_sd


##
library(sfsmisc)
ecdf.ksCI(emp_sample)



###############
approx.ksD <- function(n) 
{
  ## оценка критического значения статистики Колмогорова-
  ## Смирнова D для доверительного уровня 0.95.
  ## реализована по Bickel & Doksum, table IX,  p.483
  ## и Lienert G.A.(1975) 
  ifelse(n > 80, 1.358 /( sqrt(n) + .12 + .11/sqrt(n)),   ##B&D
         splinefun(c(1:9, 10, 15, 10 * 2:8),# from Lienert
                   c(.975,   .84189, .70760, .62394, .56328,  # 1:5
                     .51926, .48342, .45427, .43001, .40925,  # 6:10
                     .33760, .29408, .24170, .21012,     # 15,20,30,40
                     .18841, .17231, .15975, .14960)) (n))
}

approx.ksD(length(emp_sample))

################################################################################################################
# Функция, формирующая доверительные интервалы ECDF
get_df.ecdf <- function(x, level = 0.05) {
  n <- length(x)
  x.sort <- sort(x)
  y <- (1:n)/n 
  # CI по теореме Дворецкого-Кифера-Вольфовица (ДКВ)
  epsilon = sqrt(log(2/level)/(2*n))
  L = pmax(y - epsilon, 0)
  U = pmin(y + epsilon, 1)
  D <- approx.ksD(n)
  U3 <- pmin(y + D, 1)
  L3 <- pmax(y - D, 0)
  # CI на основе центральной предельной теоремы (ЦПТ)
  z <- qnorm(1-level/2)
  U2 = pmin(y + z*sqrt(y*(1-y)/n ),1)
  L2 = pmax(y - z*sqrt(y*(1-y)/n ),0)
  data.frame(x=x.sort, y, L, U, L2, U2, L3, U3) 
}

# Формирование таблицы
df.emp <- get_df.ecdf(emp_sample)


# Создание графика
library(ggplot2)


png(filename = "../img/emp_cdfs_1.png", 
    width = 1920, height = 1080,
    pointsize = 24, res = 96 * 1.25)
ggplot(df.emp, aes(x=x, y=y)) + 
  # Эмпирические распределения
  geom_line(aes(colour="Emperical CDF"),size=2) + 
  # Заливаются области доверительных интервалов ДКВ
  geom_ribbon(aes(ymin = L, ymax = U, fill = "Dvoretzky–Kiefer–Wolfowitz"), 
              alpha = 0.5) + 
  geom_line(aes(x = x, y = L3, colour = "KS approximation"), 
            linetype = "3313", size = 1) +
  geom_line(aes(x = x, y = U3, colour = "KS approximation"), 
            linetype = "3313", size = 1) +
  # Рисуются кривые доверительных интервалов ЦПТ
  geom_line(aes(x = x, y = L2, colour = "Central limit theorem"), 
            linetype = "dashed", size = 1) +
  geom_line(aes(x = x, y = U2, colour = "Central limit theorem"), 
            linetype = "dashed", size = 1) +
  labs(x = 'Sample values',
       y = 'CDF') +
  theme_bw()
dev.off()



n = length(emp_sample)
nrep = 200

# новые данные для построения плавной кривой
newxs <- (seq(min(emp_sample), max(emp_sample), length.out = 100))

# добавление в итоговую таблицу координат ECDF
pdat <- data.frame(newxs, py = ecdf(emp_sample)(newxs))

# создание бутстреп-выборок
boots <- t(replicate(nrep, 
                     emp_sample[sample.int(n, replace = TRUE)]))
bootdat <- data.frame(apply(boots, 1, function(x) ecdf(x)(newxs))) 

# извлечение доверительных интервалов
cis <- apply(bootdat, 1, quantile, c(0.025, 0.975))
rownames(cis) <- c('lwr', 'upr')

# добавление доверительных интервалов
pdat <- cbind(pdat, t(cis))

# таблица бустреп-кривых
bootdat$newxs <- newxs
require(reshape2)
bootline <- melt(bootdat, id = 'newxs')

# Вывод итогового графика с использованием пакета  ggplot2
png(filename = "../img/emp_cdfs_2.png", 
    width = 1920, height = 1080,
    pointsize = 24, res = 96 * 1.25)
ggplot()+
  labs(x = 'Sample values', y = 'CDF')  + 
  geom_line(data = bootline, aes(x = newxs, y = value, group = variable), 
            col = 'steelblue', alpha = 0.5) +
  geom_smooth(data = pdat,  aes(x = newxs, y = py), 
              col = 'red', size=1.2, se= FALSE) +
  geom_smooth(data = pdat, aes(x = newxs, y = lwr), 
              linetype = 'dashed', size=1.2, se= FALSE) +
  geom_smooth(data = pdat, aes(x = newxs, y = upr), 
              linetype = 'dashed', size=1.2, se= FALSE) +
  geom_smooth(data = df.emp, aes(x = x, y = L), 
              linetype = '3313', col = 'green',size=1, se= FALSE) +
  geom_smooth(data = df.emp, aes(x = x, y = U), 
              linetype = '3313', col = 'green',size=1, se= FALSE) +
  theme_bw()
dev.off()



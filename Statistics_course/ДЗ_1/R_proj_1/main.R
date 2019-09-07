df <- read.csv("db.csv", header = F)
#1
max_el <- max(df)
min_el <- min(df)
range_el <- max_el - min_el

#2
num_bins = floor(1 + log2(length(df$V1)))

#3
library(ggplot2)
pl1 <- ggplot(df, aes(x = df$V1)) + 
  geom_histogram(aes(y=..density..), binwidth = (range_el / num_bins), col = "black",
                 fill = "lightblue") +
  scale_x_continuous(1, 1:20) +
  geom_density(position = "stack")
  #stat_bin(binwidth=(range_el / num_bins), geom="text", aes(label=..count..), vjust=0.25) 
pl1
counts <- c(8, 17, 17, 22, 11, 22, 17, 8)
pl1
relative_freq <- counts / length(df$V1)
relative_freq

h <- range_el / num_bins

f1 <- relative_freq / h
f1
sum(f1)

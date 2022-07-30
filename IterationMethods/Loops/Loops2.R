# Data file for R code in Iteration Paper

library(microbenchmark)
library(dplyr)

laundry <- read.csv("../laundry.csv")

data_size <- 1000


# Poorly written Loops ----------------------------------------------------
# Violates 2 Rules 

loop_worst <- function(){
   y<- NA
  
  for (i in 1:data_size) {
   x <- rnorm(1)
   x <- x^5
   c <- sin(5)^2/pi 
   y_new <- x*c 
   y <- c(y, y_new)
  }
}

# Poorly written Loops ----------------------------------------------------
# Violates 1 Rule 


loop_bad1 <- function(){
  y<- numeric(data_size)
  
  for (i in 1:data_size) {
    x <- rnorm(1)
    x <- x^5
    c <- sin(5)^2/pi 
    y_new <- x*c 
    y[i] <- y_new
  }
  
}



# Poorly written Loops ----------------------------------------------------
# Violates 1 Rule (the other one)


loop_bad2 <- function(){
  y<- NA
  c <- sin(5)^2/pi 
  
  for (i in 1:data_size) {
    x <- rnorm(1)
    x <- x^5
    y_new <- x*c 
    y <- c(y, y_new)
  }
  
}


# Better Loop ----------------------------------------------------
# Does not violate loop 


loop_good <- function(){
  y <- numeric(data_size)
  c <- sin(5)^2/pi 
  
  for (i in 1:data_size) {
    x <- rnorm(1)
    x <- x^5
    y_new <- x*c 
    y[i] <- y_new
  }
  
  
}


# Time Benchmark ----------------------------------------------------------

t <- microbenchmark::microbenchmark(loop_worst(), 
                                    loop_bad1(), 
                                    loop_bad2(),
                                    loop_good(),
                                    times = 1000)
t_keep <- data_frame(time = t$time[t$time < quantile(t$time, .95)], 
                     expr = t$expr[t$time < quantile(t$time, .95)], 
                     index = 1:length(t$time[t$time < quantile(t$time, .95)]))

boxplot(t_keep$time~t_keep$expr)
tapply(t$time, t$expr, mean)

ggplot(t_keep, aes(y = time, x = index))+
  geom_line(aes(color = expr))

boxplot(t)
autoplot(t)

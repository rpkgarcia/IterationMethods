# Data file for R code in Iteration Paper

# https://stackoverflow.com/questions/25081604/vectorize-vs-apply
library(microbenchmark)


install.packages("dplyr")                 # Install dplyr package
library("dplyr")
# Vectorization -----------------------------------------------------------


# Vectorization: Vectorized Approach --------------------------------------


x <- 1:1000
y <- rep(0:1, 500)
z <- rep(0, 1000)

# NonVectorized Approach
for(i in 1:1000){
  z[i] <- x[i] + y[i]
}

# Vectorized Approach 
z <- x + y 


# For Time 
vec_add_loop <- function(){
  for(i in 1:100){
    z[i] <- x[i] + y[i]
  }
}

vec_add <- function(){
  z <- x+ y 
}
set.seed(62)
t <- microbenchmark::microbenchmark(vec_add_loop,
                                    vec_add, 
                                    times = 1000000)
t_keep <- list()
t_keep$time <- t$time[t$time < quantile(t$time, .95)]
t_keep$expr <- t$expr[t$time < quantile(t$time, .95)]
boxplot(t_keep$time~t_keep$expr)
tapply(t$time, t$expr, mean)

plot(cummean(t$time[t$expr=="vec_add_loop"]), type = "l", ylim = c(10, 40))
lines(cummean(t$time[t$expr=="vec_add"]), type = "l", col = "red")

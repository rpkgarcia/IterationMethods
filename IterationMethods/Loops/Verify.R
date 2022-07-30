# Verify CRAN R News paper results 
n <- 

time1 <- function(n){
  a <- NULL
  for(i in 1:n) a<- c(a, i^2)
  a 
}

time2 <- function(n){
  a <- numeric(n)
  for(i in 1:n) a[i] <- i^2
  a 
}

time3 <- function(n){
  a <- (1:n)^2
  a
}

n<-100
t <- microbenchmark(time1(n), 
                    time2(n), 
                    time3(n), 
                    times = 1000)

boxplot(t)
autoplot(t)


# System.time -------------------------------------------------------------

system.time(replicate(1000, time1()))

# Data file for R code in Iteration Paper

# https://stackoverflow.com/questions/25081604/vectorize-vs-apply
library(microbenchmark)


install.packages("dplyr")                 # Install dplyr package
library("dplyr")


# Apply Family ------------------------------------------------------------



# THIS EXAMPLE
# https://stackoverflow.com/questions/28983292/is-the-apply-family-really-not-vectorized?rq=1
# https://pages.cs.wisc.edu/~st471-1/Rnotes/SimSpeed.html

set.seed(62)
mat <- rnorm(1000*1000, mean = 0, sd = 1)
mat <- matrix(mat, nrow = 1000, ncol = 1000)
mat = (mat)

loop1 <- function(x){
  col_means <- NA
  for(i in 1:ncol(x)){
    col_means[i] = mean(x[,i])
  }
}

loop2 <- function(x){
  col_means <- rep(NA, ncol(x))
  for(i in 1:ncol(x)){
    col_means[i] = mean(x[,i])    
  }
}

apply1 <- function(x){
  col_means <- apply(x, 2, mean)
}

baseFUN <- function(x){
  col_means <-colMeans(x)
}

t <- microbenchmark::microbenchmark(loop1(mat), 
                                    loop2(mat), 
                                    apply1(mat), 
                                    baseFUN(mat), 
                                    times = 100)
boxplot(t$time~t$expr, ylim = c(0, 21870000))

boxplot(t)
autoplot(t)

i39 <- sapply(3:9, seq) # list of vectors
sapply(i39, fivenum)
vapply(i39, fivenum,
       c(Min. = 0, "1st Qu." = 0, Median = 0, "3rd Qu." = 0, Max. = 0), 
       FUN.VALUE = logical(5))

sapply(iris, is.numeric)
vapply(iris, is.numeric, logical(1))
vapply(iris, is.numeric, numeric(1))

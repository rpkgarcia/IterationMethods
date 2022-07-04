# Data file for R code in Iteration Paper

# https://stackoverflow.com/questions/25081604/vectorize-vs-apply
library(microbenchmark)


install.packages("dplyr")                 # Install dplyr package
library("dplyr")

# Loop --------------------------------------------------------------------

for(name in expr1){
  expr2
}


xc <- split(iris$Sepal.Length, iris$Species)
yc <- split(iris$Sepal.Width, iris$Species)
for (i in 1:3) {
  plot(xc[[i]], yc[[i]])
  abline(lsfit(xc[[i]], yc[[i]]))
}



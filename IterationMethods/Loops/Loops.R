# Data file for R code in Iteration Paper

library(microbenchmark)
library(dplyr)

laundry <- read.csv("../laundry.csv")


# Basic For Loop ----------------------------------------------------------

for(name in expr1){
  expr2
}



# Poorly written Loops ----------------------------------------------------
# Violates 2 Rules 

loop_worst <- function(){
  x_split <- split(laundry$soiled_level, laundry$group)
  y_split <- split(laundry$size, laundry$group)
  group_sizes <- NA
  
  for (i in 1:length(y_split)) {
    # Plotting Range 
    x_range <- range(laundry$soiled_level)
    y_range <- range(laundry$size)
    
    # Make plot 
    plot(x_split[[i]], y_split[[i]], 
         xlim = x_range, 
         ylim = y_range, 
         main = paste("Group", LETTERS[[i]]))
    
    # Calculate median for each group 
    group_sizes <- c(group_sizes, length(y_split[[i]]))
  }
  
}

# Poorly written Loops ----------------------------------------------------
# Violates 1 Rule 


loop_bad1 <- function(){
  x_split <- split(laundry$soiled_level, laundry$group)
  y_split <- split(laundry$size, laundry$group)
  group_sizes <- NA
  
  # Plotting Range 
  x_range <- range(laundry$soiled_level)
  y_range <- range(laundry$size)
  
  for (i in 1:length(y_split)) {
    
    # Make plot 
    plot(x_split[[i]], y_split[[i]], 
         xlim = x_range, 
         ylim = y_range, 
         main = paste("Group", LETTERS[[i]]))
    
    # Calculate median for each group 
    group_sizes <- c(group_sizes, length(y_split[[i]]))
  }
  
}



# Poorly written Loops ----------------------------------------------------
# Violates 1 Rule (the other one)


loop_bad2 <- function(){
  x_split <- split(laundry$soiled_level, laundry$group)
  y_split <- split(laundry$size, laundry$group)
  group_sizes <- numeric(length(y_split))
  
  for (i in 1:length(y_split)) {
    
    # Plotting Range 
    x_range <- range(laundry$soiled_level)
    y_range <- range(laundry$size)
    
    # Make plot 
    plot(x_split[[i]], y_split[[i]], 
         xlim = x_range, 
         ylim = y_range, 
         main = paste("Group", LETTERS[[i]]))
    
    # Calculate median for each group 
    group_sizes[i] <- length(y_split[[i]])
  }
  
}


# Better Loop ----------------------------------------------------
# Does not violate loop 


loop_good <- function(){
  x_split <- split(laundry$soiled_level, laundry$group)
  y_split <- split(laundry$size, laundry$group)
  group_sizes <- numeric(length(y_split))
  
  for (i in 1:length(y_split)) {
    
    # Plotting Range 
    x_range <- range(laundry$soiled_level)
    y_range <- range(laundry$size)
    
    # Make plot 
    plot(x_split[[i]], y_split[[i]], 
         xlim = x_range, 
         ylim = y_range, 
         main = paste("Group", LETTERS[[i]]))
    
    # Calculate median for each group 
    group_sizes[i] <- length(y_split[[i]])
  }
  
}


# Time Benchmark ----------------------------------------------------------

t <- microbenchmark::microbenchmark(loop_worst(), 
                                    loop_bad1(), 
                                    loop_bad2(),
                                    loop_good(),
                                    times = 100)
# t_keep <- data_frame(time = t$time, 
#                      expr = t$expr, 
#                      index = 1:length(t$time))
# 
# boxplot(t_keep$time~t_keep$expr)
# tapply(t$time, t$expr, mean)
# 
# ggplot(t_keep, aes(y = time, x = index))+
#   geom_line(aes(color = expr))
summary(t)
boxplot(t)
autoplot(t)


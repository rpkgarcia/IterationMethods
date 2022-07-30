# Generate the "Laundry Data" 
library(ggplot2)

set.seed(62)
n = 1000

# Soiledness: How diry is the item?
#   - random uniform 0 - 1
soiled_level <- runif(n)

# Size: How much space does the item take in the machine?
size <- rexp(n)

# Item Group: Think socks/pants/towels/etc, or delicates/lights/etc
group_size <-function(x){
  group <- rmultinom(1, 1, prob = x^seq(1, 4, by = .5))
  group <- LETTERS[which(group == 1)]
}
group <- sapply(size, group_size)
group <- factor(group)


# Build data set 
laundry <- data.frame(soiled_level, size, group)
write.csv(laundry, "laundry.csv", row.names = FALSE)

# Preview 
ggplot(laundry, aes(size))+
  geom_histogram() + 
  facet_wrap(group)


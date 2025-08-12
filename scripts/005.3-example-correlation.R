## Script for the meta-pre-post project
## Script #5.3: Example Case - Get reasonable correlation parameter
## written by Simon Nolte in 08/2025

library(metapp)

# read data from similar studies analysed by Rosenblat et al. (2025)
ros <- read.csv("data/example/rosenblat.csv")

# code missing SDs
ros$sd_pre[ros$sd_pre == 0] <- NA
ros$sd_post[ros$sd_post == 0] <- NA

# calculate pre-post correlation from change score SD
ros$r <- sdd_to_r(ros$sd_pre, ros$sd_post, ros$sd_d)

# weighted mean of correlations
weighted.mean(ros$r, ros$n, na.rm = TRUE)
#> 0.82
# median
median(ros$r, na.rm = TRUE)
#> 0.88

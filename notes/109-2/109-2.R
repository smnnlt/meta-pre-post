# Recalculation of MA #109-2 (Rosenblat) 

library(metapp)

# Study to recalculate: Kirchenberger et al. 2021
# target ES: 0.71 [-0.28, 1.71]

# using POST data for VO2peak from results section
mean_int <- 62.1
sd_int <- 3.9
mean_con <- 58.3
sd_con <- 6.4

# using sample sizes from Tab1
n_int <- 10
n_con <- 7

# matches data from MA Tab 2

# calculate SMD
smd(mean_int, mean_con, sd_int, sd_con, n_int, n_con) |> get_ci()
# perfect match!
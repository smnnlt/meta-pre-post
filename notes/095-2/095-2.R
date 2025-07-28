# Recalculation of MA #095-2 (Lima) 

library(metapp)

# Study to recalculate: Hopper et al. 2017 (SL, DVJ)
# target ES: 2.1 [-4.7, 8.9]

# using data from Tab 3 (Hip Flexion, initial contact)
mean_int <- 46.2
sd_int <- 2.7
mean_con <- 44.1
sd_con <- 10.7

# NOTE that post scores were used although change score (and SD) are given
# in the table

# using sample sizes from Fig 1
n_int <- 13
n_con <- 10

# calculate MD
md(mean_int, mean_con, sd_int, sd_con, n_int, n_con) |> get_ci()
# perfect match!
# Recalculation of MA #145 (Plinsinga)

library(metapp)

# Study to recalculate: Adams et al. 2018
# target ES: -0.04 [-0.54, 0.46]

# using POST data from Tab 3 Bodily Pain

mean_con <- 52.8
sd_con <- 7.9
mean_int <- 52.5
sd_int <- 7.3

n_con <- 27 # the MA uses the slightly incorrect n=28 here
n_int <- 35

smd(mean_int, mean_con, sd_int, sd_con, n_int, n_con, vartype = 3) |> get_ci()
# perfect match
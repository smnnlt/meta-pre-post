# Recalculation of MA #122 (Toohey)

library(metapp)

# Study to recalculate: Persoon et al 2017
# target ES: 0.28 [-0.10, 0.65]

# using POST data from Tab 2 VO2peak

mean_int <- 26.0
sd_int <- 6.3
mean_con <- 24.2
sd_con <- 6.6

n_int <- 50
n_con <- 47

# smd of post scores
smd(mean_int, mean_con, sd_int, sd_con, n_int, n_con) |> get_ci()
# perfect match for ES, near match for CI

# using baseline sample size 
smd(mean_int, mean_con, sd_int, sd_con, 54, 55) |> get_ci()
# perfect match
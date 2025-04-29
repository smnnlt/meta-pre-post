# Recalculation of MA #026 (Poon)

library(metapp)

# Study to recalculate: Mora Rodriguez et al. 2018
# target ES: -7.1 [-11.68; -2.52]

# the forest plot shows detailed mean and sd for the groups
# as per text these are the post-intervention values
# extracting data from Mora Rodriguez Tab 1 first row matches these values
n_int <- 138
n_con <- 22

mean_int <- 102.5
sd_int <- 10.7

mean_con <- 109.6
sd_con <- 10.1

# mean difference as per text
metapp::md(mean_int, mean_con, sd_int, sd_con, n_int, n_con) |> get_ci()

# perfect match!

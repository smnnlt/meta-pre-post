# Recalculation of MA #145 (Nugent)

library(metapp)

# Study to recalculate: Gallagher et al. 2010
# target ES: 2.58 [1.05, 4.10]

# using data from Tab 5

n_con <- 5
n_int <- 6

mean_con <- 418.3
mean_int <- 386.2

# calculating SD from SE
sd_con <- 5.4 * sqrt(n_con)
sd_int <- 4.4 * sqrt(n_int)

smd(mean_con, mean_int, sd_con, sd_int, n_con, n_int) |> get_ci()
# perfect match for ES point estimate, CI a bit off

smd(mean_con, mean_int, sd_con, sd_int, n_con, n_int, vartype = 2) |> get_ci()
# using vartype = 2 gives almost perfect match (upper CI off by 0.01)

# but note the large differences in pre score for the time trial (despite 
# randomization)
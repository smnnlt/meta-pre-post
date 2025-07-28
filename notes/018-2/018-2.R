# Recalculation of MA #018-2 (Radaelli) 

library(metapp)

# Study to recalculate: Saeterbakken et al. 2018
# target ES: 0.37 [-0.46, 1.20]

# using data from Tab 2 (Maximal walking speed)
mean_int_pre <- 3.5
se_int_pre <- 0.3
mean_int_post <- 3.8
se_int_post <- 0.4

mean_con_pre <- 4.5
se_con_pre <- 0.4
mean_con_post <- 4.3
se_con_post <- 0.4

# using sample size from Fig 1
n_int <- 11
n_con <- 12

# calculate SD
sd_int_pre <- se_int_pre * sqrt(n_int)
sd_int_post <- se_int_post * sqrt(n_int)
sd_con_pre <- se_con_pre * sqrt(n_con)
sd_con_post <- se_con_post * sqrt(n_con)

# calculate change scores
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.5)
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.5)
# matches data presented in MA Tab S1

# calculate SMD
smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con) |> get_ci()
# almost perfect (lower CI bound 0.01 off)

# using RevMan variance estimator
smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con, vartype = 3) |> get_ci()
# perfect match

# Recalculation of MA #056-2 (Tomschi) 

library(metapp)

# Study to recalculate: Niwa et al. 2022 (30% HRR, local)
# target ES: 3.80 [-0.43, 8.03]

# convert from kPa to N/cm²: factor 1/10

# using data from the Results section (Pressure Pain Threshold, quadriceps, 
# low intensity)

# the data does not match the data presented in MA Fig 2 (forest plot)

# use next study instead: Pessoa 2021
# target ES: -1.00 [-9.21, 7.21]

# using data from Tab 5 (TB, AE vs PLACEBO)
# data is given in kg/cm², needs to be transformed to N/cm² with factor 9.8
mean_int_pre <- 6.5 * 9.8
sd_int_pre <- 1.0 * 9.8
mean_int_post <- 6.5 * 9.8
sd_int_post <- 1.7 * 9.8
n_int <- 16

mean_con_pre <- 9.9 * 9.8
sd_con_pre <- 2.6 * 9.8
mean_con_post <- 10.0 * 9.8
sd_con_post <- 2.4 * 9.8
n_con <- 16

mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.85)
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.85)
# matches values from MA Fig 2

# calculate MD
md(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con) |> get_ci()
# very near

# using rounded values (as given in MA Tab 2)
md(round(mean_int_d,1), round(mean_con_d,1), round(sd_int_d,1), round(sd_con_d,1), n_int, n_con) |> get_ci()
# perfect match

# Recalculation of MA #163 (Hughes)

library(metapp)

# Study to recalculate: Nonnato et al. 2022
# target ES: -1.15 [-2.24, -0.07]

# using data from Tab 2 (Sprint 10 m)

mean_int_pre <- 2.07
sd_int_pre <- 0.09
mean_int_post <- 1.89
sd_int_post <- 0.09

mean_con_pre <- 1.96
sd_con_pre <- 0.09
mean_con_post <- 1.90
sd_con_post <- 0.12

# calculate change scores and change score sd as pooled sd
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre

sd_int_d <- sd_avg(sd_int_pre, sd_int_post)
sd_con_d <- sd_avg(sd_con_pre, sd_con_post)
# values match the ones from the forest plot

# sample size from Fig 1
n_int <- 8
n_con <- 8

# calculate SMD using RevMan variance estimator
smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con, vartype = 3) |> get_ci()
# perfect match

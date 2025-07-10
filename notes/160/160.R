# Recalculation of MA #160 (Ramirez‑Campillo)

library(metapp)

# Study to recalculate: Young et al. 1999 (Height)
# target ES: 0.23 [-0.81, 1.27]

# using data from Tab 2 (DJ-H/t)

mean_con_pre <- 210
mean_con_post <- 201
sd_con_post <- 65

# INT group: DJ-H
mean_int_pre <- 180
mean_int_post <- 182
sd_int_post <- 37

# calculate change scores
mean_con_d <- mean_con_post - mean_con_pre
mean_int_d <- mean_int_post - mean_int_pre

# SMD of change scores standardized by post SD
smd(mean_int_d, mean_con_d, sd_int_post, sd_con_post, 11, 9) |> get_ci()
# ES point estimate nearby, CI is off

# try post scores only
smd(mean_int_post, mean_con_post, sd_int_post, sd_con_post, 11, 9)

# try next ES from the same study (other group)
# target ES: 0.72 [-0.47, 1.92]
smd(234-203, mean_con_d, 32, sd_con_post, 5, 9) |> get_ci()
# near, but no match

# try another study: Witassek et al. 2018
# target ES: 0.37 [-0.47, 1.20]

# using data from Tab 1 (RSI)
w_mean_int_pre <- 0.9
w_mean_int_post <- 1.01
w_sd_int_post <- 0.23

w_mean_con_pre <- 0.74
w_mean_con_post <- 0.75
w_sd_con_post <- 0.3

# calculate change scores
w_mean_int_d <- w_mean_int_post - w_mean_int_pre
w_mean_con_d <- w_mean_con_post - w_mean_con_pre

smd(w_mean_int_d, w_mean_con_d, w_sd_int_post, w_sd_con_post, 12, 10) |> get_ci()
# almost perfect match, just off by 0.01 for each number

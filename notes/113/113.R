# Recalculation of MA #113 (Hamad)

library(metapp)

# Study to recalculate: Sinclair et al. 2021
# target ES: -0.25 [-1.02, 0.52]

# using data from Tab 4 (20 m sprint)
mean_con_pre <- 3.03
sd_con_pre <- 0.12
mean_con_post <- 2.99
sd_con_post <- 0.11

mean_int_pre <- 3.01
sd_int_pre <- 0.10
mean_int_post <- 2.94
sd_int_post <- 0.11

# looking at the forest plot MA Fig 3 it seems like the ES were calculated based
# on change scores and pooled within group SDs
mean_con_d <- mean_con_post - mean_con_pre
mean_int_d <- mean_int_post - mean_int_pre
sd_con_d <- sd_avg(sd_con_pre, sd_con_post)
sd_int_d <- sd_avg(sd_int_pre, sd_int_post)

# calculate SMD
smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, 13, 13) |> get_ci()
# not exact

# use rounded SDs
smd(mean_int_d, mean_con_d, round(sd_int_d, 2), round(sd_con_d, 2), 13, 13) |> get_ci()
# perfect match!

# use the next study to verify that actually pooled SDs were used (because SD
# were quite similar between pre and post in the previous study)

# Spinks et al. 2007
# target ES: -0.29 [-1.17, 0.59]

# using data from Tab 2 0-15 m Resisted (INT) and Unresisted (CON)
# I just try to reproduce the values from the MA forest plot
s_mean_int_pre <- 5.25
s_mean_int_post <- 5.66
s_sd_int_pre <- 0.26
s_sd_int_post <- 0.32

s_mean_con_pre <- 5.13
s_mean_con_post <- 5.45
s_sd_con_pre <- 0.33
s_sd_con_post <- 0.29

# revert signs for effect because better performance means faster velocity
s_mean_int_d <- -(s_mean_int_post - s_mean_int_pre)
s_mean_con_d <- -(s_mean_con_post - s_mean_con_pre)
s_sd_int_d <- sd_avg(s_sd_int_pre, s_sd_int_post)
s_sd_con_d <- sd_avg(s_sd_con_pre, s_sd_con_post)
# matches data from forest plot

smd(s_mean_int_d, s_mean_con_d, s_sd_int_d, s_sd_con_d, 10, 10) |> get_ci()
# perfect match


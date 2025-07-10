# Recalculation of MA #170 (Heissel)

library(metapp)

# Study to recalculate: Sims et al. 2006
# target ES: -0.040 [-0.739, 0.658]

# using baseline data from Tab 1 (GDS):
mean_int_pre <- 12.64
sd_int_pre <- 3.61
mean_con_pre <- 12.22
sd_con_pre <- 3.51

# using post (10 wk) data from Tab 2 (GDS):
mean_int_post <- 12.23
sd_int_post <- 5.22
mean_con_post <- 12.00
sd_con_post <- 4.26
# matches data from MA Tab S1

# based on the ITT analysis, use baseline sample sizes from Fig 1:
n_con <- 18
n_int <- 14
# matches data from MA Fig 2 and Tab S1

# calculate mean changes
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre

# calculate Morris ppc
ppc(mean_int_d, mean_con_d, sd_int_pre, sd_con_pre, n_int, n_con, r = 0.7) |> get_ci()
# ES point estimate off by 0.01, CI is off

ppc(mean_int_d, mean_con_d, sd_int_pre, sd_con_pre, n_int, n_con, r = 0.7, type = 1) |> get_ci()
# ES point estimate off by 0.01, CI is off

ppc(mean_int_d, mean_con_d, sd_int_pre, sd_con_pre, n_int, n_con, r = 0.5) |> get_ci()
# when I use r = 0.5 I get very near to the CI

# I have tried this later as the result of the next ES tried:
smd(mean_int_d, mean_con_d, sd_int_post, sd_con_post, n_int, n_con, hedges = FALSE) |> get_ci()
# perfect match!

# try next study: Sims et al. 2009
# target ES: 0.231 [-0.370, 0.833]

# using baseline data from Tab 2 (CES-D):
s2_mean_int_pre <- 15.43
s2_sd_int_pre <- 7.49
s2_mean_con_pre <- 23.27
s2_sd_con_pre <- 8.86

# using post (10 wk) data from Tab 4 (CES-D):
s2_mean_int_post <- 15.13
s2_sd_int_post <- 8.49
s2_mean_con_post <- 20.62
s2_sd_con_post <- 11.79
# matches data from MA Tab S1

# using sample size data from Fig 1:
s2_n_int <- 23
s2_n_con <- 22
# matches data from MA Fig 2 and Tab S1

# calculate mean changes
s2_mean_int_d <- s2_mean_int_post - s2_mean_int_pre
s2_mean_con_d <- s2_mean_con_post - s2_mean_con_pre

# calculate Morris ppc
ppc(s2_mean_int_d, s2_mean_con_d, s2_sd_int_pre, s2_sd_con_pre, s2_n_int, s2_n_con, r = 0.7) |> get_ci()
# ES off

# try standard SMD of change scores and their sd
smd(s2_mean_int_d, s2_mean_con_d, r_to_sdd(s2_sd_int_pre, s2_sd_int_post, 0.7), r_to_sdd(s2_sd_con_pre, s2_sd_con_post, 0.7), s2_n_int, s2_n_con) |> get_ci()
# off

# I have tried this later as the result of the next ES tried:
smd(s2_mean_int_d, s2_mean_con_d, s2_sd_int_post, s2_sd_con_post, s2_n_int, s2_n_con, hedges = FALSE) |> get_ci()
# quite near, but not perfect

# last try, next study: Singh et al. 1997
# target ES: -3.462 [-4.558, -2.366]

# using data from Tab 4 HRSD
s3_n_int <- 17
s3_mean_int_pre <- 12.3
s3_mean_int_post <- 5.3
s3_sd_int_pre <- 0.9
s3_sd_int_post <- 1.3

s3_n_con <- 15
s3_mean_con_pre <- 11.4
s3_mean_con_post <- 8.9
s3_sd_con_pre <- 1.0
s3_sd_con_post <- 1.3
# matches data from MA Tab S1

# calculate mean changes
# calculate mean changes
s3_mean_int_d <- s3_mean_int_post - s3_mean_int_pre
s3_mean_con_d <- s3_mean_con_post - s3_mean_con_pre

# ppc type 2
ppc(s3_mean_int_d, s3_mean_con_d, s3_sd_int_pre, s3_sd_con_pre, s3_n_int, s3_n_con, r = 0.7) |> get_ci()
# far off

#ppc type 1
ppc(s3_mean_int_d, s3_mean_con_d, s3_sd_int_pre, s3_sd_con_pre, s3_n_int, s3_n_con, r = 0.7, type = 1) |> get_ci()
# far off

# try SMD of change scores
smd(s3_mean_int_d, s3_mean_con_d, r_to_sdd(s3_sd_int_pre, s3_sd_int_post, 0.7), r_to_sdd(s3_sd_con_pre, s3_sd_con_post, 0.7), s3_n_int, s3_n_con) |> get_ci()
# nope

# try ppc standardized by post scores
ppc(s3_mean_int_d, s3_mean_con_d, s3_sd_int_post, s3_sd_con_post, s3_n_int, s3_n_con, r = 0.7, type = 2) |> get_ci()

# SMD without Hedges' correction standardized by post scores
smd(s3_mean_int_d, s3_mean_con_d, s3_sd_int_post, s3_sd_con_post, s3_n_int, s3_n_con, s3_n_int, hedges = FALSE) |> get_ci()
# perfect match!

# so I'll try this now for the other studies
# worked for 2/3 (minor deviations for the third)
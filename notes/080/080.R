# Recalculation of MA #080 (Fong Yan)

library(metapp)

# Study to recalculate: Rawson et al. 2019
# target ES: -1.00 [-1.80, 0.20]

# it seems like data extracted from a plot was used, although Table S1
# from the supplemental file of the original article has the means and sd
# just reproducing the ES given the data from the forest plot:
md(0.4, 1.4, 1.2, 2.02, 39, 31) |> get_ci()
# matches

# using data for PDQ-39 from Tab S1: (using r = 0.5)
md(18.33-18.80, 19.22-17.86, r_to_sdd(1.89, 1.85, 0.5), r_to_sdd(2.71, 2.41, 0.5), 39, 31) |> get_ci()
# I used reverted signs because lower values mean improvement 
# the means almost match, but
# also CON and INT should have different signs
# the result is a fairly different ES and CI than the original

# use the previous study from the forest plot instead: Poier et al. 2019
# target ES: 9.91 [2.58, 17.24]
# using PDQ-39 subscale Emotional well-being (Tab 2)
mean_int_pre <- 28.86
sd_int_pre <- 17.02
mean_int_post <- 20.83
sd_int_post <- 13.81

mean_con_pre <- 33.88
sd_con_pre <- 17.59
mean_con_post <- 35.76
sd_con_post <- 19.42

# use reverted signs because improve means descrease
mean_int_d <- -(mean_int_post - mean_int_pre)
mean_con_d <- -(mean_con_post - mean_con_pre)
# matches data from forest plot

r_to_sdd(sd_int_pre, sd_int_post, 0.99)
r_to_sdd(sd_con_pre, sd_con_post, 0.7)
# I do not see where the change score SD reported in the forest plot comes from
# the values are small, so only consistent with rather large correlation, but
# also not the same correlation for both

# try the first study of the forest plot: Volpe et al. 2013
# target ES: 3.47 [-0.14, 7.08]

# using PDQ39 data from Tab2
v_mean_int_d <- 30.60 - 22.16
v_mean_con_d <- 32.58 - 27.61
# change score means match the forest plot

r_to_sdd(12.06, 10.18, 0.948)
r_to_sdd(7.59, 7.67, 0.79)
# change score sds do not match
# for example CON has lower pre and post sds, but a higher change score sd in
# the forest plot, which cannot be if imputation with the same parameters is 
# used


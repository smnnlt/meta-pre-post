# Recalculation of MA #052 (Loturco)

library(metapp)

# Study to recalculate: Yoshimoto et al. 2016 (bounding)
# target ES: -0.19 [-1.07, 0.69]

# taking the data from Tab. 1 (60 m sprint time)

# okay this is a bit ridiculous, the MA compares every group with each other,
# treating every group as CON and as INT once.
# In this case, bounding appears to be the CON and mini-hurdles to be the INT

mean_con_pre <- 7.83
sd_con_pre <- 0.30
mean_con_post <- 7.80
sd_con_post <- 0.27

mean_int_pre <- 7.90
sd_int_pre <- 0.35
mean_int_post <- 7.79
sd_int_post <- 0.35

# the MA uses reverted signs for calculating differences, because less time
# means improved performance

mean_con_d <- mean_con_pre - mean_con_post
mean_int_d <- mean_int_pre - mean_int_post
# match
r_to_sdd(sd_con_pre, sd_con_post, r = 0.2)
r_to_sdd(sd_int_pre, sd_int_post, r = 0.25)
# no match for sd of change scores

# taking the means and sds used in the forest plot for calculating the ES:
smd(mean_con_d, mean_int_d, 0.36, 0.43, 10, 10, vartype = 3) |> get_ci()
# perfect match

# To determine the imputation procedure, 
# I'll try the next study: Zimmermann et al. 2021

# CON and INT seems to be incorrectly assigned here
con_change <- 4.046 - 3.937
int_change <- 3.991 - 4.026 # also incorrect rounding
# matches means

r_to_sdd(0.26, 0.23, 0.2) # con change sd
r_to_sdd(0.23, 0.23, 0.25) # int change sd

# hm, maybe separate r imputation per group, but this does not match the
# observation that when the same group is assigned to either CON or INT in the 
# MA, they keep the sd

# so there is some other procedure for changes score sd determining used here,
# but I cannot determine which

# try next: Zisi et al. 2022
# using data from Tab 1 (INT) and Tab 2 (CON), 25-30m, Velocity (s)
z_mean_int_pre <- 8.37
z_sd_int_pre <- 0.87
z_mean_int_post <- 8.46
z_sd_int_post <- 0.92

z_mean_con_pre <- 8.42
z_sd_con_pre <- 0.83
z_mean_con_post <- 8.39
z_sd_con_post <- 0.84

# calculate mean changes
z_mean_int_d <- z_mean_int_post - z_mean_int_pre
z_mean_con_d <- z_mean_con_post - z_mean_con_pre
# matches, but CON and INT are wrongly assigned It might be that just the labels
# Control and Experimental are incorrect in this forest plot, this would explain
# why both studies have this issue. Also this remains unnoticed for most studies
# as they happen to have the exact same comparison multiple times in the
# analysis with switched labels

r_to_sdd(z_sd_int_pre, z_sd_int_post, 0.25) # near
r_to_sdd(z_sd_con_pre, z_sd_con_post, 0.25) # match

# next try: Bomfim-Lima et al. 2011
# using data from Tab 1: Pre-test, Post-15min
r_to_sdd(0.0331, 0.0355, 0.25) # CON (NOTE: using SEM!)
# match
r_to_sdd(0.0733, 0.0753, 0.25) # INT (NOTE: using SEM!)
# match

# so a correlation imputation of r = 0.25 is likely

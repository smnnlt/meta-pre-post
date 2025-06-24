# Recalculation of MA #052 (Loturco)

library(metapp)

# Study to recalculate: Yoshimoto et al. 2016 (bounding)
# target ES: -0.19 [-1.07, 0.69]

# taking the data from Tab. 1 (60 m sprint time)

# okay this is a bit ridicolous, the MA compares every group with each other,
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

# hm, maybe seperate r imputation per group, but this does not match the
# observation that when the same group is assigned to either CON or INT in the 
# MA, they keep the sd

# so there is some other procedure for changes score sd determining used here,
# but I cannot determine which

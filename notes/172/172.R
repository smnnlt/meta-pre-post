# Recalculation of MA #172 (Arntz)

library(metapp)

# Study to recalculate: Abdel-Aziem & Mohammad 2012
# target ES: 0.609 [var: 0.057] (plantar flexor eccentric peak torque 30°, group 1)
# I have taken this from rerunning the provided analysis script

# using data from Tab 1 (Plantar-flexor eccentric torque 30°/sec, Control vs. untrained)
mean_con_pre <- 80.16
mean_con_post <- 81.04
sd_con_pre <- 13.61
sd_con_post <- 13.84

mean_int_pre <- 81.08
mean_int_post <- 90.79
sd_int_pre <- 12.98
sd_int_post <- 14.03
# matches data provided by the MA authors

# using sample sizes from methods section (equal allocation of N = 75 participants)
n_con <- 25
n_int <- 25

# calculating mean change
mean_con_d <- mean_con_post - mean_con_pre
mean_int_d <- mean_int_post - mean_int_pre

# calculate SMD using ppc1 with added variances (= Becker variance estimator)
# assuming r = 0.7 as stated in the authors data/code
ppc(mean_int_d, mean_con_d, sd_int_pre, sd_con_pre, n_int, n_con, r1 = 0.7, r2 = 0.7, type = 1, var_becker = TRUE)
# no match (though var is quite near)

# using post scores instead of pre scores:
ppc(mean_int_d, mean_con_d, sd_int_post, sd_con_post, n_int, n_con, r1 = 0.7, r2 = 0.7, type = 1, var_becker = TRUE)
# perfect match!
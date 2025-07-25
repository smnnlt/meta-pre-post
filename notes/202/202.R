# Recalculation of MA #202 (Markov)

library(metapp)

# Study to recalculate: Campos et al. 2013
# target ES: 0.46 [-1.49, 2.41]

# I used the MA Tab 3 do determine the group and parameter used from the study.
# but it from the published data file it is not really clear which group was 
# used

# using data from Tab 4 (Lower limbs, AS vs CG // SA vs CG)
mean_int_pre <- 66.0
sd_int_pre <- 19.49
mean_int_post <- 74.6
sd_int_post <- 33.5
# mean_int_pre <- 61.0
# sd_int_pre <- 29.7
# mean_int_post <- 63.6
# sd_int_post <- 17.4

mean_con_pre <- 49.3
sd_con_pre <- 9.0
mean_con_post <- 47.0
sd_con_post <- 13.9

# using sample size from Abstract
n_int <- 5
n_con <- 3
# as per MA methods, correct sample size for multiple use of the same control 
# group. Here, the control group is used for two comparisons
n_con_eff <- n_con / 2

# all data matches MA Tab 3

mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre

smd(mean_int_d, mean_con_d, sd_int_post, sd_con_post, n_int, n_con_eff) |> get_ci()
# I tried different combinations, no match!

# try next ES from a different study: Figueroa et al. 2011
# target ES: 2.71 [1.55, 3.87] [ES: 2.710228985, SE: 0.591397449]

# using data from Tab 1 (dynamic strength)
f_n_con <- 12
f_n_int <- 12

f_mean_con_pre <- 38.3
f_se_con_pre <- 1.5
f_mean_con_post <- 38.8
f_se_con_post <- 1.5

f_mean_int_pre <- 38.3
f_se_int_pre <- 1.1
f_mean_int_post <- 43.3
f_se_int_post <- 1.7

# matches data from MA Tab S3, BUT: data is given as SE not SD!

f_mean_int_d <- f_mean_int_post - f_mean_int_pre
f_mean_con_d <- f_mean_con_post - f_mean_con_pre

# incorrectly using SE for calculations
# use post score SD for standardization & vartype = 3 (both determined by 
# try-and-error)
# also exact=FALSE because the authors stated to have used the approximation 
# formula for the hedges correction
f <- smd(f_mean_int_d, f_mean_con_d, f_se_int_post, f_se_con_post, f_n_int, f_n_con, exact = FALSE, vartype = 3) |> get_ci()
sqrt(f$var)
# perfect match for SE
f
# perfect match! (but SE/SD mixed up)

# try another one to verify: Haykowsky et al. 2005
# target ES: 2.79 [1.69, 3.90]

# using data from Tab 3 (Leg-press 1 RM)

# using n as in the MA data (could not determine n from the original study)
smd(263.6-169.1, 203.8-200.5, 89.0, 43.2, 7, 7)
# but there is a data extraction error for the mean con pre (off by factor 10)
# ignoring the data extraction error
smd(263.6-169.1, 203.8-20.5, 89.0, 43.2, 7, 7)

# at this point this is just random trying
smd(263.6+169.1, 203.8+20.5, 89.0, 43.2, 7, 7, exact = FALSE, vartype = 3) |> get_ci()
# ES matches (but not perfectly the one provided in the published data), CI not

# try to back-calculate mean difference for the SMD determination
(2.792437597 / j(12, FALSE)) * sd_avg(89.0, 43.2)

# okay, I have absolutely no idea what is going on here

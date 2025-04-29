# Recalculation of MA #047 (Lazić)

library(metapp)

# Study to recalculate: Boff et al. 2019
# target ES: 2.28 [1.03, 3.53]

n_int <- 9
n_con <- 9

# data from Tab 3 (directly shows deltas)
mean_int_d <- 6.08
sd_int_d <- 2.58
mean_con_d <- -0.34
sd_con_d <- 2.78

metapp::smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con, vartype = 2) |> get_ci(df = n_int + n_con - 2)
# perfect match!

# I had to try a bit around and also was in contact with the creator of the 
# MedCalc software. In the end I found out by myself that MedCald uses 
# vartype = 2 and a t-distribution based confidence interval (both not documented)
# 
# try another ES just to make sure.
# next one: Lee et al. 2020
# target ES: 0.22 [-0.55, 0.99]

# data from Tab 2
# again mean and sd of deltas are presented, so not possible to get imputation 
# method
smd(-0.9, -2.1, 5.5, 5, 12, 15, vartype = 2) |> get_ci(df = 12 + 15 - 2)
# perfect match

# Last try to find an imputation method: previous study from the forest plot:
# Alarcon-Gomez 2021
# target ES: 0.46 [-0.49, 1.40]

# taking data from Tab 1 (Vo2max)
# I try out different imputation values for r
ac_int_mean_d <- 40.4-37.1
ac_int_sd_d <- r_to_sdd(4.1, 3.8, 0)
ac_con_mean_d <- 37.2 - 37.0
ac_con_sd_d <- r_to_sdd(5.5, 5.1, 0)
ac_int_n <- 11
ac_con_n <- 8

smd(ac_int_mean_d, ac_con_mean_d, ac_int_sd_d, ac_con_sd_d, ac_int_n, ac_con_n, vartype = 2) |> get_ci(df = ac_int_n + ac_con_n - 2)
# perfect match!

# so r = 0 is imputed for the correlation 
# (or in other words, sd_d is the square root of the sum of squared sd_pre and sd_post)

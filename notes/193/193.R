# Recalculation of MA #193 (Refalo)

library(metapp)

# Study to recalculate: Terada et al. 2022 (tb)
# target ES: 0.61 [-0.37, 1.58]

# using data from the abstract (LVoF as INT, LVeF as CON)
n_int <- 9
n_con <- 8

# using data from Tab 3 (triceps brachii, LVoF vs. LVeF)
mean_int_pre <- 29.2
sd_int_pre <- 5.0
mean_int_post <- 34.1
sd_int_post <- 3.5

mean_con_pre <- 29.7
sd_con_pre <- 5.7
mean_con_post <- 32.1
sd_con_post <- 6.8

# calculate mean change and change score sd using r = 0.75
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre

sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.75)
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.75)
# matches data from forest plot, except for sd_con_d, which is 4.54 here instead
# of the reported 4.50 
# this is a minor data extraction error, as verified by the uploaded raw data
# which shows a value of 5 for sd_con_pre:
sd_con_d_err <- r_to_sdd(5.0, sd_con_post, 0.75)
sd_con_d_err
# match

# also interesting that the change score SD was calculated with imputed 
# correlation, although the original study provides change score SDs in Tab 3

# calculate SMD with the correct values
smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con) |> get_ci()
# perfect match for CI, almost perfect for ES point estimate (off by 0.01)

# when taking the data extraction error into account
smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d_err, n_int, n_con) |> get_ci()
# perfect match


# Recalculation of MA #179 (Alizadeh)

library(metapp)

# Study to recalculate: Barbosa et al. 2002
# target ES: -0.746 (z-value: -1.553)

# using data from Tab 2:
n_int <- 11
n_con <- 8

mean_int_pre <- 30.4
mean_int_post <- 34.4
sd_int_pre <- 6.0
sd_int_post <- 6.6

mean_con_pre <- 33.8
mean_con_post <- 33.1
sd_con_pre <- 6.6
sd_con_post <- 5.9

# calculate change scores
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre

sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.5)
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.5)

# SMD using change scores 
smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con)
# quite near with the point estimate

# without Hedges' correction
o <- smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con, hedges = FALSE)
o
# perfect match for point estimate (when sign reverted, because the MA uses
# negative values for better INT)

# now try to reproduce the z-value (point estimate / SE)
o$es / sqrt(o$var)
# perfect match for the z-value (and thus the confidence interval)

# for visual confirmation, this would be the CI:
o |> get_ci()

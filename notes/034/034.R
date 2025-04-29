# Recalculation for MA #034 (Thapa)

library(metapp)

# Study to recalculate: Liu et al. (2022)
# target ES: 0.063 [-0.633; 0.760]

# taking the BS 1RM data from Tab 1:
mean_int_pre <- 100.67
mean_int_post <- 110.67
sd_int_post <- 7.99

mean_con_pre <- 100.33
mean_con_post <- 109.67
sd_con_post <- 11.87

n_int <- 15
n_con <- 15

# calculate change scores
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre

# smd of change scores with post sd standardization
metapp::smd(mean_int_d, mean_con_d, sd_int_post, sd_con_post, n_int, n_con) |> get_ci()
# ES matches, CI not

# using different variance estimator
metapp::smd(mean_int_d, mean_con_d, sd_int_post, sd_con_post, n_int, n_con, vartype = 2) |> get_ci()
# perfect match!
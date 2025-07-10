# Recalculation of MA #139 (Ren)

library(metapp)

# Study to recalculate: Lavretsky et al. 2022 (COVAT)
# target ES: 0.050 [-0.301, 0.401]

# using change score data from Tab 2 for Language
# 3-months
smd(0.03, -0.12, 0.40, 0.46, 59, 57)
# 6-months
smd(0.04, -0.12, 0.42, 0.46, 59, 57)


# try next study: Hoffmann et al. 2008 (COWAT, AE vs Placebo pill)
# target ES: 0.059 [-0.283, 0.395]

# using data from Tab 4 COWAT
mean_int_pre <- 40.36
sd_int_pre <- 11.80
mean_int_post <- 41.86
sd_int_post <- 13.36

mean_con_pre <- 39.39
sd_con_pre <- 13.22
mean_con_post <- 41.12
sd_con_post <- 13.13

n_int <- 104
n_con <- 49

# calculate change scores and change score sd
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre

sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.5)
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.5)

smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con)
#  no match

# directly try post score based SMD
smd(mean_int_post, mean_con_post, sd_int_post, sd_con_post, n_int, n_con) |> get_ci()
# ES point estimate quite near, CI almost perfect match

# but this is difficult to further analyze for such a small effect. Use another
# larger ES of the same study instead: ANT (AE vs placebo pill)
# target ES: 0.357 [0.018, 0.696]
smd(20.10, 18.27, 5.38, 4.53, n_int, n_con) |> get_ci()
# again almost matching
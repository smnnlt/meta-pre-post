# Recalculation of MA #063 (Moralez)

library(metapp)

# Study to recalculate: Shen et al. 2020
# target ES: 0.88 [0.35, 1.41]

# use ANT scores (Tab 3)

mean_int_pre <- 15.07
sd_int_pre <- 7.182
mean_int_post <- 20.07
sd_int_post <- 3.676

mean_con_pre <- 15.77
sd_con_pre <- 5.817
mean_con_post <- 16.03
sd_con_post <- 6.049

mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre

# calculate change score sds with r = 0.630 as reported
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.63)
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.63)

# calculate SMD
smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, 30, 30) |> get_ci()
# not exactly

# without Hedges' correction
smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, 30, 30, hedges = FALSE) |> get_ci()
# perfect match!

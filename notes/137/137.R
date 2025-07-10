# Recalculation of MA #137 (Weakley)

library(metapp)

# Study to recalculate: Weakley et al. 2019
# target ES: 0.11 [-0.64, 0.86]

# using data from Tab 2 (Jump height)
mean_int_pre <- 40.2
sd_int_pre <- 8.1
mean_int_post <- 41.6
sd_int_post <- 8.4

mean_con_pre <- 41.5
sd_con_pre <- 5.1
mean_con_post <- 42
sd_con_post <- 8.3

# using text in the methods section:
n_int <- 16
n_con <- 12

# all data matches the data given in the forest plot

# calculate change scores and change score sd with imputed r = 0.5
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.5)
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.5)

# calculate SMD
smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con) |> get_ci()
# perfect match!
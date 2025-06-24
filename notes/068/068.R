# Recalculation of MA #068 (Cavalli)

library(metapp)

# Study to recalculate: Winding et al. 2018
# target ES: 0.00 [-0.75, 0.75]

# taking data from Tab 1 for total cholesterol (HIT vs CON)
n_con <- 7
n_int <- 13

mean_con_pre <- 4.0
sd_con_pre <- 0.7
mean_con_post <- 3.8
sd_con_post <- 0.6

mean_int_pre <- 4.7
sd_int_pre <- 1.1
mean_int_post <- 4.5
sd_int_post <- 1.0

mean_con_d <- mean_con_post - mean_con_pre
mean_int_d <- mean_int_post - mean_int_pre
# means match data from forest plot
# calculating change score sd with imputed correlation
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.5)
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.5)
# matches data from forest plot

# calculate MD
md(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con) |> get_ci()
# perfect match

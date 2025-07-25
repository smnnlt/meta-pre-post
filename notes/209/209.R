# Recalculation of MA #209 (Igarashi)

library(metapp)

# Study to recalculate: Zavanela et al. 2012
# target ES: -9.7 [-14.7, -4.7]

# using data from Tab 3 (SBP)
mean_con_pre <- 125.1
sd_con_pre <- 17.2
mean_con_post <- 128.2
sd_con_post <- 12.9

mean_int_pre <- 123.7
sd_int_pre <- 10.2
mean_int_post <- 117.1
sd_int_post <- 5.4

# using sample sizes from abstract
n_con <- 48
n_int <- 48

# calculate mean changes
mean_con_d <- mean_con_post - mean_con_pre
mean_int_d <- mean_int_post - mean_int_pre

# try different methods to determine the sd used
# pre sd 
md(mean_int_d, mean_con_d, sd_int_pre, sd_con_pre, n_int, n_con) |> get_ci()

# average sd
sd_con <- sd_avg(sd_con_pre, sd_con_post)
sd_int <- sd_avg(sd_int_pre, sd_int_post)
md(mean_int_d, mean_con_d, sd_int, sd_con, n_int, n_con) |> get_ci()

# change score sd
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.5)
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.5)
md(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con) |> get_ci()
# perfect match

# but need one further study to verify: Wood et al. 2001
# target ES: -1.2 [21.2, 18.8]

# sample sizes from MA Tab 1 match with the group comparison RT vs CON
# using sample size data from Wood Tab 1:
w_n_int <- 11
w_n_con <- 6

# using data from Tab 2 (Supine, SBP)
w_mean_int_pre <- 129.1
w_sd_int_pre <- 22.5
w_mean_int_post <- 124.1
w_sd_int_post <- 16.3

w_mean_con_pre <- 133.5
w_sd_con_pre <- 22.4
w_mean_con_post <- 129.7
w_sd_con_post <- 16.5

# calculate change scores and change score sd
w_mean_int_d <- w_mean_int_post - w_mean_int_pre
w_mean_con_d <- w_mean_con_post - w_mean_con_pre

w_sd_int_d <- r_to_sdd(w_sd_int_pre, w_sd_int_post, 0.5)
w_sd_con_d <- r_to_sdd(w_sd_con_pre, w_sd_con_post, 0.5)

md(w_mean_int_d, w_mean_con_d, w_sd_int_d, w_sd_con_d, w_n_int, w_n_con) |> get_ci()
# perfect match!

# Recalculation of MA #089 (Fernández-Landa)

library(metapp)

# Study to recalculate: Portal et al. 2011
# target ES: 0.30 [-0.30, 0.90]

# Using data for VO2max from Tab 4:
mean_con_pre <- 42.0
sd_con_pre <- 6.6
mean_con_post <- 43.2
sd_con_post <- 6.5

mean_int_pre <- 42.0
sd_int_pre <- 5.4
mean_int_post <- 44.7
sd_int_post <- 4.6

mean_con_d <- mean_con_post - mean_con_pre
mean_int_d <- mean_int_post - mean_int_pre
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.7)
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.7)

n_con <- 14 
n_int <- 14

# calculate SMD based on change scores
smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con) |> get_ci()
# ES slightly off, CI off

# maybe use post scores
smd(mean_int_post, mean_con_post, sd_int_post, sd_con_post, n_int, n_con) |> get_ci()
# also off

# maybe use Morris method
ppc(mean_int_d, mean_con_d, sd_int_pre, sd_int_post, n_int, n_con, r = 0.7) |> get_ci()
# quite near!!

# try next study: Robinson et al. 2014
# target ES: 0.02 [-0.61, 0.65]

rob_mean_con_pre <- 38.9
rob_sd_con_pre <- 3.4
rob_mean_con_post <- 40.3
rob_sd_con_post <- 2.6

rob_mean_int_pre <- 39.8
rob_sd_int_pre <- 6.7
rob_mean_int_post <- 42.7
rob_sd_int_post <- 5.1
# I don't know how this should lead to a SMD of 0.02

rob_mean_con_d <- rob_mean_con_post - rob_mean_con_pre
rob_mean_int_d <- rob_mean_int_post - rob_mean_int_pre
rob_sd_con_d <- r_to_sdd(rob_sd_con_pre, rob_sd_con_post, 0.7)
rob_sd_int_d <- r_to_sdd(rob_sd_int_pre, rob_sd_int_post, 0.7)
# smd based on change scores
smd(rob_mean_int_d, rob_mean_con_d, rob_sd_int_d, rob_sd_con_d, 13, 13) |> get_ci()  
# way off
ppc(rob_mean_int_d, rob_mean_con_d, rob_sd_int_pre, rob_sd_con_pre, 13, 13, r = 0.7) |> get_ci()
# also way off

# try next study: Vukovich & Dreifort 2001
# target ES: 1.56 [0.62, 2.50]
# this is a crossover trials, so this may impact the methods used for analysis
# use VO2peak data from Tab 3 HMB (INT) vs. CON
smd(0.15, -0.09, 0.15, 0.2, 8, 8) |> get_ci()
ppc(0.15, -0.09, 0.14, 0.16, 8, 8, r = 0.7) |> get_ci()
# near but not perfect

# try a last one: O’connor &, Crowe 2003
# could not retrieve full text

# previous: Lamboley et al. 2007
# target ES: 1.25 [-0.41, 2.92]
# using VO2max data from Tab 2
smd(58.34-50.63, 56.11-51.74, r_to_sdd(2.56, 2.73, 0.7), r_to_sdd(2.73, 3.10, 0.7), 8, 8)
ppc(58.34-50.63, 56.11-51.74, 2.56, 2.73, 8, 8, r = 0.7) |> get_ci()
# rather near for ES, but CI is off

# Recalculation of MA #101-2 (Oliver) 

library(metapp)

# Study to recalculate: Negra et al. 2020 (Plyo vs. Control)
# target ES: -0.19 [-1.00, 0.62]

# using data from Tab 2 (Half-squad, PTG vs CG, Baseline vs 12 weeks)
mean_int_pre <- 86.18
sd_int_pre <- 3.67 # notably small value here
mean_con_pre <- 83.82
sd_con_pre <- 18.34

mean_int_post <- 89.82
sd_int_post <- 24.14
mean_con_post <- 91.45
sd_con_post <- 15.39

# using sample sizes from Tab 1
n_int <- 11
n_con <- 11

# calculate change scores
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre

# calculate SMD
# with post score SD standardization and vartype=2
smd(mean_int_d, mean_con_d, sd_int_post, sd_con_post, n_int, n_con, vartype = 2) |> get_ci()
# perfect match!

# Recalculation of MA #129 (Hermes)

library(metapp)

# Study to recalculate: Palmieri 1986
# target ES: -0.22 [-0.86, 0.42]

# using data from Tab 2 1RM Squad
mean_con_pre <- 100.80
sd_con_pre <- 11.69
mean_con_post <- 125.80
sd_con_post <- 15.23

mean_int_pre <- 100.00
sd_int_pre <- 26.67
mean_int_post <- 120.30
sd_int_post <- 22.55

n_con <- 18
n_int <- 18
mean_con_d <- mean_con_post - mean_con_pre
mean_int_d <- mean_int_post - mean_int_pre

m <- ppc(mean_int_d, mean_con_d, sd_int_pre, sd_con_pre, n_int, n_con, 0.5, type = 2) |> get_ci()
m
# matches ES point estimate

# use different formula for var estimation
# use independent group SMD (Borenstein & Hedges formula)
v <- smd(mean_int_d, mean_con_d, sd_int_pre, sd_con_pre, n_int, n_con, vartype = 2)
# replace ppc var by B&H var
m$var <- v$var
m |> get_ci()
# perfect match!


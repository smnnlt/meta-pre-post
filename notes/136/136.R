# Recalculation of MA #136 (Currier)

library(metapp)

# Study to recalculate: Padilha et al. 2015
# target ES: 0.01 [-1.21, 1.23]

# using data from Tab 2 (Knee extension)

mean_g2_pre <- 41.3
sd_g2_pre <- 9.3
mean_g2_post <- 48.9
sd_g2_post <- 9.1

mean_g3_pre <- 46.1
sd_g3_pre <- 10.5
mean_g3_post <- 53.8
sd_g3_post <- 12.4

n_g2 <- 13
n_g3 <- 14

# calculate change scores and change score sd with imputed r = 0.5
mean_g2_d <- mean_g2_post - mean_g2_pre
mean_g3_d <- mean_g3_post - mean_g3_pre

sd_g2_d <- r_to_sdd(sd_g2_pre, sd_g2_post, 0.5)
sd_g3_d <- r_to_sdd(sd_g3_pre, sd_g3_post, 0.5)

# calculate SMD
o1 <- smd(mean_g3_d, mean_g2_d, sd_g3_d, sd_g2_d, n_g3, n_g2)
o1 |> get_ci()
# perfect match for ES point estimate, CI far off

# try next study: Pinto et al. 2014
# target ES: 1.06 [-0.11, 2.24]

# using data from Tab1

n_int <- 19
n_con <- 17

mean_int_pre <- 42.5
sd_int_pre <- 8.1
mean_int_post <- 51.9
sd_int_post <- 9.9

mean_con_pre <- 39.1
sd_con_pre <- 8.3
mean_con_post <- 38.8
sd_con_post <- 9.0

# calculate change scores and change score sd with imputed r = 0.5
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre

sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.5)
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.5)

# calculate SMD
o2 <- smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con, vartype = 3)
o2 |> get_ci()
# again, perfect match for ES point estimate, CI far off

# I have an idea: since the CI seem to be systematically too wide in the MA...
# ... what if the MA authors confused the var(ES) and the SE(ES) (I have seen
# this once before)

# this would mean we take the square root of the actual var as the input for the
# CI calculation
o2_newvar <- o2
o2_newvar$var <- sqrt(o2$var) 
o2_newvar |> get_ci()
# perfect match! (for vartype = 3, for vartype = 1, the upper CI is off by 0.01)

# just verify for the first ES above (Padilha)
o1_newvar <- o1
o1_newvar$var <- sqrt(o1$var)
o1_newvar |> get_ci()
# perfect match
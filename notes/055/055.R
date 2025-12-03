# Recalculation of MA #055 (Konrad)

library(metapp)

# EDIT AFTER AUTHOR CONTACT:
# The authors provided a data sheet with the effect sizes and underlying raw 
# data

# Study to recalculate: Sermaxhaj et al. 2021
# target ES: -0.295 [x.xx, x.xx]

# MA Tab 1 says that static sit-and-reach was the outcome
# Forest plot says that a combined measure was used
# since the study tested 3 age groups, maybe the combined effects for each 
# subgroup for the sit-and-reach measure were used

# maybe I'll try the next one first, because this could be challenging
# Aquino et al. 2010
# target ES: -0.258 []

# to me it is totally unclear which values should be used for the recalculation

# try next: Mayorga-Vega et al. (2014)
# target ES: -0.240 (SE: 0.299)

# using data from Tab 1
mean_con_pre <- 14.17
sd_con_pre <- 4.20
mean_con_post <- 14.57
sd_con_post <- 4.14
n_con <- 23

mean_int_pre <- 17.05
sd_int_pre <- 5.64
mean_int_post <- 18.64
sd_int_post <- 5.71
n_int <- 22
# matches provided data

# calculate change scores
mean_con_d <- mean_con_post - mean_con_pre
mean_int_d <- mean_int_post - mean_int_pre
# calculate change score SD using software default of r = 0.5
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.5)
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.5)

# calculate SMD
o <- smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con, hedges = FALSE)
o
sqrt(o$var)
# perfect match

# for verification:
# I use the next ES that does not use a "combined" measure as indicated in the
# forest plot. This is: Barbosa et al. (2018)
# target ES -0.182 [SE: 0.366]

# using data from Tab 2 (CON: Cg, INT: SSg, PRE: Pre-1st, POST: 48 h)
b_mean_con_pre <- 139.33
b_sd_con_pre <- 8.02
b_mean_con_post <- 139.36
b_sd_con_post <- 10.74

b_mean_int_pre <- 138.06
b_sd_int_pre <- 11.24
b_mean_int_post <- 140.18
b_sd_int_post <- 14.32

# using data from Tab 1
b_n_con <- 15
b_n_int <- 15
# matches provided data

# calculate change scores
b_mean_con_d <- b_mean_con_post - b_mean_con_pre
b_mean_int_d <- b_mean_int_post - b_mean_int_pre
# calculate change score SD using software default of r = 0.5
b_sd_con_d <- r_to_sdd(b_sd_con_pre, b_sd_con_post, 0.5)
b_sd_int_d <- r_to_sdd(b_sd_int_pre, b_sd_int_post, 0.5)

# calculate SMD
b_o <- smd(b_mean_int_d, b_mean_con_d, b_sd_int_d, b_sd_con_d, b_n_int, b_n_con, hedges = FALSE)
b_o
sqrt(b_o$var)
# perfect match

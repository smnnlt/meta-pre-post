# Recalculation of MA #079 (Chen)

library(metapp)

# Study to recalculate: Yilmaz Gokmen et al. 2019
# target ES: -12.92 [-37.61, 11.77]

# TST exercise vs control
mean_int_pre <- 345.84
sd_int_pre <- 49.66
mean_int_post <- 335.60
sd_int_post <- 40.10

mean_con_pre <- 358.72
sd_con_pre <- 47.10
mean_con_post <- 361.04
sd_con_post <- 38.41

mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre
# match for INT but off for CON
# this seems to be a data extraction error, because all other 
# variables could be recalculated

# calculating change score sd using r = 0.5 for imputation
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.5)
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.5)
# match for both 

# calculate MD using the incorrect value for CON mean
md(mean_int_d, 2.68, sd_int_d, sd_con_d, 25, 25) |> get_ci()
# perfect match!

# just look what happens when using the correct data
md(mean_int_d, mean_con_d, sd_int_d, sd_con_d, 25, 25) |> get_ci()
# not that much difference
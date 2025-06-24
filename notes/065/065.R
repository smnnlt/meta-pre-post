# Recalculation of MA #065 (Tan)

library(metapp)

# Study to recalculate: Yoon et al. 2018
# target ES: -0.60 [-1.49, 0.28] (extracted from forest plot)

# comparison: aerobic vs control for CRP (C-reactive protein)
# using the data from Tab 7
mean_int_pre <- 0.16
sd_int_pre <- 0.26
mean_int_post <- 0.05
sd_int_post <- 0.06

mean_con_pre <- 0.06
sd_con_pre <- 0.05
mean_con_post <- 0.06
sd_con_post <- 0.06

mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.5)
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.5)
smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, 10, 10) |> get_ci()
# almost match

# given the inaccuracy of the ES extraction procedure, this is probably as near 
# as we can get in a recalculation
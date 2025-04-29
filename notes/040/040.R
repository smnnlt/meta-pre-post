# Recalculation of MA #040 (Desai)

library(metapp)

# Study to recalculate: Spillane et al. 2009
# target ES: 1.00 [-0.87, 2.87]

# we take the values from Tab 3 FFM for CRT and PLA
# the CRT values match the ones from the forest plot

n_int <- 10
mean_int_pre <- 63.27
sd_int_pre <- 10.79
mean_int_post <- 65.12
sd_int_post <- 11.38
mean_int_d <- mean_int_post - mean_int_pre

# impute correlation of 0.975 to calculate change score sd

sd_int_d <- metapp::r_to_sdd(sd_int_pre, sd_int_post, 0.975)
# matches!

# the control group is more challenging. The values do not match here, also
# n = 5, but in the original study PLA has n = 10

# I took a look at the data sheet the MA authors provided and could figure out
# what is going on: Because Spillane has two intervention groups, the MA halved
# the control group to avoid double counting. But not only n was halved, but 
# also means and sd. (This seems a bit ridiculous and was also not mentioned in 
# the text).

# take 1/2 of the original values
n_con <- 10 * 0.5
mean_con_pre <- 54.55 * 0.5
sd_con_pre <- 10.05 * 0.5
mean_con_post <- 56.25 * 0.5
sd_con_post <- 10.22 * 0.5

mean_con_d <- mean_con_post - mean_con_pre
sd_con_d <- metapp::r_to_sdd(sd_con_pre, sd_con_post, 0.975)
# matches!

# no calculate the overall effect size
metapp::md(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con) |> get_ci()

# perfect match!

# so the ES could be reproduced, but only when the control group n, mean (!) and 
# sd (!) was multiplied by 1/2 (thought to be an adjustment for inclusion of 
# multiple treatment groups, but this should not be done like this).

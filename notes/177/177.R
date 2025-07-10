# Recalculation of MA #177 (Recchia)

library(metapp)

# Study to recalculate: Reichkendler et al. 2013 (High-Volume)
# target ES: -0.73 [-1.61, 0.15]

# using data from Tab 1 (Abdominal VAT mass)

mean_con_pre <- 2.0
sd_con_pre <- 0.6
mean_con_post <- 2.1
sd_con_post <- 0.6

mean_int_pre <- 2.0
sd_int_pre <- 0.7
mean_int_post <- 1.6
sd_int_post <- 0.4

# calculate mean changes
mean_con_d <- mean_con_post - mean_con_pre
mean_int_d <- mean_int_post - mean_int_pre
# matches forest plot mean changes

# use data from Fig2 (MR abdomen scans):
n_con <- 9
n_int <- 14

# use Morris ppc2 with an assumed correlation of 0.5
ppc(mean_int_d, mean_con_d, sd_int_pre, sd_con_pre, n_int, n_con, 0.5) |> get_ci()
# perfect match!
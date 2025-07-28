# Recalculation of MA #002-2 (Favro) 

library(metapp)

# Study to recalculate: Simao et al. 2011
# target ES: 2.88 [1.48, 4.28]

# using data from Tab 3 (flexibility, ST vs CON)
mean_int_pre <- 30
sd_int_pre <- 2.0
mean_int_post <- 36
sd_int_post <- 3.0

mean_con_pre <- 30
sd_con_pre <- 2.0
mean_con_post <- 30
sd_con_post <- 2.0

# using sample sizes from Tab 1
n_int <- 20
n_con <- 20

# calculate mean changes
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre

# using ppc1 by Morris
ppc(mean_int_d, mean_con_d, sd_int_pre, sd_con_pre, n_int, n_con, type = 1, r = 0.7)
# perfect match for point estimate, off for CI

# I took a look at the source code provided by the authors. They seem to have 
# used the Becker variance estimator (despite showing the Morris estimator
# in their MA)
ppc(mean_int_d, mean_con_d, sd_int_pre, sd_con_pre, n_int, n_con, type = 1, r1 = 0.7, r2 = 0.7, var_becker = TRUE) |> get_ci()
# perfect match for point estimate, off for CI

# Looking into the intermediate results of the script, it show the following:
# yi = 2.879731; vi = 0.2673213

# which perfectly matches the ppc1 var_becker=TRUE values

# it seem that the later effect size aggregation procedure of the 3-level MA
# changed the variance estimate on the study-level, even if the study had only
# one ES included
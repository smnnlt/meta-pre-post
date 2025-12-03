# Recalculation of MA #061 (Gómez-Redondo)

library(metapp)

# Study to recalculate: Opdenacker et al. 2011
# target ES: 0.28 [-0.08, 0.64]

# using the values for knee strength SUP vs. UNSUP (Tab 2)

mean_con_pre <- 70.5
sd_con_pre <- 2.9
mean_con_post <- 72.0
sd_con_post <- 3.0

mean_int_pre <- 69.5
sd_int_pre <- 2.9
mean_int_post <- 75.9
sd_int_post <- 3.0

# # could not reproduce, use static strength instead
# mean_con_pre <- 139.3
# sd_con_pre <- 5.7
# mean_con_post <- 146.9
# sd_con_post <- 6.1
# 
# mean_int_pre <- 138.3
# sd_int_pre <- 5.7
# mean_int_post <- 156.8
# sd_int_post <- 5.0

mean_con_d <- mean_con_post - mean_con_pre
mean_int_d <- mean_int_post - mean_int_pre

# calculate change score sds as indicated in the MA with r = 0.7
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.7)
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.7)

# calculate smd
smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, 60, 60)
# does not work, the ES is way to large
# I tried all combination of static and dynamic strength and posttest and follow
# up measures.

# I'll try to use the same study but recalculate a different ES for sit-to-stand
# test (Fig S3)
smd(1.1, 2.2, 0.4, 0.4, 60, 60)
# maximum oxygen uptake 
smd(4.5, 3.2, 0.6, 0.6, 60, 60)
# maybe the Table shows SEM instead of SD, because the values are quite small
# but this is nowhere mentioned and also does not fit

# I'll try the next study for the forest plot S1: Watanabe et al. 2020
# target ES: 0.15 [-0.02, 0.33]
# have to use exact=FALSE because of a bug in hedges correction for large n
smd(31.3-27.8, 31.9-29.7, r_to_sdd(10.9, 10.9, 0.7), r_to_sdd(10.9, 11.2, 0.7), 243, 274, exact = FALSE) |> get_ci()
# perfect match!

# try another to determine hedges correction setting and variance estimator
# choose one with rather low sample size and easy extraction procedure:
# Boshuizen et al. 2005
# target ES: 0.32 [-0.38, 1.01]

# using data from Tab 3 Pretest vs. Posttest, 
# HG (INT) vs MG (CON) [as per MA Tab 1]
smd(69.3-56.1, 65.6-57.4, r_to_sdd(19.9, 17.2, 0.7), r_to_sdd(23.1, 20.5, 0.7), 16,16, hedges = FALSE) |> get_ci()
# perfect match when hedges=FALSE
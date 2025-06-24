# Recalculation of MA #104 (Huiberts)

library(metapp)

# Study to recalculate: Mikkola et al. 2012
# target ES: -0.68 [-1.47, 0.11]

# using data for leg extension force from the beginning of the Results section:
# CON means strength training, INT mean concurrent training
mean_con_post <- 228
sd_con_post <- 29
mean_int_post <- 209
sd_int_post <- 24
# also matches published raw data from the MA

smd(mean_int_post, mean_con_post, sd_int_post, sd_con_post, 11, 16, vartype = 3) |> get_ci()
# perfect match using post scores and the RevMan var estimator

# by the way, the baseline differences were almost significant:
(189 - 171) / (sd_pooled(27, 17, 16, 11) * sqrt((1/16) + (1/11)))

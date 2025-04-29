# Recalculation of MA #001 (Qiao)

library(metapp)

# Study to recalculate: Carcelén-Fraile 2022
# target ES: -2.15 [-3.53, -0.77]

# extract relevant data from Carcelén-Fraile Tab 2 (Total PSQI)
e_mean_pre <- 7.56
e_sd_pre <- 4.56
c_mean_pre <- 8.55
c_sd_pre <- 3.31
e_mean_post <- 5.89
e_sd_post <- 3.74
c_mean_post <- 9.03
c_sd_post <-3.36

# the MA forest plot shows mean and sd values of what are probably change scores
# this should make it easier to recalculate the effect

e_mean_change <- e_mean_post - e_mean_pre
c_mean_change <- c_mean_post - c_mean_pre
# means match exactly
e_sd_change <- r_to_sdd(e_sd_pre, e_sd_post, 0.5)
c_sd_change <- r_to_sdd(c_sd_pre, c_sd_post, 0.5)
# sds match exactly when assuming r = 0.5

# mean difference 
md(e_mean_change, c_mean_change, e_sd_change, c_sd_change, 57, 60) |> get_ci()
# perfect match!
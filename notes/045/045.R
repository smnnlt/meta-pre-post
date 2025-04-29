# Recalculation of MA #045 (Stutter)

library(metapp)

# Study to recalculate: Berton et al. 2022
# target ES: 0.19 [-0.07, 0.46]

# data from Tab 1 
# heavy (WL) acts as control here 
# light (PLYO) as intervention

n_con <- 15
n_int <- 15

# data from Tab 4 (30 m)
# from the forest plot and Tab 4 it seems more plausible that change score data
# was used instead of post values

mean_con_pre <- 6.39
sd_con_pre <- 0.31
mean_con_post <- 6.40
sd_con_post <- 0.30

mean_int_pre <- 6.24
sd_int_pre <- 0.4
mean_int_post <- 6.33
sd_int_post <- 0.35

mean_con_d <- mean_con_post - mean_con_pre
mean_int_d <- mean_int_post - mean_int_pre
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.3)
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.3)

# maybe change score based
metapp::smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con) |> get_ci()
# ES point estimate only near if I try some imputations, but variance is way off

# or maybe post score based
metapp::smd(mean_int_post, mean_con_post, sd_int_post, sd_con_post, n_int, n_con)
# ES quite near, CI far off

# I may need to take another study. Next one is:
# Cormie et al. 2010 (40m)
# target ES: 0.23 [-0.07, 0.46]

# change score based given the data in Tab 3
smd(-0.12, -0.22, 0.06, 0.14, 8, 8) 
# nooo
# so it was post scores all the time?
smd(5.76, 5.69, 0.17, 0.22, 8, 8)

# hm, also 30m has a larger ES, which matches with larger between group 
# differences in post-intervention data. Speaks for post-score

# but again, the ES does not match and the CI is way to small

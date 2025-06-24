# Recalculation of MA #090 (Molinari)

library(metapp)

# Study to recalculate: Kraemer et al. 2001
# target ES: 0.42 [0.24] (mean [SE], data taken from Tab S4)

# The data is only presented in low resolution plots in the publication
# Therefore it is not possible to easily determine the outcome of interest and 
# its parameter values. For now I'll just try to reproduce the ES given the 
# values presented in Tab S4
es <- smd(2.03, -0.41, 2.98, 7.91, 9, 6)
es
# match for ES and var
# but Tab S4 reports that the results show the SE and not the var
sqrt(es$var)
es |> get_ci()

# Next I'll use the previous ES for a study that only reported on ES. I deviate
# from the usual procedure of taking the next ES from the forest plot, because 
# it is from the same study, and the next few are also from one study by the 
# same first author.

# Next try: Jenkins et al. 2021
# target ES: 0.7 [0.18] (mean [SE], data taken from Tab S4)
# Okay, I guess mCSA is the outcome, but it is only shown in plots

# so going back to the next studies in the forest plot.
# Next is Kraemer et al. 2004 (first ES)
# [Okay, so after calculation I realized that I actually did not use the first
# ES of the forest plot but the first ES of the Tab S4 (the sixth of the forest 
# plot Fig 2. These indexes differ from each other because contrary to the above 
# study this study was not ordered by ES in Tab S4]
# target ES: 0.34 [0.22] (mean [SE], data taken from Tab S4)

# from Tab 2 this ES appears to be group TP vs CON
n_int <- 18
n_con <- 6
# also time points T0 vs T2
# and outcome measure FFM (as measured by skinfolds)
# so using the data from Tab 3:
mean_int_pre <- 47.2
sd_int_pre <- 4.7
mean_int_post <- 49.1
sd_int_post <- 5.4

mean_con_pre <- 48.4
sd_con_pre <- 3.7
mean_con_post <- 48.6
sd_con_post <- 3.9

# calculate change scores
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre
# matches data from MA Tab S4

# calculate change score sd using r = 0.5 for imputation
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.5)
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.5)
# matches data from MA Tab S4

# calculate SMD
o <- smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con)
o
# matches the ES and SE data from MA Tab S4, BUT
# the function reports the value as var and the Tab S4 reports the value as SE

# let's take a look at the confidence interval, to see if var and SE were mixed
# up here. Extract approximate confidence interval width from MA Fig 2:
# 0.34 [-0.10, 0.78]
# so at least this is the correct ES and the extraction was valid
o |> get_ci()
# the correct ci is much larger! (because se is sqrt(var))
# what if I take the var as the SE
mix <- o
mix$var <- o$var^2
mix |> get_ci()
# perfect match for the extracted CI!

# so I could perfectly recalculate the ES and its CI, but for the CI the MA
# authors mixed up the SE and var, leading to incorrectly narrow CIs
# Recalculation of MA #086 (Llanos-Lagos)

library(metapp)

# Study to recalculate: Kelly et. al 2008
# target ES: 0.21 [-0.73, 1.14] (extracted from forest plot)

# Using running economy data from Tab. 4 (matches MA Table 3)
# using change scores and their sd
# but the mean change for INT does not match post-pre for INT
smd(1.5, 0.6, 2.1, 4.1, 7, 9) |> get_ci()
# yes, somewhat near

# using post scores 
smd(29.3, 30.2, 2.6, 7.0, 7, 9) |> get_ci()
# no match

# using correct mean change and imputed change score sd
smd(1.8, 0.6, r_to_sdd(3.6, 2.6, 0.5), r_to_sdd(4.6, 7, 0.5), 7, 9) |> get_ci()
# very close,
# but it is impossible to determine if this is actually the true procedure

# I'll take a look at the next (single) ES presented in the forest plot:
# Skovgaard et al. 2014
# target ES: -0.24 [-1.08, 0.59]

# using the RE data from the results section (matches MA Table 3)
# change score based 
smd(189-195, 178-180, r_to_sdd(4,4,0.5), r_to_sdd(4,6,0.5),12,9) |> get_ci()
# does not match at all
# post score
smd(189, 178, 4, 6, 12, 9)
# even worse

# another try: Damasceno et al. 2015
# target ES: 0.04 [-0.83, 0.93]
# using RE data from Tab 2 (matches MA data from Tab 3 with one data extraction
# error for INT pre sd: original is 3.2, reported in MA is 3.1)
# reverse sign
smd(41.9-42.5, 41.0-41.8, r_to_sdd(3.2,4.0,0.5), r_to_sdd(4.6,4.2,0.5), 9, 9) |> get_ci()
# ES is almost perfect, CI is a bit off

# use percentage change
smd(-1.4, -1.9, 3.6, 4.2, 9, 9) |> get_ci()
# not that good

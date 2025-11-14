# Recalculation of MA #086 (Llanos-Lagos)

# [EDITS AFTER AUTHOR CONTACT AND PROVISION OF RAW DATA]

library(metapp)

# Study to recalculate: Kelly et. al 2008
# target ES: 0.21 [-0.73, 1.14] (extracted from forest plot)

# Using running economy data from Tab. 4 (matches MA Table 3)
# using change scores and their sd
# in the original publication, the mean change for INT does not match post-pre 
# for INT
# but according to the raw data of the MA provided by the authors, they used the
# pre- and post values only

# using correct mean change and imputed change score sd
smd(1.8, 0.6, r_to_sdd(3.6, 2.6, 0.5), r_to_sdd(4.6, 7, 0.5), 7, 9) |> get_ci()
# very close
# but it is impossible to determine if this is actually the true procedure
# using post score SD as standardizer
smd(1.8, 0.6, 2.6, 7.0, 7, 9, vartype = 2) |> get_ci()
# perfect match!

# I'll take a look at the next (single) ES presented in the forest plot:
# Skovgaard et al. 2014
# target ES: -0.24 [-1.08, 0.59]

# using the RE data from the results section
# in the original study data is presented as SE! This is considered in the 
# provided raw data, but not in the MA Tab. 3

# change score based 
smd(189-195, 178-180, r_to_sdd(4*sqrt(12),4*sqrt(12),0.5), r_to_sdd(4*sqrt(9),6*sqrt(9),0.5),12,9, vartype = 2) |> get_ci()
# very near
smd(189-195, 178-180, 4*sqrt(12), 6*sqrt(9),12,9, vartype = 2) |> get_ci()
# perfect match!

# last try [only because recalculation initially was unsuccessful before]
# study: Damasceno et al. 2015 
# target ES: 0.04 [-0.83, 0.93]
# using RE data from Tab 2 (matches MA data from Tab 3 with one data extraction
# error for INT pre sd: original is 3.2, reported in MA is 3.1)
# reverse sign
smd(41.9-42.5, 41.0-41.8, 4.0, 4.2, 9, 9, vartype = 2) |> get_ci()
# perfect match (with rounding)


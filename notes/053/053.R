# Recalculation of MA #053 (Loturco)

library(metapp)

# Study to recalculate: Stergioulas et al. 2008
# target ES: 1.66 [0.97, 2.43] (extracted from forest plot)
# (seems like the forest plot is a bit asymmetric??)

33.6/sd_pooled(27.5, 14.2, 20, 20)

((33.0-79.8)-(53.0-82.8))/sd_pooled(9.5, 11.7, 20, 20)

# change score
smd(37.3-79.8, 62.8-81.8, r_to_sdd(9.5, 27.5, 0.5), r_to_sdd(11.6, 14.2, 0.5), 20, 20)

# only within group analysis for INT?
(37.3-79.8) / 27.5
(33.0-79.8) / 29.8

# I have tried a few things without success. I'll take a look at the next study:
# Ammendolia et al. 2016
# target ES: 0.40 [-0.28, 1.09] (extracted from forest plot)
# (at least this is not asymmetric)

# unclear how to recalculate:
# Next: Taleb et al. 2022
# target ES: 1.00 [0.35, 1.69]

# hm, still don't know

# Verma, also no idea
(6.17 - 2.39)-(6.61-3.89) / 1

# last try: Takenori

(3.26-5.32)/1.4
((3.26 - 5.32) - (5.33 - 5.88))/1.4

# based on the available data and trying different guessed, I cannot recalculate
# the ES at the moment.
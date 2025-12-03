# Recalculation of MA #005 (da Silva)

library(metapp)

# authors provided a data sheet with the effect sizes, standard errors, and 
# sample sizes per group for each included study

# Study to recalculate: Franchi et al. 2014
# target ES: -4.0 [SE: 1.0] (SE provided by the authors)

# based on Sup Tab 2, a text section was used: 
# "a significant difference was found in both mid portion (EG = 7 +/- 1%, and 
# CG = 11 +/- 1%, P < 0.01)"

# Note that SEM are given here! Normally would require to set sd = sqrt(12)*SEM

# using Cohen's d SMD
o1 <- smd(x1 = 7, x2 = 11, sd1 = 1, sd2 = 1, n1 = 6, n2 = 6, hedges = FALSE)
o1
sqrt(o1$var)

# perfect match

# which is Häkkinen et al. 2022
# target ES 1.02 [SE: 0.44] (SE provided by the authors)
# Table 4 Häkkinen as indicated by Sup Tab 2:
# ECC 12.4 % ± 6.9 %, CON 7.1 % ± 2.9 %

o2 <- smd(12.4,7.1, 6.9, 2.9, 11, 12, hedges = FALSE) 
o2
sqrt(o2$var)

# perfect match!

# next study: Higbie et al. 1996 
# target ES: 0.1 [SE: 0.32] (SE provided by the authors)
# (values from Table 3, CTG vs ETG)
sd_con <- r_to_sdd(52.0, 56.2, 0.5)
sd_exc <- r_to_sdd(41.3, 43.7, 0.5)
o3 <- smd(15.0, 19.9, sd_con, sd_exc, 19, 19, hedges = FALSE)
o3
sqrt(o3$var)

# perfect match!

# Recalculation of MA #001 (Cove)

library(metapp)

# Study to recalculate: Franchi et al. 2014
# target ES: -4 [-6.1; -2.1] (CI extracted from plot!)

# based on Sup Tab 2, a text section was used: 
# "a significant difference was found in both mid portion (EG = 7 +/- 1%, and 
# CG = 11 +/- 1%, P < 0.01)"

# Note that SEM are given here! Normally would require to set sd = sqrt(12)*SEM

# The forest plot has -4 [-6.1; -2.1] as effect size (CI extracted from plot)
smd(x1 = 7, x2 = 11, sd1 = 1, sd2 = 1, n1 = 12, n2 = 12, hedges = FALSE) |> get_ci(df = 11)

# CI does not match and ES only if no hedges correction is applied and the 
# standard error is taken as the standard deviation

# maybe the numbers were just directly used for calculation. I'll try the next effect size

# which is Häkkinen et al. 2022
# target ES 1.02 [0.1, 1.9] CI extracted from plot
# Table 4 Häkkinen as indicated by Sup Tab 2:
# ECC 12.4 % ± 6.9 %, CON 7.1 % ± 2.9 %

smd(12.4,7.1, 6.9, 2.9, 11, 12, hedges = FALSE, vartype = 2) |> get_ci()

# could reproduce ES when no Hedges correction. CI quite near (also extraction quality was low)
# still no information on imputation as it is not applicable here
# we therefore use the next one

# next study: Higbie et al. 1996 
# target ES: 0.1 [x, x]
# (values from Table 3, CTG vs ETG)
sd_con <- r_to_sdd(52.0, 56.2, 0.5)
sd_exc <- r_to_sdd(41.3, 43.7, 0.5)
smd(15.0, 19.9, sd_con, sd_exc, 16, 19, hedges = FALSE, vartype = 2) |> get_ci()

# ES matches exactly, CI unclear because not possible to extract. 

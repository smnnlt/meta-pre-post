# Recalculation of MA #053 (Loturco)

library(metapp)

# Study to recalculate: Stergioulas et al. 2008
# target ES: 1.66 [0.97, 2.43] (extracted from forest plot)
# (seems like the forest plot is a bit asymmetric??)

33.6/sd_pooled(27.5, 14.2, 20, 20)

# SMD of change scores with pre SD standardization
smd(33.0-79.8, 53.0-81.8, 9.5, 11.6, 20, 20) |> get_ci()
# point estimate perfect, variance quite near

# the calculation sheets used appear to use vartype=2 for Hedges' g var
smd(33.0-79.8, 53.0-81.8, 9.5, 11.6, 20, 20, vartype = 2) |> get_ci()

# change score
smd(37.3-79.8, 62.8-81.8, r_to_sdd(9.5, 27.5, 0.5), r_to_sdd(11.6, 14.2, 0.5), 20, 20)

# I have tried a few things without success. I'll take a look at the next study:
# Ammendolia et al. 2016
# target ES: 0.40 [-0.28, 1.09] (extracted from forest plot)
# (at least this is not asymmetric)

smd(9.1-2.1, 8.8-1.2, 1.066, 0.933, 16, 19)

# unclear how to recalculate:
# Next: Taleb et al. 2022
# target ES: 1.00 [0.35, 1.69]

#PAP1
smd(4.13, 3.12, 0.31, 0.66, 20, 20)
smd(4.13-2.24, 3.12-2.34, 0.47, 0.55, 20, 20)
#PAP2
smd(4.21, 3.16, 0.35, 0.58, 20, 20)
smd(4.21-2.47, 3.16-2.58, 0.58, 0.5, 20, 20)
# HAGOS
smd(108.7-287.72, 143.34-290.45, 22.26, 25.77, 20, 20)

# hm, still don't know

# Verma, also no idea
# 0.85 [0.18, 1.57]
smd(2.39 - 6.17, 3.89 - 6.61, 0.97, 1.42, 18, 18, vartype = 2) |> get_ci()
# point estimate perfect, variance perfect for lower (not good for upper, this may be an extraction problem)

# last try: Takenori
# target ES: 1.33 [0.58, 2.14]

# data presented as 95% CI
ci_to_sd <- function(ci_low, ci_high, n) {
  ci_len <- (ci_high - ci_low) / 2
  se <- ci_len / qt(0.975, n - 1)
  sd <- se * sqrt(n)
  sd
}

smd(3.26-5.29, 5.32-5.88, ci_to_sd(3.98, 6.61, 16), ci_to_sd(5.09, 6.66, 16), 16, 16)
# does not match

# based on the available data and trying different methods, the authors may have
# used a change score based SMD with pre-score standardization. But I could only 
# recalculate two (extracted) point estimates with somewhat matching CIs, so I
# am absolutely not sure this is correct. The authors have not responded to a 
# data request
# the ES at the moment.
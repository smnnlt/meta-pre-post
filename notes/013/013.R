# Recalculation of MA #013 (Zawieja)

library(metapp)

# study to recalculate: Moro et al. 2020
# target ES: 0.21 [-0.52, 0.94]

# extract relevant data from Moro Tab 3 (Back Squat)
# the MA forest plot shows mean and sd values, which makes it
# clear that only post values were used

e_mean_post <- 98.08
e_sd_post <- 36.79
c_mean_post <- 91
c_sd_post <- 29.63

smd(e_mean_post, c_mean_post, e_sd_post, c_sd_post, 14, 15) |> get_ci()
# perfect match!

# possibly vartype=3 and Hedges=TRUE but cannot confirm because other options 
# give almost similar results
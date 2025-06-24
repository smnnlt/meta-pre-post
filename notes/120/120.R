# Recalculation of MA #120 (Barrera-Domínguez)

library(metapp)

# Study to recalculate: Asadi et al. 2017 (It)
# target ES: -1.53 [-2.69, -0.38]

# using POST data from Tab 3 (Illinois agility test)

mean_int <- 17.81
sd_int <- 0.71
mean_con <- 18.97
sd_con <- 0.72

# use SMD with RevMan variance estimator
smd(mean_int, mean_con, sd_int, sd_con, 8, 8, vartype = 3) |> get_ci()
# perfect match

# metafor and Borenstein var estimators have different CIs
smd(mean_int, mean_con, sd_int, sd_con, 8, 8, vartype = 1) |> get_ci()
smd(mean_int, mean_con, sd_int, sd_con, 8, 8, vartype = 2) |> get_ci()



# Recalculation of MA #126-2 (Junge) 

library(metapp)

# Study to recalculate: Contreras et al. 2017
# target ES: -0.26 [-1.00, 0.49] (taken from Supplemental Material)

# set horizontal as INT and vertical as CON

# using data from Tab 3 (Vertical Jump)

# percentage changes
mean_int_dperc <- 103.42
mean_con_dperc <- 107.30

# post SD
mean_int_post <- 58.23
sd_int_post <- 7.82
mean_con_post <- 56.09
sd_con_post <- 8.22
# calculate percentage post SD
sd_int_postperc <- 100 * sd_int_post / mean_int_post # match
sd_con_postperc <- 100 * sd_con_post / mean_con_post # no match

# possibly there is a data extraction error here, maybe
sd_con_postperc_err <- 100 * 8.82 / mean_con_post # match

# using sample size from Methods (subjects) section
n_int <- 14
n_con <- 14

# calculating SMD
smd(mean_int_dperc, mean_con_dperc, sd_int_postperc, sd_con_postperc_err, n_int, n_con, vartype = 3) |> get_ci()
# perfect match
# vartype 1 or 3 both match in this case
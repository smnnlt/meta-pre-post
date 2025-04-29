# Recalculation of MA #041 (Bischof)

library(metapp)

# Study to recalculate: Jendricke et al. 2019
# target ES: 0.70 [0.24; 1.16]

n_int <- 37
n_con <- 40

# try to match the values from MA Tab 1
# using Tab 2 with converting percentage value to absolute FFM

mean_int_pre <- 73.5 * 0.626
mean_int_post <- 73.0 * 0.644
mean_int_d <- mean_int_post - mean_int_pre
# matches

mean_con_pre <- 72.8 * 0.638
mean_con_post <- 72.4 * 0.647
mean_con_d <- mean_con_post - mean_con_pre
# not exactly matches

# the text also mentions INT 1(+- 0.9) and CON 0.4 (+- 0.9)
sd_int_d <- 0.9
sd_con_d <- 0.9
# but the MA shows values with more decimals in Tab 1

# nonetheless try to recalculate the ES
smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con) |> get_ci()
# not exactly

# use values from MA Tab 1
smd(1, 0.38, 0.89, 0.87, n_int, n_con) |> get_ci()
# perfect match

# vartype=2 and hedged=FALSE do not exactly match

# I am still unsure where the data in MA Tab 1 came from, so I'll try to get the
# Tab 1 data for the previous ES (Bischof 2023)

# okay so these are the MA authors and they surely have access to the raw data,
# so I'll take the next (3rd) ES: Jendricke 2020

# (also the same research group) but here the numbers match

# Recalculation of MA #043 (Poon)

library(metapp)

# Study to recalculate: Ballin 2019
# target ES:-0.70 [-3.62, 2.22]

# use data from Tab 2
# forest plot indicates that probably post scores are used

mean_int_post <- 38.8
sd_int_post <- 6.9
mean_con_post <- 39.5
sd_con_post <- 5.7
n_int <- 36
n_con <- 36

md(mean_int_post, mean_con_post, sd_int_post, sd_con_post, n_int, n_con) |> get_ci()
# perfect match!
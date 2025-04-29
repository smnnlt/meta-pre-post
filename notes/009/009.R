# Recalculation of MA #009 (Benavente)

library(metapp)

# Study to recalculate: Martínez Guardado (2020) biceps curl
# target ES: 0.66 [0.19; 1.14] (with 90% [!!] confidence interval)

c_mean_pre = 43.87
c_mean_post = 48.75
c_sd_pre = 7.73

e_mean_pre = 35.12
e_mean_post = 44.18
e_sd_pre = 3.96

# bad luck during randomization btw

ppc(e_mean_post - e_mean_pre, c_mean_post - c_mean_pre, c_sd_pre, e_sd_pre, 16, 16, 0.7) |> get_ci(level = 0.9)
# wow, perfect match with the first try!!!
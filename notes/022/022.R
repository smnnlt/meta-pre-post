# Recalculation of MA #022 (Diaz-Lara)

library(metapp)

# Study to recalculate: Hammond et al. 2019
# target ES: -0.84 [-1.81, 0.14]

# extracted data from Fig 6A (+ 3h)
# means:
# 5.56, 3.25, 3.01
# upper end error bar
# 9.51, 5.50, 5.74

# HIGH condition is HCHO, I suppose low is LCHF
mean_high <- 5.56
sd_high <- 9.51 - mean_high
mean_low <- 3.25
sd_low <- 5.5 - mean_low

n <- 9

smd(mean_low, mean_high, sd_low, sd_high, n, n) |> get_ci()
# no match (also not with hedges = FALSE)

# maybe the other group
smd(3.01, mean_high, 5.74-3.01, sd_low, n, n) |> get_ci()
# no, this is too large

# okay, I'll try another study.
# Next one is: Hearris 2019
# target ES: -0.56 [-1.56, 0.45]

# data extracted from Fig 5A (individual points)

high <- c(2.73, 3.83, 4.13, 4.42, 7.21, 7.44, 8.66, 12.09)
low <- c(1.60, 2.89, 3.06, 5.13, 5.17, 5.31, 6.99, 9.55)

# check extracted means: 6.25, 4.86
mean(high)
mean(low)
# hm okay

smd(mean(low), mean(high), sd(low), sd(high), 8, 8) |> get_ci()
# not really, somewhere near but not matching

# I believe if we have to perform data extraction to get the original study 
# values here we won't be able to get a recalculation

# I looked into all studies in the forest plot and none of them provides
# PGC1-alpha data outside of plots, so I think it is not possible to recalculate
# the ES here
# Recalculation of MA #006 (Khudair)

library(metapp)

# Study to recalculate: Fu et al. 2013
# target ES: 0.63 [0.1; 1.19]

# test post score based analysis first
smd(4.05, 3.66, 0.87, 1.17, 31, 30, hedges = FALSE) |> get_ci()
# does not work

# change score with post standard deviation
smd(0.45, -0.24, 0.87, 1.17, 31, 30, hedges = FALSE) |> get_ci()
# closer

# change score with pre standard deviation
smd(0.45, -0.24, 1.22, 1.06, 31, 30, hedges = FALSE) |> get_ci()
# also close

# change score with average standard deviation
smd(0.45, -0.24, sd_avg(1.22, 0.87), sd_avg(1.06, 1.17), 31, 30, hedges = FALSE) |> get_ci()
# ES fits, CI close

# same for imputation of change score sd
smd(0.45, -0.24, r_to_sdd(1.22, 0.87, 0.5), r_to_sdd(1.06, 1.17, 0.5), 31, 30, hedges = FALSE) |> get_ci()

# try second study: Lee & Gao (2020)
# target ES: 0.17 [-0.15; 0.49]

smd(0.2, 0, sd_avg(1.14, 1.23), sd_avg(1.24, 1.18), 77, 80, hedges = FALSE) |> get_ci()
# ES fits, CI almost

# similar result when using r=0.5 imputation
smd(0.2, 0, r_to_sdd(1.14, 1.23, 0.5), r_to_sdd(1.24, 1.18, 0.5), 77, 80, hedges = FALSE) |> get_ci()

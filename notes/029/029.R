# Recalculation of MA #029 (Ivanic)

library(metapp)

# Study to recalculate: Attwood et al. 2022
# target ES: 1.33 [0.50, 2.17]

# using data from Tab 1:
# because multiple directions are reported, a composite score (as written in the
# MA) has to be calculated
# for the means this is just the change in the Total row divided by 4

mean_con_d <- (1026.5 - 845.9)/4
# does not match

mean_int_d <- (1184-831.6)/4
# match!

# try to get the SDs
sqrt((
  r_to_sdd(36, 35.2, 0.8)^2+
  r_to_sdd(72.9, 69, 0.8)^2+
  r_to_sdd(68.1, 60.8, 0.8)^2+
  r_to_sdd(59, 53.3, 0.8)^2)
  /4
)

sqrt((
  r_to_sdd(35, 49.6, 0.8)^2+
    r_to_sdd(73.2, 57.5, 0.8)^2+
    r_to_sdd(41.5, 40.1, 0.8)^2+
    r_to_sdd(60.8, 57, 0.8)^2)
  /4
)

# I do not know where the means and sd come from

# At least I'll try if I can recalculate the ES given the values in the forest 
# plot
smd(88.1, 39.17, 37.16, 33.76, 15, 13, vartype = 3) |> get_ci()
# perfect match!

# Okay I'll try the next: Barrett 2015
# data from table two, but unclear which variables should be used

barrett <- data.frame(
  con_pre = c(20.27, 19.63, 30.87, 31.03, 30.05, 32.32, 22.22, 36.82),
  con_post = c(21.54, 22.32, 36.02, 35.22, 35.63, 36.1, 24.99, 41.25),
  con_per = c(8.46, 15.46, 16.07, 13.66, 21.73, 13.86, 14.72, 13.28),
  int_pre = c(21.57, 21.86, 31.42, 31.64, 33.4, 33.13, 24.60, 38.77),
  int_post = c(24.44, 23.63, 35.92, 35.83, 39.95, 39.16, 27.7, 45.65),
  int_per = c(16.86, 10.72, 20.08, 18.07, 12.77, 13.77, 15.79, 21.74)
)

barrett$con_d <- barrett$con_post - barrett$con_pre
barrett$int_d <- barrett$int_post - barrett$int_pre
# okay wow, calculated and reported percentage change do not match
barrett$con_dper <- barrett$con_pre * 0.01 * barrett$con_per
barrett$int_dper <- barrett$int_pre * 0.01 * barrett$int_per

mean(barrett$con_d[7:8])
# almost, but the rest doesn't match
mean(barrett$int_d[5:8])

con_changes <- c(21.54-20.27, 22.32-19.63, 36.02-30.87, 35.22-31.03, 35.63-30.05, 36.10-32.32, 24.99-22.22, 41.25-36.82)
mean(con_changes[7:8]) # almost
int_changes <- c(27.7-24.6, 45.65-38.77)
mean(int_changes)
mean(c(24.6*0.1579, 38.77 * 0.2174))

# Becker et al. 2019 (Tab 4)

b_mean_con_d <- (27.5 + (-39.2))/2
# match

b_mean_int_d <- (36.3 + (-1.9))/2
# match

b_sd_con_d <- sd_avg(27.5, 55.9)
b_sd_int_d <- sd_avg(21.6, 55.9)
# both match
# okay so SD is simple average SD of all change score SDs

# but imputation is still unclear
# so the next one: Burnett 2005
# no imputation needed here

# okay it is extremely difficult to find an easy study that requires imputation



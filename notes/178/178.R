# Recalculation of MA #178 (Brink)

library(metapp)

# Study to recalculate: Sims 2016
# target ES: -0.03 [-0.80, 0.73]

# using the data from text section 4.1

# the study does only have one measurement per condition (so no pre-data)

n <- 13
mean_int <- 1.18
sd_int <- 0.083
mean_con <- 1.15
sd_con <- 0.085

smd(mean_int, mean_con, sd_int, sd_con, n, n) |> get_ci()
# no match

# there appears to be a data extraction error, as evident in the forest plot,
# where the SD are off by a factor of 10. For example, the INT SD is reported
# in the original study as .083, but the MA uses 0.83

# use the incorrectly extracted data
smd(mean_int, mean_con, 10*sd_int, 10*sd_con, n, n) |> get_ci()
# perfect match (when considering the reversed sign as faster times are better)

# try the next study to see if also post scores were used:
# Howe et al. 2017

# uses data extracted from a forest plot

# I'll try the next: Abade et al. 2017

# again, data extracted from a plot, but this time clearly post data was used
# although pre data was also available (and change scores were reported in a 
# table)

# try next: De Sousa et al. 2018
# target ES: 0.55 [-0.10, 1.20]

# using data from Tab 3: (converting scale to cm)

ds_mean_int <- 48
ds_sd_int <- 9
ds_mean_con <- 43
ds_sd_con <- 9

ds_n <- 19
# the MA shows almost the same values (off by 0.01), it is surprising why these 
# values are off

# calculate SMD
smd(ds_mean_int, ds_mean_con, ds_sd_int, ds_sd_con, ds_n, ds_n) |> get_ci()
# almost perfect

# use the values from the forest plot
smd(ds_mean_int + 0.01, ds_mean_con - 0.01, ds_sd_int -0.01, ds_sd_con+0.01, ds_n, ds_n) |> get_ci()
# perfect match!
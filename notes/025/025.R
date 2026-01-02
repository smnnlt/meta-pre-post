# recalculation for MA #025 (Feng)

library(metapp)

# study to recalculate is Wolfenden et al. 2019
# target ES is -3.69 [-7.07; -0.31]

# the forest plot shows detailed means and sd of what the text says are post-
# measures
# the outcome of the forest plot is sedentary behaviour as % of wear time

# Wolfenden 2019 reports in Tab 2 under other measures sedentary time in min

n_int <- 89
n_con <- 97

# if we use mean sedentary time in min and the mean activity times in min we 
# can calculate sedentary time as a mean percentage

totaltime_int <- 241.23 + 59.52 + 35.59 + 22.76
totaltime_con <- 243.26 + 17.62 + 29.71 + 52.66

mean_int <- 241.23 / totaltime_int # matches 67.18% from forest plot
mean_con <- 243.26 / totaltime_con # matches 70.87% from forest plot

sd_int <- 40.98 / totaltime_int # matches 11.41% from forest plot
sd_con <- 41.57 / totaltime_con # matches 12.11% from forest plot

# recalculate MD as stated in the text
metapp::md(mean_int, mean_con, sd_int, sd_con, n_int, n_con) |> get_ci()
# perfect match
# also var_homo = FALSE confirmed
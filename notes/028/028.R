# Recalculation of MA #028 (Zhao)

library(metapp)

# Study to recalculate: Abbasian et al. 2022 (FG)
# target ES: 1.34 [SE: 0.1765709]

# data is presented in Tab 1 (FBS), different intervention groups have to be
# combined here, so for convenience I choose the next study instead.

# next study: Abdelbasset et al. 2019 (FG)
# target ES: 0.80 [SE: 0.5202163]

# using data from Tab 2 (FPG)
mean_int_pre <- 6.2
sd_int_pre <- 1.8
mean_int_post <- 5.3
sd_int_post <- 1.2
n_int <- 16

mean_con_pre <- 5.9
sd_con_pre <- 1.4
mean_con_post <- 6.1
sd_con_post <- 1.7
n_con <- 16
# matches provided raw data

o <- md(mean_int_post, mean_con_post, sd_int_post, sd_con_post, n_int, n_con, var_homo = FALSE)
o
sqrt(o$var)
# perfect match! uses post data (means and SD), although pre data was also
# available. As there is an indicator column (valuefrom) post/change in the raw
# data, I will just check how the calculation worked for effect sizes that
# indicated change score based (which is the minority)

# try next: Ahn et al. 2012
# target ES: 1.40 [0.61880615]

# use change score values from Tab 3 Fasting Blood Glucose
# convert from mg/dl to mmol/l (factor 1/18.016) the round to first decimal
a_mean_int_d <- round(12.85 / 18.016, 1)
a_sd_int_d <- round(40.66 / 18.016, 1)
a_n_int <- 20
a_mean_con_d <- round(-11.84 / 18.016, 1)
a_sd_con_d <- round(26.36 / 18.016, 1)
a_n_con <- 19

# matches provided raw data
a_o <- md(a_mean_int_d, a_mean_con_d, a_sd_int_d, a_sd_con_d, a_n_int, a_n_con, var_homo = FALSE)
a_o
sqrt(a_o$var)
# perfect match!

# So it seems that if change score data was available this was used, otherwise 
# post data was used
# I will just check a last reference to see that this was actually the decision
# criterion

# study to recalculate: Ahmadreza et al. 2016
# target ES: 0.90 [SE: 0.41335163]

# using data from Tab 2 (FBS)
# presents change scores but no change score SD
round(-5.44/18.016, 1)
round(-20.96/18.016, 1)
# no SDs available, so these were likely imputed from other studies as indicated
# in the manuscript

# So overall, this is a mix of change-scores and post-scores, depending on the 
# data availability. As most of the extracted data was post-score based (as)
# indicated by the raw data, I would categorize this as post-score based.
# The method used is a simple MD assuming heterogeneous variances.
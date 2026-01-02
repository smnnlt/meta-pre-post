# Recalculation of MA #181 (Martin-Martinez)

library(metapp)

# Study to recalculate: Fedewa et al. 2015
# target ES: 0.38 [0.18, 0.58]

# using data from the results section (reading achievements):
mean_int_pre <- 64.01
sd_int_pre <- 32.83
mean_int_post <- 70.57
sd_int_post <- 30.41

mean_con_pre <- 71.08
sd_con_pre <- 18.95
mean_con_post <- 70.29
sd_con_post <- 20.39

# calculate mean change and change score sd with r = 0.7
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.7)
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.7)

# calculate SMD
# using total N data
smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, 156, 304, hedges = FALSE) |> get_ci()
# very near (off by 0.01)
# using rounded values (es incorrectly rounded)
data.frame(es = 0.38, var = 0.01) |> get_ci()
# perfect match

# using n of completed tests
smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, 153, 203, hedges = FALSE) |> get_ci()
# bit more off

# try next study: Sallis et al. 1999

# this study has two cohort and two experimental groups, so requires two steps 
# of ES or data combination. I'll use the next study instead:

# De Brujin et al. 2020
# target ES: 0.06 [-0.10, 0.23]

# using data from Tab 2 (Reading, Control vs Aerobic)
db_mean_con_pre <- 18.22
db_mean_con_post <- 19.44
db_sd_con_pre <- 4.74
db_sd_con_post <- 4.69

db_mean_int_pre <- 18.82
db_mean_int_post <- 19.82
db_sd_int_pre <- 4.25
db_sd_int_post <- 4.30

# use post scores only
smd(db_mean_int_post, db_mean_con_post, db_sd_int_post, db_sd_con_post, 417, 214, hedges = FALSE) |> get_ci()
# very near but not perfect

# change score based
db_mean_int_d <- db_mean_int_post - db_mean_int_pre
db_mean_con_d <- db_mean_con_post - db_mean_con_pre
db_sd_int_d <- r_to_sdd(db_sd_int_pre, db_sd_int_post, 0.7)
db_sd_con_d <- r_to_sdd(db_sd_con_pre, db_sd_con_post, 0.7)

smd(db_mean_int_d, db_mean_con_d, db_sd_int_d, db_sd_con_d, 417, 214, hedges = FALSE) |> get_ci()
# perfect match!
# but sign is reversed (different direction of the ES!)

smd(db_mean_int_d, db_mean_con_d, db_sd_int_d, db_sd_con_d, 417, 214, vartype = 2) |> get_ci()
# because of the large n, hedges correction does not notably change the results


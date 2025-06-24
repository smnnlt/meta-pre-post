# Recalculation of MA #105 (Reinebo)

library(metapp)

# Study to recalculate: Thelwell & Maynard 2003
# target ES: 0.82 [-0.42, 2.07]

# MA Tab 2 describes the parameter as:
# "For batters, runs scored, for bowlers, number of wickets taken in an innings"

# using data from Tab 3 (Objective)
mean_int_pre <- 0.15
mean_con_pre <- 0.18
sd_int_pre <- 0.29
sd_con_pre <- 0.25

mean_int_post <- 0.40
mean_con_post <- 0.16
sd_int_post <- 0.26
sd_con_post <- 0.29

mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre

# calculate change score sd with r = 0.5
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.5)
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.5)

# change score based
smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, 8, 8)
# no match

# post score based
smd(mean_int_post, mean_con_post, sd_int_post, sd_con_post, 8, 8) |> get_ci()
# ES perfect match, CI far off
# also post scores match the published data of the MA

# maybe this is because of the multi-level character of the MA
# because another the second variable from the same study also has incompatible
# CI
smd(6.33, 4.91, 0.50, 0.38, 8, 8) |> get_ci()

# try instead a study with only one outcome measure included in the MA:
# Kress et al. 1998
# target ES: 0.48 [-0.72, 1.69]

# I could not retrieve the study but use the published MA raw data instead
smd(-949.92, -1007.03, 80.88215131, 133.7392257, 6, 5) |> get_ci()
# perfect match

# verify for one more study with raw data retrieval
# Barnicle & Burton (2016)
# target ES: 0.54 [-0.39, 1.46]

# using data from Tab 4:
smd(2.1, 0.9, 3.1, 1.0, 8, 11) |> get_ci()
# perfect match

# Recalculation of MA #092 (Babiloni-Lopez)

library(metapp)

# Study to recalculate: Cuesta-Vargas et al. 2011
# target ES: -0.083 [-0.634, 0.469]

# [EDIT DURING PARALLEL EXTRACTION AUDIT]:
# During checking the parallel extractions, both researchers independently
# evaluating this study (TS and SN) tried to find the correct recalculation
# method together, as both could not get a matching recalculation by themselves.
# Together they could verify the actual method used as SMD of change scores
# (correlation of 0.5) with post score SD standardization (with B&H var 
# estimator)

# directly use change score data from Tab 4
smd(-36.1, -34.1, 25.1, 26, 23, 23) |> get_ci()
# not exact

# data from Tab 1 (Pain VAS)
mean_con_pre <- 57.6
sd_con_pre <- 14.1

mean_int_pre <- 52.5
sd_int_pre <- 20.0

# data from Tab 2 (Pain VAS)
mean_int_post <- 16.4
sd_int_post <- 24.4

mean_con_post <- 23.4
sd_con_post <- 20.6

mean_con_d <- mean_con_post - mean_con_pre
mean_int_d <- mean_int_post - mean_int_pre
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.5)
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.5)

# using post score SD as standardized
smd(mean_int_d, mean_con_d, sd_int_post, sd_con_post, 25, 24, vartype = 2) |> get_ci()
# not exact

# unsure why this is the case, because Tab S1 shows that the same data was 
# extracted. So there appear to be differences in the ES calculation

# Try next study: Keane 2011
# I do not know where the sd is taken from

# try next: Mirmoezzi et al. 2021
# target ES: -1.967 [-2.852, -1.082]
# use data from Tab 3 (matches MA data from Tab S1)
m_mean_int_pre <- 6.57
m_sd_int_pre <- 1.02
m_mean_con_pre <- 5.90
m_sd_con_pre <- 1.77

m_mean_int_post <- 3.43
m_sd_int_post <- 1.55
m_mean_con_post <- 5.64
m_sd_con_post <- 1.28
#m_mean_con_post <- 5.57
#m_sd_con_post <- 0.85

m_mean_int_d <- m_mean_int_post - m_mean_int_pre
m_mean_con_d <- m_mean_con_post - m_mean_con_pre

m_sd_int_d <- r_to_sdd(m_sd_int_pre, m_sd_int_post, 0.5)
m_sd_con_d <- r_to_sdd(m_sd_con_pre, m_sd_con_post, 0.5)
smd(m_mean_int_d, m_mean_con_d, m_sd_con_d, m_sd_int_d, 14, 14) |> get_ci()
smd(m_mean_int_d, m_mean_con_d, m_sd_con_pre, m_sd_int_pre, 14, 14) |> get_ci()
# all not exact
# post SD standardization with vartype = 2
smd(m_mean_int_d, m_mean_con_d, m_sd_con_post, m_sd_int_post, 14, 14, vartype = 2) |> get_ci()
# perfect match

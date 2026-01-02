# libs
library(metapp)

# Systematic review: 158
# Time of the day of exercise impact on cardiovascular disease risk factors in adults: a systematic review and meta-analysis, 
# Sevilla-Lorente, R. et al. Journal of Science and Medicine in Sport, Volume 26, Issue 3, 169 - 179 
# Original article:
# Larsen, P., Marino, F., Melehan, K., Guelfi, K. J., Duffield, R., & Skein, M. (2019).
# Evening high‐intensity interval exercise does not disrupt sleep or alter energy intake despite changes in acylated ghrelin in middle‐aged men.
# Experimental physiology, 104(6), 826-836.

# target: 1.1 [0.22, 1.98]

# Data extracted with WebPlotDigitizer

n <- 11
ev_avg_pre <- 5.37
ev_sd_pre <- 4.53
ev_avg_post <- 6.07
ev_sd_post <- 5.12
mrn_avg_pre <- 5.50
mrn_sd_pre <- 6.03
mrn_avg_post <- 6.90
mrn_sd_post <- 8.13
aft_avg_pre <- 5.09
aft_sd_pre <- 4.52
aft_avg_post <- 5.89
aft_sd_post <- 4.95

# using Table S3 from the supplementary information
df <- n - 1
c_df <- 1 - 3/(4*df - 1)
sd_pooled <- sqrt((aft_sd_post**2 + mrn_sd_post**2)/2)
g_rm <- c_df * (mrn_avg_post - aft_avg_post)/sd_pooled
g_rm

# nope

# trying change-scores
sd_pre <- sqrt((mrn_sd_pre**2 + aft_sd_pre**2)/2)
sd_post <- sqrt((mrn_sd_post**2 + aft_sd_post**2)/2)
r <- (sd_pre**2 + sd_post**2 - (sd_pre - sd_post)**2)/(2*sd_pre**2 + sd_post**2)
s_diff <- sqrt(sd_pre**2 + sd_post**2 - 2 * r * sd_pre * sd_post)
m_diff <- (mrn_avg_post - mrn_avg_pre) - (aft_avg_post - aft_avg_pre)
cohens_d_rm <- m_diff / s_diff * sqrt(2*(1-r)) 
g_rm <- cohens_d_rm * (1 - 3/(4*(2*n)-9))
g_rm

# nope

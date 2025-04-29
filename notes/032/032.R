# Recalculation of MA #032 (Feter)

library(metapp)

# Study to recalculate: Carter et al. 2018 (2xLPA condition)
# target ES: 0.32 [-0.08, 0.71]

# THIS IS A CROSSOVER RCT

# Use Tab 2 (seated) for SIT and 2WALK

## I just saw that data and code is available from OSF, so I'll try to
# closely follow the provided sources

n <- 15

mean_con_pre <- 55.4
sd_con_pre <- 2.4 * sqrt(n) # convert from SE
mean_con_post <- 53.8
sd_con_post <- 1.6 * sqrt(n) # convert from SE
mean_con_d <- -1.4
sd_con_d <- 1.8 * sqrt(n) # convert from SE

mean_int_pre <- 56.4
sd_int_pre <- 2.0 * sqrt(n) # convert from SE
mean_int_post <- 56.3
sd_int_post <- 2.4 * sqrt(n) # convert from SE
mean_int_d <- 1.1
sd_int_d <- 2.4 * sqrt(n) # convert from SE

#back calculating pre-post correlations from sd of change

# okay so here was an error in extracting sd_d for control:
# se_d was 1.8 in Tab 2, but noted 1.6 in the excel file
r_con <- sdd_to_r(sd_con_pre, sd_con_post, 1.6*sqrt(n))
# when correcting the error: match

r_int <- sdd_to_r(sd_int_pre, sd_int_post, sd_int_d)
# match

# take the mean for the study-level correlation
r <- mean(r_con, r_int)

# calculate SMD of within group change 
# (Excel columns SMD_cochrane, SeSMD_cochrane)
# the MA uses the correlation averaged over all measures
# but the data file incorrectly references the wrong correlation here
# (for 'Cerebrovascular conductance' instead of 'Cerebral blood flow velocity', 
# which is 0.69 instead of 0.72)
e <- smcr(mean_con_post, mean_int_post, sd_con_post, sd_int_post, n, 0.69, hedges = FALSE) 
get_ci(e)
sqrt(e$var)
# matches both

# The excel file has further columns: hedges and seHedges
# the Hedges column is essentially the same as the SMD_cochrane columns but uses
# the pooled standard deviation instead of the average standard deviation in the
# denominator. Which is not the typical Hedges SMD. Also this means for equal n
# both effect sizes are equal

# se_hedges is the smcr with hedges=TRUE (and exact=FALSE) 
# and also (!) df=n1+n2-3 in the correction factor (which would be incorrect)
# for a single group design (so it does not really match the ES procedure)

h <- e
h$var <- j(n*2-2, exact = FALSE)^2 * h$var
get_ci(h)
# matches perfectly!!

# just out of interest, what happens if we try to fix a few things:
# 1. calculate a study level correlation based on the correctly extracted data
r_con_new <- sdd_to_r(sd_con_pre, sd_con_post, sd_con_d)
r_new <- mean(r_con_new, r_int)
# using this correlation and actual Hedges' g correction
smcr(mean_con_post, mean_int_post, sd_con_post, sd_int_post, n, r_new, hedges = TRUE) |> get_ci()
# so the correction does not make any real difference in this specific example
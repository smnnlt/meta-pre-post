# Recalculation of MA #158 (Sevilla-Lorente)

library(metapp)

# Study to recalculate: Jones et al. 2008
# target ES: 0.06 [-0.78, 0.89]

# I am unsure about which data to use for the calculations (baseline from Tab1?
# and changes from Fig 1A 20 min, or data from Fig 5).
# Also data would need to be extracted from figures

# next study: Jones et al. 2009
# several problems: two intervention groups, data in figures, unclear time point

# next study: O'Connor et al. 1992
# target ES: 0.01 [-0.82, 0.85]

# using data from Tab 3 (Systolic BP)
# I use the MA Fig S1 to validate the within group ES

mean_am_pre <- 114.9
sd_am_pre <- 14.0
mean_am_post <- 110.2
sd_am_post <- 10.3

# formula for calculating the within group SMD ES
d_rm <- function(xd, sdd, n, r) {
  # note that the bias correction factor is incorrect (should be df = n-1 for
  # repeated measurements)
  (xd / sdd) * sqrt(2*(1-r)) * j(2*(n-1))
}

# formula for calculating the correlation coefficient:
# but that would require the sd of change scores, which is typically not
# available (and this cannot be replaced by a difference of post and pre
# standard deviation)
# also the formula as documented in MA Tab S3 contains an error, because the
# denominator says (SDpre - SDpre) which is zero
# this error reduced the formula to r = (SDpre^2*SDpost^2)/(2*SDpre^2*SDpost^2)
# which reduced to r = 0.5
# therefore (probably without knowing) the authors have imputed r = 0.5 for
# every change score SD

mean_am_d <- mean_am_post - mean_am_pre
sd_am_d <- r_to_sdd(sd_am_pre, sd_am_post, 0.5)
es_am <- d_rm(mean_am_d, sd_am_d, 12, 0.5)
es_am
# perfect match for morning (AM) within group SMD point estimate

# now test the variance 
# formula for calculating the variance
get_v <- function(g, n) {
  # further error in the df calculation
  ((n+n-1)/(n+n-3))*(2/n)*(1+((g^2)/8))
}

var_am <- get_v(es_am, 12)
am <- list(es = es_am, var = var_am)
am |> get_ci()
# perfect match for am within group SMD

# try the same for the pm
# here it is only unclear which data should be used (16:00 or 20:00), 
# because the MA states that when multiple time points were available, the one
# nearest to 18:00 was used, but both are equally near

# 16:00
# mean_pm_pre <- 110.8
# sd_pm_pre <- 11.2
# mean_pm_post <- 106.6
# sd_pm_post <- 10.1

# 20:00
mean_pm_pre <- 115.2
sd_pm_pre <- 7.6
mean_pm_post <- 111.3
sd_pm_post <- 7.0

mean_pm_d <- mean_pm_post - mean_pm_pre
sd_pm_d <- r_to_sdd(sd_pm_pre, sd_pm_post, 0.5)
es_pm <- d_rm(mean_pm_d, sd_pm_d, 12, 0.5)
es_pm
# perfect match for evening (PM) within group SMD point estimate
# by try-and-error I found out that 20:00 was the measurement point used

# calculate variance
var_pm <- get_v(es_pm, 12)
pm <- list(es = es_pm, var = var_pm)
pm |> get_ci()
# perfect match for pm within group SMD

# now to the between group comparison
# use standard independent group SMD for point estimate
btwn <- smd(am$es, pm$es, sd_am_d, sd_pm_d, 12, 12)
btwn
# match for between group ES point estimate
# calculate variance
btwn$var <- get_v(btwn$es, 12)
btwn |> get_ci()
# perfect match for ES with CI!

# So there is a lot going on here:
# 1. the formula for calculating the pre-post correlation is not just
# incorrectly applied but also contains an error, with the result that a
# correlation of r = 0.5 is always imputed
# 2. the variance formula (which is inappropriate for the within group design)
# also has an error in the calculation of the degrees of freedom, as has the 
# Hedges' correction factor
# 3. The standardization procedure of the between group ES standardizes already
# standardized SMDs by raw score SDs, which will almost always leads to
# extremely small ES (but large CIs)
# 4. The between group ES does not take the crossover design into account but
# treats the am and pm groups as independent (loss of power)
## Script for the meta-pre-post project
## Script #5.1: Example Case - Reproduction
## written by Simon Nolte in 08/2025

# Reproducing the meta-analysis from Oliveira et al. (Fig1)

# load packages
library(meta)

# load data
o <- read.csv("data/example/original.csv")  # original data from the forest plot
ex <- read.csv("data/example/extracted.csv") # extracted data from the original studies

# run random effects meta-analysis with the forest plot data
m <- meta::metacont(
  n.e, mean.e, sd.e, n.c, mean.c, sd.c, data = o,
  studlab = paste0(name, " et al. (",year, ")", group),
  sm = "SMD", random = TRUE
)

# save forest plot
png(file = "plots/example/reproduction.png", bg = "white", width = 9.5, height = 4.5, units = "in", res = 300)
forest(
  m, 
  digits.mean = 1, digits.sd = 1, 
  common = FALSE, test.overall = TRUE
)
dev.off()

# the plot matches exactly the published forest plot

# try to get the same results using the data extracted from the original studies
# the key here is the calculation of the SD of the studies that is presented in
# the forest plot. Because I tried but it didn't match any typical imputation 
# methods. After contacting the lead author, who was extremely friendly and 
# helpful, I could figure out what was going on:

# Oliveira first performed a unpaired comparison of means of pre vs. post data
# based on a z-distribution (they said a meta-analysis pre vs. post, which is
# actually the same.) They then used the confidence width by the resulting mean
# difference to recalculate the standard deviation of change scores based on
# the formula for a paired t-test

# in formula:
# ci_width = z * sqrt((s_pre^2+s_post^2)/n)
# ci_width = t[df = n-1] * s_d/(n-1)

# solving for s_d results in:
# s_d = sqrt(s_pre^2-s_post^2) * z / t[df = n-1]

# (this procedure is statistically incorrect)

# first calculate missing data
# missing post means
pmm <- is.na(ex$mean_post)
ex$mean_post[pmm] <- ex$mean_pre[pmm] * (1 + 0.01 * ex$mean_dper[pmm])
# missing post sd (assume same sd as pre)
pms <- is.na(ex$sd_post)
ex$sd_post[pms] <- ex$sd_pre[pms]

# calculate the SD for each group following the above procedure
ex$sd_repro <- qnorm(0.975) * sqrt(ex$sd_pre^2+ex$sd_post^2) / qt(0.975, ex$n - 1)

# calculate mean change
ex$mean_change <- ex$mean_post - ex$mean_pre

# copy Stöggl intervention group
ex <- rbind(ex, ex[4,], ex[4,])
ex$group[c(4, 25, 26)] <- c("a", "b", "c")

w <- tidyr::pivot_wider(ex, id_cols = c(name, year, group), names_from = "group_type", values_from = c(mean_change, sd_repro, n))

# run random effects meta-analysis with the re-extracted
m_re <- metacont(
  n_int, mean_change_int, sd_repro_int, n_con, mean_change_con, sd_repro_con, data = w,
  studlab = paste0(name, " et al. (",year, ")", group),
  sm = "SMD", random = TRUE
)

# save forest plot
png(file = "plots/example/reproduction_reextract.png", bg = "white", width = 9.5, height = 4.5, units = "in", res = 300)
forest(
  m_re, sortvar = -TE, 
  digits.mean = 1, digits.sd = 1, 
  common = FALSE, test.overall = TRUE
)
dev.off()

# these are the differences between the original and the reproduced forest plot:

# Hebisz & Hebisz 2021b control sd change:
# re-extracted: 11.7, original forest plot: 7.2
qnorm(0.975) * sqrt(8.4^2+10.1^2) / qt(0.975, 12 - 1)
# -> probably data extraction error

# Filipas et al. 2022 different means and sd
# -> possibly extracted from plot instead of calculated using percentage change

# Treff et al. 2017 different n
# (since n is required for the calculation of sd, this also impacts sd)
# re-extracted: 6/6, original forest plot: 7/7 (INT/CON) 
# -> data extraction error, see Table 4 of the study
# -> n was 7 for completed intervention, but only 6 for VO2max measurements

# apart from these data extraction errors, all values match (with small rounding 
# errors for the SMD, probably because rounded values were used in the original
# analysis as input to the SMD calculation)

# Correcting the data extraction errors yields a similar MA result as the 
# original one:

# pooled SMD (published): 0.24 [0.01, 0.48]
# pooled SMD (reproduced, extraction corrected): 0.25 [0.01, 0.49]

# but remember that the calculation procedure for the SD is incorrect
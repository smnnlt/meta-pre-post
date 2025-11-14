# Recalculation for MA #062 (Llanos-Lagos)

library(metapp)
library(readxl)

# The authors provided raw data, but not the individual study effect sizes
# But the raw data was provided together with another study of the same first 
# author (#086) and it is reasonable to assume that the same effect size 
# calculation method was used.

# Yet this is challenging to verify without any individual effect sizes 
# presented. I therefore try to recalculate the full MA with the smallest number
# of studies (Sprint, Fig 5)

# MA to recalculate: Sprint, Fig 5
# target ES (see Results section): -0.493 [-1.057, 0.070]

# read raw data
d <- read_excel("notes/062/Raw Data__Llanos-Lagos.xlsx", sheet = "Sprint") |> as.data.frame()
o <- smd(d[,4]-d[,2], d[,9]-d[,7], d[,5], d[,10], d[,6], d[,11], vartype = 2)

# different effect directions as indicated in the raw data
o$es[c(1,2)] <- -1 * o$es[c(1,2)]

metafor::rma(yi = o$es, vi = o$var, method = "REML", test = "t")
# perfect match for pooled point ES and CI

# To be comparable to the recalculation process of the other meta-analyses,
# I will also re-extract the data from one study to see if it matches the 
# provided raw data.

# Selected by the random number generator on the project website:
# Paavolainen et al. (1999)

# using data from Tab 4 (V_20m)
# matches the provided raw data





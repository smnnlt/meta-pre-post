# Recalculation of MA #055 (Konrad)

library(metapp)

# Study to recalculate: Sermaxhaj et al. 2021
# target ES: -0.295 [x.xx, x.xx]

# MA Tab 1 says that static sit-and-reach was the outcome
# Forest plot says that a combined measure was used
# since the study tested 3 age groups, maybe the combined effects for each 
# subgroup for the sit-and-reach measure were used

# maybe I'll try the next one first, because this could be challenging
# Aquino et al. 2010
# target ES: -0.258 []

# to me it is totally unclear which values should be used for the recalculation

# try next: Mayorga-Vega et al. (2014)
# target ES: -0.240

# try difference of mean changes maybe standardized by pre sd
((18.64-17.05)-(14.57-14.17))/sd_pooled(4.2, 5.64, 23, 22)
# works for ES

# total group sds do not work
((18.64-17.05)-(14.57-14.17))/5.11
((18.64-17.05)-(14.57-14.17))/5.33

# an older MA by the same MA authors using partly the same data shows not only
# the ES point estimates but as z-values. These can be used to recalculate
# the var of the ES estimate. Fig 3 of Konrad et al. 2024 J Sport Health Sci
# gives for Mayorga-Vega 2014:
# z = -0.810

# as z = ES / SE
se <- -0.240 / - 0.810
var <- se^2
m <- metapp::smd(18.64-17.05, 14.57-14.17, 5.64, 4.2, 22, 23)
round(m$es, 2) / sqrt(m$var)
# not exactly

# try for the next ES if standardization by pre sd is actually correct
# I use the next ES that does not use a "combined" measure as indicated in the
# forest plot. This is: Barbosa et al. (2018)
((142.26-138.06)-(138.76-139.33))/sd_pooled(11.24, 8.02, 15, 15)
(140.18-138.06)/11.24

# still unclear I tried different things but could not get a match

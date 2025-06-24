# Recalculation of MA #117 (Florence)

library(metapp)

# Study to recalculate: Bolam et al. 2015
# target ES: 0.68 [-1.94, 3.29]

# using data from Fig. 2 femoral neck
# extracted with WebPlotDigitizer

mean_high <- 0.10
mean_low <- -0.89
mean_con <- -0.58
# use both ends of the error bars to increase the precision of the se estimate
se_high <- ((1.00 - mean_high) + (mean_high - (-0.78))) / 2
se_low <- ((0.19 - mean_low) + (mean_low - (-1.97))) / 2
se_con <- ((0.39 - mean_con) + (mean_con - (-1.59))) / 2

# calculate sd from se
sd_high <- se_high * sqrt(10)
sd_low <- se_low * sqrt(13)
sd_con <- se_con * sqrt(13)

# means and sd are not far away from the data given in the MA forest plot

# more matching data is not possible because of the data extraction procedure
# use the data given in the forest plot to recalculate the MD:
md(0.115, -0.56, 2.8, 3.61, 10, 13) |> get_ci()
# perfect match

# maybe check if another study has not given the percentage change with a
# measure of its variance or se to see if any correlation imputation was used:

# at least the next three studies all report change score sd, se or p-values for
# paired t-tests

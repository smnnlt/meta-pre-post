# Recalculation of MA #152 (Boyd)

library(metapp)

# Study to recalculate: Chen et al. 2012 (90 ISO)
# target ES: -1.21 [-2.05, -0.37]
# forest plot shows CK at 24h

# probably Fig 4A (CK, 24h) contains the relevant data,
# but I do not know how one should extract reliable data from this 

# next study: Huang et al. 2019
# target ES: -0.94 [-1.78, -0.10]

# use data extracted from Fig 3A
smd(1917, 60, 4599-1917, 4599-1917, 12, 12) |> get_ci()
# no match

# try next study instead: Lavender & Nosaka 2008
# target ES: -1.40 [-2.46, -0.34]

# I do not think it is possible to reliably extract data from Fig 4 day 1

# Another try: Maeo et al. (2017) [PRE DW]
# target ES: -1.01 [-1.87, -0.15]

# I searcher some more studies to identify one that shows data in a table not
# only in a plot. I found the following:
# Nosaka et al. (2005)
# target ES: -2.09 [-3.17, -1.01]

# using data from Tab 1 (CK, L Group = CON vs S Group = INT, INT 2nd bout, CON 1st bout)
# sample size taken from Methods/Abstract
# note that the study presents data as SE (not SD), but we ignore this here:
smd(299, 599, 86, 175, 11, 11, vartype = 3) |> get_ci() # Revman var estimator
# perfect match (but SE/SD mixup)

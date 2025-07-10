# Recalculation of MA #152 (Boyd)

library(metapp)

# Study to recalculate: Chen et al. 2012 (90 ISO)
# target ES: -1.21 [-2.05, -0.37]

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

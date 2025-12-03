# Recalculation of MA #001 (Cove)

library(metapp)

# Study to recalculate: Almquist et al. 2022
# target ES: 0.24 [-0.5, 0.98] (Suppl Fig 1)

# FIRST: Try to re-extract the VO2max data from Almquist

# combine Tab 1 data from Almquist for TP
tp = pool_groups(x1 = 59.4, x2 = 51.9,sd1 = 17.3,sd2 = 5.7,n1 = 14,n2 = 2)
tp
# x = 58.5, sd = 16.4
# values from MA Tab 1 for pre: 59.3 +/-8.1 

# extract pre values from Fig 2d of Alquist
pre <- read.csv2("notes/001/trad_pre.csv", header = FALSE, col.names = c("x", "y"))
mean(pre$y)
sd(pre$y)
# not exactly but quite near. Note that these values to absolutely not match Tab
# 1 of Almquist. Also the n is different here (15 instead of 14)

# Also data extraction certainly does not give the correct results for the BLOCK
# group. So it remains unclear where the values in the MA Tab 1 come from. They
# neither match Tab 1 nor Fig2D of Almquist (which are different by the way)

# SECOND: Recalculate the ES

# I try the values given in MA Tab 1 first (note these may be incorrectly extracted)
sd_change <- r_to_sdd(8.1, 7.3, 0.5)
((61.2 - 59.3) / sd_change)
# simple change score: not exact (only estimate not variance)

((61.2 - 59.3) / sd_change) * j(12)
# with Hedges correction also not exact

# standard SMD treating repeated measures as independent (ignoring pre-post correlation)
smd(x1 = 61.2, x2 = 59.3, sd1 = 7.3, sd2 = 8.1, n1 = 14, n2 = 14) |> get_ci()
# perfectly works, successful reproduction but using methods very different to 
# those described (and also based on incorrectly extracted data)
# I also check this for the second group

# I try another study, the next from Table 1:
# Creer et al. 2004
# target ES: 0.20 [-0.85, 1.25] (CON)
# target ES: 0.78 [-0.13, 1.63] (INT)

# in the results section, the study only says that overall VO2max increase was
# from 4.0±0.4 to 4.2±0.4. The MA attributes this to the INT group. The original
# study says in the methods that baseline VO2max was 3.9±0.3 for INT and 4.1±0.5
# for CON, so the MA used the pre values for CON pre and the overall post for
# CON post

# using data from MA Tab 1
smd(4.1, 4.0, 0.5, 0.4, 7, 7) |> get_ci()
# CON matches (with rounding errors)
smd(4.2, 4.0, 0.4, 0.4, 10, 10) |> get_ci()
# INT far off
# maybe use reported pre VO2max instead (deviating from MA Tab 1)
smd(4.2, 3.9, 0.4, 0.3, 10, 10) |> get_ci()
# somewhat near

# try next: Hebisz & Hebisz
# small data extraction error (sd post INT is 5.6 in original study, 5.3 in MA)
# target ES: 0.64 [-0.18, 1.46] (INT)
# target ES: 0.16 [-0.64, 0.97]

# the error appears to be in Tab 1 only, not in the raw data, because
smd(66.3, 62.3, 5.6, 6.4, 12, 12) |> get_ci()
# perfect match
smd(61.2, 59.6, 10.1, 8.4, 12, 12) |> get_ci()
# match (rounding error for point ES off by 0.01)

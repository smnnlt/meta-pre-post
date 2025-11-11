# Recalculation for MA #039 (Müller)

library(metapp)

# Study to recalculate: Gorman & Ferron 2009
# target ES (as extracted by Digitalizer): 0.42 [-0.44; 1.29]

# extracted are these values:
# con: 56.3, 63.2 (delta therefore: 7.9)
# int: 54.4, 67.5 (delta therefore: 13.1)

# which nearly match the ones in the text:
# increase con: 8.0
# increase int: 13.4

# but if we take this values and a (probably over-) estimated sd of 10
# (though the text states an pre sd of 17.5 over all groups, but first the means
# in the text appear to be incorrect, and second the overall sd does not help
# for getting group sds)
# we get this as Cohen's d:
smd(13.4, 8.0, 10, 10, 10, 10, hedges = FALSE) |> get_ci()
smd(13.4, 8.0, 10, 10, 10, 10) |> get_ci()
# quite near, but impossible to say whether the remaining differences are due to
# extraction problems or differing calculations

# not possible to recalculate: take the next: Smeeton et al.
# also not possible, because it uses two outcomes and it is unclear how they were combined

# so take the next: Gabbett et al. 2007
# target ES (as extracted by Digitalizer): 0.82 [-0.15; 1.80]

# extract data from Fig3a (but maybe also b would be the correct panel?)

# int mean: 52.0, 60.0
# con mean: 50.4, 51.2

# error bar at 54.7 giving the SE (!) of int
se_int_pre <- 54.7 - 52
sd_int_pre <- se_int_pre * sqrt(9) # sd based on n = 9

# if we just quickly use this sd for a calculation
((60-52)-(51.2-50.4))/sd_int_pre

# we get somewhere near the ES. But it is not possible to determine the 
# SE for other parameters

# so let's go on to the next try: Murgia et al. 2014
# target ES (as extracted by Digitalizer): 1.04 [0.22; 1.86]

# int mean: 56.4, 60.7
# con mean: 56.9 57.1

# error bar int pre is at 57.6
# error bar con pre is at 58
# error bars depict SE
se_int_pre <- 57.6 - 56.4
se_con_pre <- 58 - 56.9
sd_int_pre <- se_int_pre * sqrt(13) # using n = 13
sd_con_pre <- se_con_pre * sqrt(12) # using n = 12
smd(60.7-56.4, 57.1-56.9, sd_int_pre, sd_con_pre, 13, 12, hedges = FALSE) |> get_ci()
# or hedges g
smd(60.7-56.4, 57.1-56.9, sd_int_pre, sd_con_pre, 13, 12) |> get_ci()
# cohen's d fits better
# this is quite near, but impossible to know if procedure is exact due to
# extraction procedure

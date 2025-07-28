#MA Tomschi 

#target parameter
library(metapp)
# Study to recalculate: #Hviid, 2019b
# target ES: -3.90 [-8.04; 0.24]

#values from MA, try with Mean Difference: 
md(0.5, 4.4, 8.1, 9.5, 35, 35) |> get_ci()

#yes, but where can I find the values in the study? 

#note: they have to be converted from kPA to N/cm2 
n <- 35
#local = Quad Group 
#2019,b = Session 2 (I suppose)

#control group value, session 2: (Suppl. Tab 2) 
#this is not the baseline value of control group as stated in MA, it is Mean Difference of after rest- before rest

x1 <-  4.4
sd1 <- 8.8 

#mean difference of baseline and after walking in session 2: ( Tab 1 )

x2 <- 0.4
sd2 <- 7.8

md(0.4,4.4,7.8, 8.8, 35, 35) |> get_ci()

# ES = -4, [-7.89; 0.10]




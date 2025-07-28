#Recalculation of Brown et al. 2014 - SL Landing 
#SingleLeg Drop Vertical Jump  
#Hip Flexion Angle 
#data from MA 
#1 = intervention group 
x1 <- 37.8
# sd1 <- 12.4
n1 <- 13
#2 = control group 
x2 <- 37.9
# sd2 <- 10.8
n2 <- 16

# MD from Meta Analysis: 
# -0.1 [-8.6; 8.4]
# MA: post scores 
# SE  in study to SD 
sd1 <- 3.0 * sqrt(n1) 
sd2 <- 3.1 * sqrt(n2)  

library(metapp)

md(x1,x2,sd1,sd2,n1,n2, var_homo = FALSE)|> get_ci()
#Yes! 



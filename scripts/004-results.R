## Script for the meta-pre-post project
## Script #4: Extraction Results
## written by Simon Nolte in 01/2026, modified in 03/2026

## --------------- PART 1: Data import and study exclusion ---------------------

# read extraction data
d <- read.csv("data/extraction.csv")

# count number of excluded studies
sum(d$status == "exclude")
#> 5

# remove excluded studies
d <- d[d$status != "exclude",]

# count remaining studies
nrow(d)
#> 101

##-------------------- PART 2: Calculation methods -----------------------------

# count number of studies the calculation method could be determined for
clear <- sum(d$status != "unclear")
clear
#> 90
clear / nrow(d) # proportion
#> 0.89

unc <- sum(d$status == "unclear")
unc
#> 11
unc / nrow(d)
#> 0.11
# reason for non-determination
table(d$status_explanation[d$status == "unclear"])
#> n = 6: no effect sizes available
#> n = 5: procedure unclear

# calculation methods (change/post/ANCOVA)
table(d$recalc_calctype)
#> change score: n = 64
#> post-measures: n = 28
#> unclear/NULL: 9

# percentage values (denominator: all studies with methods determined)
prop.table(table(d$recalc_calctype[!d$recalc_calctype %in% c("NULL", "unclear")]))
#> change score: 0.70
#> post-measures: 0.30
binom::binom.confint(64, 92, methods = "agresti-coull")
#> [0.60, 0.78]
binom::binom.confint(28, 92, methods = "agresti-coull")
#> [0.22, 0.40]

# SMD or MD (we do not have this as a direct field and use hedges=YY instead, 
# because hedges=NA implies MD)
table(d$hedges, useNA = "always")
#> SMD (hedges=TRUE + hedges=FALSE): 72
#> MD (hedges=NA): 20
# proportions (denominator: all studies with methods determined)
prop.table(table(d$hedges[d$hedges != "unclear"], useNA = "always"))
#> SMD: 78%
#> MD: 22%
binom::binom.confint(72, 92, methods = "agresti-coull")
binom::binom.confint(20, 92, methods = "agresti-coull")

# used Hedges?
table(d$hedges)
#> 58
prop.table(table(d$hedges[d$hedges != "unclear"]))
binom::binom.confint(58, 72, methods = "agresti-coull")

# standardizer (only for change-score based SMD)
changesmd <- d[d$recalc_calctype == "change score" & d$hedges != "unclear",]
table(changesmd$standardizer)
#> change: 30
prop.table(table(changesmd$standardizer))
#> change: 0.59
binom::binom.confint(30, 51, methods = "agresti-coull")

# unique number of calculation methods
# without imputation
meth <- d$calcmethod_code[d$calcmethod_code != "unclear"]
length(unique(meth))
#> 34
# with imputation
meth_wimpute <- paste0(meth, d$recalc_imputemethod_result[d$calcmethod_code != "unclear"])
length(unique(meth_wimpute))

# imputation procedures
# no. using correlation
dimp <- d$recalc_imputemethod_result[d$recalc_imputemethod_result != "na" & d$status != "unclear"]
length(dimp) 
#> 48
length(dimp)/nrow(d[d$status != "unclear",])
#> 0.53
binom::binom.confint(48, 90, methods = "agresti-coull")
# imputation parameters used
table(dimp)
#> 0.5: 21
#> 0.7: 11
prop.table(table(dimp[dimp != "unclear"]))
#> 0.5: 0.46
#> 0.7: 0.24
binom::binom.confint(21, 48, methods = "agresti-coull")
binom::binom.confint(11, 48, methods = "agresti-coull")

##-------------------------- PART 3: Issues found ------------------------------

# create combined issue variable
d$issues <- paste(d$error_extraction, d$error_calculation, d$error_reporting, sep = "-")
table(d$issues)
#> unclear-unclear-unclear: 11 (will be excluded)
#> none-none-none: 39
# major issues: 
sum(grepl("major", d$issues))
#> 27
# none-none-none
39 / 101

# breakdown of issues (for S6):
table(d$error_extraction)
dee <- d[d$error_extraction_note != "", c(29,30)]
table(d$error_calculation)
dec <- d[d$error_calculation_note != "", c(31,32)]
table(d$error_reporting)
der <- d[d$error_reporting_note != "", c(33,34)]

##-------------------------- PART 4: Reporting ---------------------------------
# provided effect size type
table(d$read_calctype)
#> unclear/unreported: 32
#> change score/post-measures: 69
prop.table(table(d$read_calctype))
#> clear: 0.68
binom::binom.confint(69, 101, methods = "agresti-coull")

# justification for calculation procedure
sum(d$justification != "none")
#> 62
sum(d$justification != "none") / nrow(d)
binom::binom.confint(62, 101, methods = "agresti-coull")

# reported whether SMD had Hedges' correction
table(d$report_hedges, useNA = "always")
prop.table(table(d$report_hedges))
binom::binom.confint(41, 82, methods = "agresti-coull")
#> 0.50 [0.39, 0.61]

# reporting of correlation imputation
table(d$report_imputation, useNA = "always")
prop.table(table(d$report_imputation))
binom::binom.confint(31, 83, methods = "agresti-coull")
#> 0.37 [0.28, 0.48]

# reporting of variance estimator
table(d$report_varestimator, useNA = "always")
prop.table(table(d$report_varestimator))
binom::binom.confint(9, 101, methods = "agresti-coull")
#> 0.09 [0.05, 0.16]

# reporting judgement
table(d$reporting)
#> complete: 23
prop.table(table(d$reporting[d$status != "unclear"]))
#> complete: 0.25
binom::binom.confint(23, 91, methods = "agresti-coull")

# incorrect reporting
table(d$error_reporting)
prop.table(table(d$error_reporting[d$error_reporting != "unclear"]))
binom::binom.confint(14, 91, methods = "agresti-coull")

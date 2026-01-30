## Script for the meta-pre-post project
## Script #4: Extraction Results
## written by Simon Nolte in 01/2026

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
#> 91
clear / nrow(d) # proportion
#> 0.90

unc <- sum(d$status == "unclear")
unc
#> 10
unc / nrow(d)
#> 0.10
# reason for non-determination
table(d$status_explanation[d$status == "unclear"])
#> n = 5: no effect sizes available
#> n = 5: procedure unclear

# calculation methods (change/post/ANCOVA)
table(d$recalc_calctype)
#> change score: n = 64
#> post-measures: n = 29
#> unclear/NULL: 8

# percentage values (denominator: all studies with methods determined)
prop.table(table(d$recalc_calctype[!d$recalc_calctype %in% c("NULL", "unclear")]))
#> change score: 0.69
#> post-measures: 0.31
binom::binom.confint(64, 93, methods = "agresti-coull")
#> [0.59, 0.77]
binom::binom.confint(29, 93, methods = "agresti-coull")
#> [0.23, 0.41]

# SMD or MD (we do not have this as a direct field and use hedges=YY instead, 
# because hedges=NA implies MD)
table(d$hedges, useNA = "always")
#> SMD (hedges=TRUE + hedges=FALSE): 72
#> MD (hedges=NA): 21
# proportions (denominator: all studies with methods determined)
prop.table(table(d$hedges[d$hedges != "unclear"], useNA = "always"))
#> SMD: 77%
#> MD: 23%
binom::binom.confint(72, 93, methods = "agresti-coull")
binom::binom.confint(21, 93, methods = "agresti-coull")

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

# variance estimators used
table(d$varestimator)
prop.table(table(d$varestimator[d$status != "unclear"]))

##-------------------------- PART 3: Issues found ------------------------------

# create combined issue variable
d$issues <- paste(d$error_extraction, d$error_calculation, d$error_reporting, sep = "-")
table(d$issues)
#> unclear-unclear-unclear: 11 (will be excluded)
#> none-none-none: 41
# major issues: 
sum(grepl("major", d$issues))
#> 27
# none-none-none
41 / 101

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

# reporting judgement
table(d$reporting)
#> complete: 22
prop.table(table(d$reporting[d$status != "unclear"]))
#> complete: 0.25
binom::binom.confint(22, 90, methods = "agresti-coull")

# incorrect reporting
table(d$error_reporting)
prop.table(table(d$error_reporting[d$error_reporting != "unclear"]))
binom::binom.confint(14, 90, methods = "agresti-coull")

## Script for the meta-pre-post project
## Script #3: Extraction Agreement
## written by Simon Nolte in 07/2025 and 01/2026

# This script organizes and analyzes the parallel extraction procedure

#------------------------------------------------------------------------------
# PART 1: Study Selection

# Regarding parallel extraction, the preregistration states: "We perform a
# validation stage to check for potential issues in the data extraction process.
# On a subset of the first 20 studies of data extraction, we perform an
# additional test of extraction reliability by having two independent
# researchers perform the data extraction (instead of one extractor and one
# validator). The two extractors will resolve conflicts by discussion."

# At this stage of the project (23-07-2025) all studies have been extracted once
# with a few studies already validated. 

# Based on the preregistration, the first 20 studies would need to be 
# extracted in parallel for the reliability determination. But a better
# procedure would be to randomly choose 20 studies. A totally random
# selection is not useful because (1) some studies already have validation
# entries, so we will not use them for parallel extraction, (2) to limit the
# burden to co-authors and ensure to accurately capture the reliability of the
# persons who performed the most extraction, every study will be extracted at
# least once by the primary investigator (SN). This mean that all studies not
# extracted by SN will be subject to the parallel extraction.

# Therefore, we will choose the following studies for the parallel extraction:
# - All studies that have not been extracted by SN so far.#
# - Plus a random subset of all studies extracted by SN that have not received a
# validation so far (until a final number of 20 parallel extractions is 
# reached)

# import current extraction data
e <- read.csv("backup/extraction-23-07-25.csv")
# import current validation data
i <- read.csv("backup/validation-23-07-25.csv")

# show number of extractions per user
table(e$extract_user)

# select ids of extraction performed by other user than SN
ids <- e$study_id[e$extract_user != "SN"]
ids
#> 2, 18, 56, 95, 96, 101, 109, 126
# number of extractions not performed by SN
length(ids)
#> 8 

# get the study IDs that may be used for the parallel extraction
e_SN <- e[e$extract_user == "SN",]
pool <- e_SN$study_id[!e_SN$study_id %in% i$study_id]

# randomly select the needed number of studies from this pool:
set.seed(4711)
sam <- sample(pool, 20 - length(ids), replace = FALSE)

p_ids <- c(ids, sam)
# these are the final study IDs used for the parallel extraction:
sort(p_ids)
#> 2, 18, 36, 40, 51, 56, 90, 92, 95, 96, 101, 109, 120, 126, 134, 136, 140,
#> 158, 180, 183

# The data validations of these will be marked as "Study selected for parallel 
# extraction. No validation needed."

#-----------------------------------------------------------------------------
# PART 2: Agreement Analysis

# import results from parallel extraction
db <- read.csv("data/double.csv")
db$code <- rep.int(c(1,2), 20)

# restructure data to one study per row
dbr <- tidyr::pivot_wider(db, id_cols = study_id, names_from = code, values_from = -study_id)

# compare extracted data for reporting
a_read <- sum(dbr$read_calctype_1 == dbr$read_calctype_2)
# compare extracted data for recalculation
a_calc <- sum(dbr$recalc_calctype_1 == dbr$recalc_calctype_2)

# agreement rate
(a_read + a_calc) / (nrow(dbr) * 2)
#> 0.6

# Data files and variable descriptions**

This file lists the column names (variables) present in the CSV files in this folder and short notes about their meaning.


## `double.csv`: Double Extraction 
Uses a subset of the columns used in `extraction.csv` with two rows per study (one per extracting researcher per study). The only additional column is:
- **id**: Row identifier (double extraction id, only for internal handling)

## `extraction.csv`: Extracted Data (Main data file) 
### Study Information
- **study_id**: Study identifier (links to `studies.csv`)
- **extraction_id**: Extraction record identifier
- **is_double**: Indicator whether extraction was double-coded ("TRUE" or "FALSE")
- **status**: Extraction status ("exclude", "unclear", or empty if included)
- **status_explanation**: Explanation for status if excluded
### Reporting Extraction
- **read_calctype**: Reported calculation type ("change score", "post-measures", "ANCOVA", "unclear", or "unreported"). For the analysis the categories "unclear" and "unreported" are treated as one category
- **read_ancovasource**: Reported type of ANCOVA (if applicable)
- **read_calcmethod**: Reported exact calculation method (text field)
- **read_imputemethod**: Reported imputation method for the pre-post correlation (text field)
- **justification**: Reported justification for the selected effect size (text field)
- **imbalance**: Reported dealing with baseline imbalances (text field)
- **read_comments**: Extraction comments (text field)
### Recalculation
- **recalc_study**: Which original study was used for recalculating an effect size (text field)
- **recalc_calctype**: Recalculated calculation type ("change score", "post-measures", "ANCOVA", "unclear", or "NULL" if study was excluded)
- **recalc_ancovasource**: Recalculated ANCOVA type (if applicable)
- **recalc_calcmethod**: Recalculated exact calculation method (text field)
- **recalc_imputemethod**: Recalculated imputation method for the pre-post correlation (text field)
- **recalc_comments**: Recalculation comments (text field)
- **extract_user**: Initials of researcher who performed extraction (two names for double extractions)
- **submitted_date**: Submission date/time
- **last_updated**: Last updated date/time
- **is_draft**: Draft flag (was only relevant for internal handling during the extraction process)
### Standardized Recalculation Results
- **recalc_imputemethod_result**: Imputed pre-post correlation coefficient as a numeric value ("unclear" if unclear, "na" if no imputation applicable)
- **calcmethod_code**: Code for unqiue calculation methods ("unclear" if unclear)
- **hedges**: Whether Hedges' g was used ("TRUE", "FALSE", "NA", or "unclear")
- **standardizer**: Standardizer used for effect sizes ("pre", "change", "post", or a few other options, "unclear" if unclear)
- **varestimator**: Variance estimator used (as text code, "unclear" if unclear)
### Standardized Reporting Results
- **report_imputation**: Whether imputation was reported ("TRUE", "FALSE", or "NA")
- **report_hedges**: Whether Hedges' g was reported ("TRUE", "FALSE", or "NA")
- **report_standardizer**: Whether standardizer was reported ("TRUE", "FALSE", or "NA")
- **report_varestimator**: Whether variance estimator was reported ("TRUE" or "FALSE")
- **reporting**: Overall reporting assessment ("complete", "incomplete", "missing", or "incorrect")
### Standardized Error Classification
- **error_extraction**: Flag for primary data extraction error ("none", "minor", "major", or "unclear")
- **error_extraction_note**: Description of primary data extraction error (text field)
- **error_calculation**: Flag for effect size calculation error ("none", "minor", "major", or "unclear")
- **error_calculation_note**: Description of effect size calculation error (text field)
- **error_reporting**: Flag for reporting error ("none", "minor", "major", or "unclear")
- **error_reporting_note**: Description of reporting error (text field)
- **further_observation**: Additional observations (text field)

## `reviews.csv`: Study Inclusion/Exclusion reviews 
One line per review
- **id**: Review identifier
- **study_id**: Study identifier (links to `studies.csv`)
- **user**: Initials of reviewing researcher
- **comments**: Free-text comments by reviewer
- **submitted_date**: Submission date/time
- **last_updated**: Last updated date/time
- **type**: Review type ("abstract" or "fulltext")
- **exclusion_reason**: Reason for exclusion ("No group comparison", "No pre-post design", "No exercise intervention", or "NULL" if included)
- **exclusion**: Exclusion flag (1: exclude, 0: include)

## `studies.csv`: Overview of Studies Included in the Study Filtering 
- **id**: Study identifier (primary key)
- **doi**: DOI string of the study
- **title**: Study title
- **abstract**: Study abstract text
- **name**: First author name
- **journal**: Journal name

## Additional data sets related to the example reanalysis as part of the project

###  `example/extracted.csv`: Re-extracted data from original studies
- **name**: Study name (first author)
- **year**: Year of study
- **group**: Group label
- **group_type**: Type of group ("con" or "int")
- **group_name**: Descriptive group name
- **n**: Sample size for the group
- **mean_pre**: Pre-intervention mean
- **sd_pre**: Pre-intervention standard deviation
- **mean_post**: Post-intervention mean
- **sd_post**: Post-intervention standard deviation
- **mean_d**: Mean difference
- **sd_d**: Standard deviation of difference
- **mean_dper**: Mean difference in percent
- **sd_dper**: SD of percent difference
- **cohens_d**: Cohen's d effect size
- **p**: p-value
- **ci_low**: Lower bound of confidence interval
- **ci_up**: Upper bound of confidence interval
- **notes**: Free-text notes

### `example/original.csv`: Original published MA data

- **name**: Study name (first author)
- **year**: Year of study
- **group**: Group label
- **short**: Whether this was categorized as a short intervention ("TRUE" or "FALSE)
- **trained**: Whether the group was considered as trained athletes ("TRUE" or "FALSE)
- **n.e**: Sample size for experimental group
- **mean.e**: Mean for experimental group
- **sd.e**: Standard deviation for experimental group
- **n.c**: Sample size for control group
- **mean.c**: Mean for control group
- **sd.c**: Standard deviation for control group

### Extracted data from Rosenblat et al. (2025, Sports Med)
`example/rosenblat.csv`: Rosenblat-style example file
- **study**: Study label
- **group**: Group label
- **n**: Sample size for the group
- **tid**: Training intensity distribution classification
- **mean_pre**: Pre-intervention mean
- **sd_pre**: Pre-intervention standard deviation
- **mean_post**: Post-intervention mean
- **sd_post**: Post-intervention standard deviation
- **mean_d**: Mean difference
- **sd_d**: SD of difference
- **mean_dper**: Mean difference in percent
- **sd_dper**: SD of percent difference
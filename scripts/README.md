# Analysis scripts

This folder contains the R scripts used for this project.

- `001-search.R`: Article search (PubMed via `rentrez`). Searches target journals and retrieves article metadata (DOI, title, abstract), writes results to the local database.

- `002-screening.R`: Screening logic. Loads `data/reviews.csv`, computes abstract/full-text screening counts, agreement, and exclusion reasons.

- `003-agreement.R`: Double extraction agreement. Selects studies for parallel extraction and computes agreement rates between extractors.

- `004-results.R`: Extraction results and summaries. Imports `data/extraction.csv`, excludes studies as needed, computes method prevalences, imputation summaries, and reporting/error tallies used to create result tables and figures.

- `005.1-example-reproduction.R`: Example reproduction. Reproduces the example meta-analysis using `data/example/original.csv` and `data/example/extracted.csv`, creates reproduction forest plots and documents discrepancies.

- `005.2-example-ipdsim.R`: IPD simulation. Simulates individual participant data (IPD) for studies without shared IPD using extracted summary data and a chosen pre-post correlation. Note that this script cannot be rerun because we are not allowed to share the IPD data.

- `005.3-example-comparison.R`: Comparison of calculation methods. Uses extracted summary data and simulated IPD to compute effect sizes with multiple methods (post, various change-score imputations, ANCOVA) and compares pooled results and plots.

- `005.4-example-correlation.R`: Correlation estimation. Computes pre-post correlations from Rosenblat et al. (2025, Sports Med) example data (`data/example/rosenblat.csv`) and plots the correlation distribution to inform imputation choices.



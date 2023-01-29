# Takes yaml files from data-raw directory and produces Rda objects in data directory

library(tidyverse)


# Define the path to the current file
here::i_am("data-raw/data-setup.R")

# Read in yaml files
biomarkerAcceptableLimits = yaml::read_yaml(here::here("data-raw/biomarker_acceptable_limits.yaml"))
biomarkerAcceptableUnits = yaml::read_yaml(here::here("data-raw/biomarker_acceptable_units.yaml"))
qMissingPredictors = yaml::read_yaml(here::here("data-raw/q_missing_predictors.yaml"))
qrisk2Constants = yaml::read_yaml(here::here("data-raw/qrisk2_constants.yaml"))
qdiabeteshfConstants = yaml::read_yaml(here::here("data-raw/qdiabeteshf_constants.yaml"))

# Output Rda files
usethis::use_data(biomarkerAcceptableLimits, overwrite = TRUE)
usethis::use_data(biomarkerAcceptableUnits, overwrite = TRUE)
usethis::use_data(qMissingPredictors, overwrite = TRUE)
usethis::use_data(qrisk2Constants, overwrite = TRUE)
usethis::use_data(qdiabeteshfConstants, overwrite = TRUE)
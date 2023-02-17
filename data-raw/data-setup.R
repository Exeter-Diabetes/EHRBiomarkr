# Takes yaml files from data-raw directory and produces rda objects in data directory

library(tidyverse)


# Define the path to the current file
here::i_am("data-raw/data-setup.R")

# Read in yaml files
biomarkerAcceptableLimits = yaml::read_yaml(here::here("data-raw/biomarker_acceptable_limits.yaml"))
biomarkerAcceptableUnits = yaml::read_yaml(here::here("data-raw/biomarker_acceptable_units.yaml"))
qMissingPredictors = yaml::read_yaml(here::here("data-raw/q_missing_predictors.yaml"))
qrisk2Constants = yaml::read_yaml(here::here("data-raw/qrisk2_constants.yaml"))
qdiabeteshfConstants = yaml::read_yaml(here::here("data-raw/qdiabeteshf_constants.yaml"))
ckdpcEgfr60RiskConstants = yaml::read_yaml(here::here("data-raw/ckdpc_egfr60_risk_constants.yaml"))
ckdpc40EgfrRiskConstants = yaml::read_yaml(here::here("data-raw/ckdpc_40egfr_risk_constants.yaml"))


# Output Rda files
usethis::use_data(biomarkerAcceptableLimits, overwrite = TRUE)
usethis::use_data(biomarkerAcceptableUnits, overwrite = TRUE)
usethis::use_data(qMissingPredictors, overwrite = TRUE)
usethis::use_data(qrisk2Constants, overwrite = TRUE)
usethis::use_data(qdiabeteshfConstants, overwrite = TRUE)
usethis::use_data(ckdpcEgfr60RiskConstants, overwrite = TRUE)
usethis::use_data(ckdpc40EgfrRiskConstants, overwrite = TRUE)

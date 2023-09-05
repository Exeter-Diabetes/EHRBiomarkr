# Setup
library(tidyverse)
library(aurum)
library(EHRBiomarkr)
#devtools::load_all()
rm(list=ls())

cprd = CPRDData$new(cprdEnv = "test-remote",cprdConf = "~/.aurum.yaml")

analysis = cprd$analysis("katie")


############################################################################################

# Test running on remote data

test_remote <- test_remote %>% analysis$cached("ckd_score_test")

## 5-year eGFR < 60 risk score

missing_acr_test1 <- test_remote %>%
  
  calculate_ckdpc_egfr60_risk(age=age_var, sex=sex_var, black_eth=black_ethnicity_var, egfr=egfr_var, cvd=cvd_var, hba1c=hba1c_var, oha=oha_var, insulin=insulin_var, ever_smoker = ever_smoker_var, hypertension=hypertension_var, acr=acr_var, bmi=bmi_var, remote=TRUE) %>%
  
  analysis$cached("ckd_score_test2")

remote_missing_acr_test1 <- collect(missing_acr_test1)


missing_acr_test2 <- test_remote %>%
  
  calculate_ckdpc_egfr60_risk(age=age_var, sex=sex_var, black_eth=black_ethnicity_var, egfr=egfr_var, cvd=cvd_var, hba1c=hba1c_var, oha=oha_var, insulin=insulin_var, ever_smoker = ever_smoker_var, hypertension=hypertension_var, acr=acr_var, bmi=bmi_var, complete_acr=FALSE, remote=TRUE) %>%
  
  analysis$cached("ckd_score_test3")

remote_missing_acr_test2 <- collect(missing_acr_test2)


complete_acr_test <- missing_acr_test1 %>%
  
  rename(missing_acr_total_score=ckdpc_egfr60_total_score, missing_acr_total_lp=ckdpc_egfr60_total_lin_predictor, missing_acr_confirmed_score=ckdpc_egfr60_confirmed_score, missing_acr_lp=ckdpc_egfr60_confirmed_lin_predictor) %>%
  
  calculate_ckdpc_egfr60_risk(age=age_var, sex=sex_var, black_eth=black_ethnicity_var, egfr=egfr_var, cvd=cvd_var, hba1c=hba1c_var, oha=oha_var, insulin=insulin_var, ever_smoker = ever_smoker_var, hypertension=hypertension_var, acr=acr_var, bmi=bmi_var, complete_acr=TRUE, remote=TRUE) %>%
  
  analysis$cached("ckd_score_test4")


## 3-year 40% decline in eGFR risk score

ckdpc40_test <- complete_acr_test %>%
  
  calculate_ckdpc_40egfr_risk(age=age_var, sex=sex_var, egfr=egfr_var, acr=acr_var, sbp=sbp_var, bp_meds=bp_meds_var, hf=hf_var, chd=chd_var, af=af_var, current_smoker=current_smoker_var, ex_smoker=ex_smoker_var, bmi=bmi_var, hba1c=hba1c_var, oha=oha_var, insulin=insulin_var, remote=TRUE) %>%
  
  analysis$cached("ckd_score_test5")


## Checking

test_remote %>% count()

test_remote %>% filter(is.na(acr_var)) %>% count()

missing_acr_test1 %>% inner_join(missing_acr_test2) %>% count()
# MySQL can't join on NULLS so these will be missing from count

remote_missing_acr_test1 %>% inner_join(remote_missing_acr_test2) %>% count()
# Should be full count


remote_all <- ckdpc40_test %>%
  collect() %>%
  mutate(missing_acr_total_score=round(missing_acr_total_score, 5),
         missing_acr_total_lp=round(missing_acr_total_lp, 5),
         missing_acr_confirmed_score=round(missing_acr_confirmed_score, 5),
         missing_acr_lp=round(missing_acr_lp, 5),
         ckdpc_egfr60_total_score=round(ckdpc_egfr60_total_score, 5),
         ckdpc_egfr60_total_lin_predictor=round(ckdpc_egfr60_total_lin_predictor, 5),
         ckdpc_egfr60_confirmed_score=round(ckdpc_egfr60_confirmed_score, 5),
         ckdpc_egfr60_confirmed_lin_predictor=round(ckdpc_egfr60_confirmed_lin_predictor, 5),
         ckdpc_40egfr_lin_predictor=round(ckdpc_40egfr_lin_predictor, 5),
         ckdpc_40egfr_score=round(ckdpc_40egfr_score, 5))
# Check values


############################################################################################

# Test running on local data

test_local <- collect(test_remote)

missing_acr_test1 <- test_local %>%
  
  calculate_ckdpc_egfr60_risk(age=age_var, sex=sex_var, black_eth=black_ethnicity_var, egfr=egfr_var, cvd=cvd_var, hba1c=hba1c_var, oha=oha_var, insulin=insulin_var, ever_smoker = ever_smoker_var, hypertension=hypertension_var, acr=acr_var, bmi=bmi_var, remote=FALSE)


missing_acr_test2 <- test_local %>%
  
  calculate_ckdpc_egfr60_risk(age=age_var, sex=sex_var, black_eth=black_ethnicity_var, egfr=egfr_var, cvd=cvd_var, hba1c=hba1c_var, oha=oha_var, insulin=insulin_var, ever_smoker = ever_smoker_var, hypertension=hypertension_var, acr=acr_var, bmi=bmi_var, complete_acr=FALSE, remote=FALSE)


complete_acr_test <- missing_acr_test1 %>%
  
  rename(missing_acr_total_score=ckdpc_egfr60_total_score, missing_acr_total_lp=ckdpc_egfr60_total_lin_predictor, missing_acr_confirmed_score=ckdpc_egfr60_confirmed_score, missing_acr_lp=ckdpc_egfr60_confirmed_lin_predictor) %>%
  
  calculate_ckdpc_egfr60_risk(age=age_var, sex=sex_var, black_eth=black_ethnicity_var, egfr=egfr_var, cvd=cvd_var, hba1c=hba1c_var, oha=oha_var, insulin=insulin_var, ever_smoker = ever_smoker_var, hypertension=hypertension_var, acr=acr_var, bmi=bmi_var, complete_acr=TRUE, remote=FALSE)


## 3-year 40% decline in eGFR risk score

ckdpc40_test <- complete_acr_test %>%
  
  calculate_ckdpc_40egfr_risk(age=age_var, sex=sex_var, egfr=egfr_var, acr=acr_var, sbp=sbp_var, bp_meds=bp_meds_var, hf=hf_var, chd=chd_var, af=af_var, current_smoker=current_smoker_var, ex_smoker=ex_smoker_var, bmi=bmi_var, hba1c=hba1c_var, oha=oha_var, insulin=insulin_var, remote=FALSE)


## Checking

test_local %>% count()

test_local %>% filter(is.na(acr_var)) %>% count()

missing_acr_test1 %>% inner_join(missing_acr_test2) %>% count()
# Should be full count


local_all <- ckdpc40_test %>%
  mutate(missing_acr_total_score=round(missing_acr_total_score, 5),
         missing_acr_total_lp=round(missing_acr_total_lp, 5),
         missing_acr_confirmed_score=round(missing_acr_confirmed_score, 5),
         missing_acr_lp=round(missing_acr_lp, 5),
         ckdpc_egfr60_total_score=round(ckdpc_egfr60_total_score, 5),
         ckdpc_egfr60_total_lin_predictor=round(ckdpc_egfr60_total_lin_predictor, 5),
         ckdpc_egfr60_confirmed_score=round(ckdpc_egfr60_confirmed_score, 5),
         ckdpc_egfr60_confirmed_lin_predictor=round(ckdpc_egfr60_confirmed_lin_predictor, 5),
         ckdpc_40egfr_lin_predictor=round(ckdpc_40egfr_lin_predictor, 5),
         ckdpc_40egfr_score=round(ckdpc_40egfr_score, 5))

local_all %>% inner_join(remote_all) %>% count()
# Check values match those from above
# Should be full count




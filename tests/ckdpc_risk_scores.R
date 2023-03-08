# Setup
library(tidyverse)
library(aurum)
library(EHRBiomarkr)
rm(list=ls())

cprd = CPRDData$new(cprdEnv = "test-remote",cprdConf = "~/.aurum.yaml")

analysis = cprd$analysis("katie")


############################################################################################

test <- test %>% analysis$cached("ckd_score_test")


test2 <- test %>%
  
  calculate_ckdpc_egfr60_risk(age=age_var, sex=sex_var, black_eth=black_ethnicity_var, egfr=egfr_var, cvd=cvd_var, hba1c=hba1c_var, oha=oha_var, insulin=insulin_var, ever_smoker = ever_smoker_var, hypertension=hypertension_var, acr=acr_var, bmi=bmi_var, remote=TRUE) %>%
  
  analysis$cached("ckd_score_test2")

test3 <- test2 %>%
  
  calculate_ckdpc_40egfr_risk(age=age_var, sex=sex_var, egfr=egfr_var, acr=acr_var, sbp=sbp_var, bp_meds=bp_meds_var, hf=hf_var, chd=chd_var, af=af_var, current_smoker=current_smoker_var, ex_smoker=ex_smoker_var, bmi=bmi_var, hba1c=hba1c_var, oha=oha_var, insulin=insulin_var, remote=TRUE) %>%
  
  analysis$cached("ckd_score_test3")


remote <- collect(test3)


local <- collect(test)

local <- local %>%
  
  calculate_ckdpc_egfr60_risk(age=age_var, sex=sex_var, black_eth=black_ethnicity_var, egfr=egfr_var, cvd=cvd_var, hba1c=hba1c_var, oha=oha_var, insulin=insulin_var, ever_smoker = ever_smoker_var, hypertension=hypertension_var, acr=acr_var, bmi=bmi_var, remote=FALSE)
  
local <- local %>%
  calculate_ckdpc_40egfr_risk(age=age_var, sex=sex_var, egfr=egfr_var, acr=acr_var, sbp=sbp_var, bp_meds=bp_meds_var, hf=hf_var, chd=chd_var, af=af_var, current_smoker=current_smoker_var, ex_smoker=ex_smoker_var, bmi=bmi_var, hba1c=hba1c_var, oha=oha_var, insulin=insulin_var, remote=FALSE)


test <- local %>%
  select(-c(ckdpc_egfr60_risk_confirmed_score, ckdpc_egfr60_risk_confirmed_lin_predictor, ckdpc_egfr60_risk_total_lin_predictor, ckdpc_40egfr_risk_lin_predictor)) %>%
  rename(local_ckd60=ckdpc_egfr60_risk_total_score, local_ckd40=ckdpc_40egfr_risk_score) %>%
  inner_join((remote %>% select(id, remote_ckd60=ckdpc_egfr60_risk_total_score, remote_ckd40=ckdpc_40egfr_risk_score)), by="id")


test2 <- test %>% filter(round(local_ckd40, 4)!=round(remote_ckd40, 4) | round(local_ckd60, 4)!=round(remote_ckd60, 4))

ckd60 <- test %>% select(id, age_var, sex_var, black_ethnicity_var, egfr_var, cvd_var, bmi_var, ever_smoker_var, oha_var, insulin_var, hba1c_var, acr_var, hypertension_var, remote_ckd60, local_ckd60)

ckd40 <-  test %>% select(id, age_var, sex_var, egfr_var, acr_var, sbp_var, bp_meds_var, hf_var, chd_var, af_var, bmi_var, current_smoker_var, ex_smoker_var, oha_var, insulin_var, hba1c_var, remote_ckd40, local_ckd40)









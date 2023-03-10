library(devtools)
devtools::install_github("Exeter-Diabetes/EHRBiomarkr")

library(tidyverse)
library(aurum)
library(EHRBiomarkr)



cprd = CPRDData$new(cprdEnv = "test-remote",cprdConf = "~/.aurum.yaml")


## Biomarker unit and limit cleaning

analysis = cprd$analysis("all_patid")

raw_hdl <- raw_hdl %>% analysis$cached("raw_hdl_medcodes")

raw_hdl <- collect(raw_hdl %>% mutate(patid-as.character(patid)))

is.integer64 <- function(x){
  class(x)=="integer64"
}

raw_hdl <- raw_hdl %>% mutate_if(is.integer64, as.integer)

raw_hdl %>% filter(!is.na(testvalue) & testvalue<0.3) %>% count()
## 0.2 and above are acceptable, below 0.2 is not
#22,374

raw_hdl %>% filter(!is.na(testvalue) & testvalue<0.3) %>% clean_biomarker_values(testvalue, "hdl") %>% count()
#2,066


raw_hdl %>% filter(numunitid==218 | numunitid==1) %>% count()
## 218 is acceptable, 1 is not
#14,772,379

raw_hdl %>% filter(numunitid==218 | numunitid==1) %>% clean_biomarker_units(numunitid, "hdl") %>% count()
#14,772,354



## eGFR

analysis = cprd$analysis("all_patid")

clean_creatinine <- clean_creatinine %>% analysis$cached("clean_creatinine_blood_medcodes")

clean_creatinine <- collect(clean_creatinine %>%
  
  head(100) %>%
  
  inner_join((cprd$tables$patient %>% select(patid, yob, mob, gender)), by="patid") %>%
  mutate(dob=as.Date(ifelse(is.na(mob), paste0(yob,"-07-01"), paste0(yob, "-",mob,"-15"))),
         age_at_creat=(datediff(date, dob))/365.25,
         sex=ifelse(gender==1, "male", ifelse(gender==2, "female", NA)),
         patid=as.character(patid)))

is.integer64 <- function(x){
  class(x)=="integer64"
}

clean_creatinine <- clean_creatinine %>% mutate_if(is.integer64, as.integer)


clean_egfr <- clean_creatinine %>%
  
  ckd_epi_2021_egfr(creatinine=testvalue, sex=sex, age_at_creatinine=age_at_creat)


clean_egfr %>% glimpse()
# Looks good
clean_egfr %>% count()
#100



## QDiabetes-HF and QRISK2

analysis = cprd$analysis("mm")

example_dataset <- example_dataset %>% analysis$cached("20230116_t2d_1stinstance_interim_2")

example_dataset <- collect(example_dataset %>% head(100) %>% mutate(patid=as.character(patid)))

is.integer64 <- function(x){
  class(x)=="integer64"
}

example_dataset <- example_dataset %>% mutate_if(is.integer64, as.integer)


qdhf <- example_dataset %>%
  
  mutate(sex2=ifelse(sex=="male", "male", ifelse(sex=="female", "female", NA))) %>%
  
  calculate_qdiabeteshf(sex=sex2, age=dstartdate_age, ethrisk=ethnicity_qrisk2, smoking=qrisk2_smoking_cat, duration=dm_duration_cat, type1=type1, cvd=cvd, renal=ckd45, af=predrug_af, hba1c=prehba1c, cholhdl=precholhdl, sbp=presbp, bmi=prebmi, town=tds_2011, surv=surv_5yr)


qdhf_and_qrisk2 <- qdhf %>%
  
  mutate(sex2=ifelse(sex=="male", "male", ifelse(sex=="female", "female", NA))) %>%
  
  calculate_qrisk2(sex=sex2, age=dstartdate_age, ethrisk=ethnicity_qrisk2, smoking=qrisk2_smoking_cat, type1=type1, type2=type2, fh_cvd=predrug_fh_premature_cvd, renal=ckd45, af=predrug_af, rheumatoid_arth=predrug_rheumatoidarthritis, cholhdl=precholhdl, sbp=presbp, bmi=prebmi, bp_med=bp_meds, town=tds_2011, surv=surv_5yr)


qdhf_and_qrisk2 %>% glimpse()
# Looks good
qdhf_and_qrisk2 %>% count()
#100



## CKDPC risk score

analysis = cprd$analysis("mm")

example_dataset <- example_dataset %>% analysis$cached("20230116_t2d_1stinstance_interim_2")

example_dataset <- collect(example_dataset %>% head(100) %>% mutate(patid=as.character(patid)))

is.integer64 <- function(x){
  class(x)=="integer64"
}

example_dataset <- example_dataset %>% mutate_if(is.integer64, as.integer)

extra_vars <- data.frame(insulin=sample(c(0,1), replace=TRUE, size=100), oha=sample(c(0,1), replace=TRUE, size=100), hypertension=sample(c(0,1), replace=TRUE, size=100), preegfr=sample(c(65:90), replace=TRUE, size=100), preacr=sample(c(5:500), replace=TRUE, size=100), hba1c_perc=sample(c(6:11), replace=TRUE, size=100))

example_dataset <- example_dataset %>% bind_cols(extra_vars)

ckdpc_risk <- example_dataset %>%
  
  mutate(sex2=ifelse(sex=="male", "male", ifelse(sex=="female", "female", NA)),
         black_eth=ifelse(ethnicity_qrisk2==6 | ethnicity_qrisk2==7, 1, 0),
         ever_smoker=ifelse(qrisk2_smoking_cat==0, 1, 0)) %>%
  
  calculate_ckdpc_risk(age=dstartdate_age, sex=sex2, black_eth=black_eth, egfr=preegfr, cvd=cvd, hba1c=hba1c_perc, insulin=insulin, oha=oha, ever_smoker=ever_smoker, hypertension=hypertension, bmi=prebmi, acr=preacr)



test <- data.frame(prebmi=25, ever_smoker=0, cvd=0, hypertension=0, black_eth=0, sex2="male", dstartdate_age=25, preacr=5, hba1c_perc=7.7, insulin=0, oha=1, preegfr=90)

ckdpc_risk <- test %>%
  
  calculate_ckdpc_egfr_60_risk(age=dstartdate_age, sex=sex2, black_eth=black_eth, egfr=preegfr, cvd=cvd, hba1c=hba1c_perc, insulin=insulin, oha=oha, ever_smoker=ever_smoker, hypertension=hypertension, bmi=prebmi, acr=preacr)





qdhf_and_qrisk2 %>% glimpse()
# Looks good
qdhf_and_qrisk2 %>% count()
#100









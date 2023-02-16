#' Calculate CKDPC risk score for 5-year absolute risk of eGFR<60ml/min/1.73m2 in people with diabetes (ckdpc_risk; total and confirmed events) from Nelson RG, Grams ME, Ballew SH. Development of Risk Prediction Equations for Incident Chronic Kidney Disease. JAMA. doi:10.1001/jama.2019.17379 (https://jamanetwork.com/journals/jama/fullarticle/2755299).

#' @description calculate 5-year absolute risk of eGFR<60 in people with diabetes (total and confirmed events)
#' @param dataframe dataframe containing variables for risk score
#' @param age current age in years
#' @param sex sex: "male" or "female"
#' @param black_eth black ethnicity (0: no, 1: yes)
#' @param egfr current eGFR in ml/min/1.73m2
#' @param cvd history of CVD (myocardial infarction, coronary revascularization, heart failure, or stroke; 0: no, 1: yes)
#' @param hba1c current HbA1c in mmol/mol
#' @param insulin whether currently taking insulin (0: no, 1: yes)
#' @param oha whether currently taking OHA (0: no, 1: yes)
#' @param ever_smoker ever smoker (0: no, 1: yes)
#' @param hypertension current hypertension (defined as blood pressure of more than 140/90 mm Hg or use of antihypertensive medications; 0: no, 1: yes)
#' @param bmi BMI in kg/m2
#' @param acr albumin:creatinine ratio in mg/g; value of 10 used if missing
#' @importFrom magrittr %>%
#' @importFrom dplyr mutate
#' @importFrom dplyr inner_join
#' @importFrom dplyr row_number
#' @importFrom dplyr select
#' @importFrom dplyr bind_cols
#' @export

calculate_ckdpc_risk = function(dataframe, age, sex, black_eth, egfr, cvd, hba1c, insulin, oha, ever_smoker, hypertension, bmi, acr) {
  

  # Get handles for columns
  age_col <- as.symbol(deparse(substitute(age)))
  sex_col <- as.symbol(deparse(substitute(sex)))
  black_eth_col <- as.symbol(deparse(substitute(black_eth)))
  egfr_col <- as.symbol(deparse(substitute(egfr)))
  cvd_col <- as.symbol(deparse(substitute(cvd)))
  hba1c_col <- as.symbol(deparse(substitute(hba1c)))
  dm_med_col <- as.symbol(deparse(substitute(dm_med)))
  insulin_col <- as.symbol(deparse(substitute(insulin)))
  oha_col <- as.symbol(deparse(substitute(oha)))
  ever_smoker_col <- as.symbol(deparse(substitute(ever_smoker)))
  hypertension_col <- as.symbol(deparse(substitute(hypertension)))
  bmi_col <- as.symbol(deparse(substitute(bmi)))
  acr_col <- as.symbol(deparse(substitute(acr)))


  # Make unique ID for each row so can join back on later
  dataframe <- dataframe %>%
    mutate(id_col=row_number())
  
  
  # Copy dataframe to new dataframe
  new_dataframe <- dataframe
  
  
  # Fetch constants from package
  ckdpc_risk_vars <- data.frame(unlist(lapply(EHRBiomarkr::ckdpcRiskConstants, function(y) lapply(y, as.numeric)), recursive="FALSE"))
  
  
  # Join constants to data table
  ## copy=TRUE as need to copy constants to MySQL from package

  new_dataframe <- new_dataframe %>%
    
    bind_cols(ckdpc_risk_vars, copy=TRUE)
    
  
  # Do calculation
    
  new_dataframe <- new_dataframe %>%
    
    mutate(female_sex_col=ifelse(sex=="female", 1L, 0L),
           no_dm_med_col=ifelse(insulin_col==0 & oha_col==0, 1L, 0L),
           
           ckdpc_risk_total_lin_predictor=
               exp(exp_cons_total +
                     (age_cons * ((age_col/5) - 11)) +  
                     (female_cons * female_sex_col) +
                     (black_eth_cons * black_eth_col) +
                     (egfr_cons1 * (15 - (min(egfr_col, 90)/5))) +
                     (-(egfr_cons2 * (max(0, egfr_col-90))/5)) +
                     (cvd_cons * cvd_col) +
                     (hba1c_cons * (hba1c_col-7)) +
                     (insulin_cons * insulin_col) +
                     (-(no_dm_med_cons * no_dm_med_col)) +
                     (hba1c_insulin_cons * (hba1c_col-7) * insulin_col) +
                     (hba1c_no_dm_med_cons * (hba1c_col-7) * no_dm_med_col) +
                     (-(ever_smoker_cons * ever_smoker_col)) +
                     (hypertension_cons * hypertension_col) +
                     (bmi_cons * ((bmi_col/5)-5.4)) +
                     (acr_cons * (log(acr_col, base=10) - 1))
               ),
           
           ckdpc_risk_total_score=100 * (1 - exp((-5^surv_total) * exp(ckdpc_risk_total_lin_predictor))),
           
           ckdpc_risk_confirmed_lin_predictor=
             exp(exp_cons_confirmed +
                     (age_cons * ((age_col/5) - 11)) +  
                     (female_cons * female_sex_col) +
                     (black_eth_cons * black_eth_col) +
                     (egfr_cons1 * (15 - (min(egfr_col, 90)/5))) +
                     (-(egfr_cons2 * (max(0, egfr_col-90))/5)) +
                     (cvd_cons * cvd_col) +
                     (hba1c_cons * (hba1c_col-7)) +
                     (insulin_cons * insulin_col) +
                     (-(no_dm_med_cons * no_dm_med_col)) +
                     (hba1c_insulin_cons * (hba1c_col-7) * insulin_col) +
                     (hba1c_no_dm_med_cons * (hba1c_col-7) * no_dm_med_col) +
                     (-(ever_smoker_cons * ever_smoker_col)) +
                     (hypertension_cons * hypertension_col) +
                     (bmi_cons * ((bmi_col/5)-5.4)) +
                     (acr_cons * (log(acr_col, base=10) - 1))
               ),
           
           ckdpc_risk_confirmed_score=100 * (1 - exp((-5^surv_confirmed) * exp(ckdpc_risk_confirmed_lin_predictor))))
  
  
  # Keep linear predictors and scores and unique ID columns only
  new_dataframe <- new_dataframe %>%
    select(id_col, ckdpc_risk_total_score, ckdpc_risk_total_lin_predictor, ckdpc_risk_confirmed_score, ckdpc_risk_confirmed_lin_predictor)

  # Join back on to original data table 
  dataframe <- dataframe %>%
    inner_join(new_dataframe, by="id_col") %>%
    select(-id_col)
  
  message("New columns 'ckdpc_risk_total_score', 'ckdpc_risk_total_lin_predictor', 'ckdpc_risk_confirmed_score' and 'ckdpc_risk_confirmed_lin_predictor' added")
  
  return(dataframe)
  

}
#' Calculate CKDPC risk score for 5-year absolute risk of eGFR<60ml/min/1.73m2 in people with diabetes (ckdpc_egfr60_risk; total and confirmed events) from Nelson RG, Grams ME, Ballew SH. Development of Risk Prediction Equations for Incident Chronic Kidney Disease. JAMA. doi:10.1001/jama.2019.17379 (https://jamanetwork.com/journals/jama/fullarticle/2755299).

#' @description calculate 5-year absolute risk of eGFR<60ml/min/1.73m2 in people with diabetes (total and confirmed events)
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
#' @param acr urinary albumin:creatinine ratio in mg/g
#' @importFrom magrittr %>%
#' @importFrom dplyr mutate
#' @importFrom dplyr inner_join
#' @importFrom dplyr row_number
#' @importFrom dplyr select
#' @export

calculate_ckdpc_egfr60_risk = function(dataframe, age, sex, black_eth, egfr, cvd, hba1c, insulin, oha, ever_smoker, hypertension, bmi, acr) {
  

  # Get handles for columns
  age_col <- as.symbol(deparse(substitute(age)))
  sex_col <- as.symbol(deparse(substitute(sex)))
  black_eth_col <- as.symbol(deparse(substitute(black_eth)))
  egfr_col <- as.symbol(deparse(substitute(egfr)))
  cvd_col <- as.symbol(deparse(substitute(cvd)))
  hba1c_col <- as.symbol(deparse(substitute(hba1c)))
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
  new_dataframe <- dataframe %>%
    mutate(join_col=1L)
  
  
  # Fetch constants from package
  ckdpc_egfr60_risk_vars <- data.frame(unlist(lapply(EHRBiomarkr::ckdpcEgfr60RiskConstants, function(y) lapply(y, as.numeric)), recursive="FALSE")) %>%
    mutate(join_col=1L)
  
  
  # Join constants to data table
  ## copy=TRUE as need to copy constants to MySQL from package

  new_dataframe <- new_dataframe %>%
    
    inner_join(ckdpc_egfr60_risk_vars, by="join_col", copy=TRUE)
    
  
  # Do calculation
    
  new_dataframe <- new_dataframe %>%
    
    mutate(female_sex=ifelse(!!sex_col=="female", 1L, 0L),
           no_dm_med=ifelse(!!insulin_col==0 & !!oha_col==0, 1L, 0L),
           hba1c_percent=(!!hba1c_col*0.09418)+2.152,
           
           test=(acr_cons * (paste0('sql_on("LOG(10.0,\'', !!acr_col, '\')")') - 1)),
           
           ckdpc_egfr60_risk_total_lin_predictor=
             exp_cons_total +
             (age_cons * ((!!age_col/5) - 11)) +  
             (female_cons * female_sex) +
             (black_eth_cons * !!black_eth_col) +
             (egfr_cons1 * (15 - (pmin(!!egfr_col, 90, na.rm=TRUE)/5))) +
             (-(egfr_cons2 * (pmax(0, !!egfr_col-90, na.rm=TRUE))/5)) +
             (cvd_cons * !!cvd_col) +
             (hba1c_cons * (hba1c_percent-7)) +
             (insulin_cons * !!insulin_col) +
             (-(no_dm_med_cons * no_dm_med)) +
             (hba1c_insulin_cons * (hba1c_percent-7) * !!insulin_col) +
             (hba1c_no_dm_med_cons * (hba1c_percent-7) * no_dm_med) +
             (-(ever_smoker_cons * !!ever_smoker_col)) +
             (hypertension_cons * !!hypertension_col) +
             (bmi_cons * ((!!bmi_col/5)-5.4)) +
             (acr_cons * (paste0('sql_on="LOG(10.0,', 100, ')"') - 1)),
           
           ckdpc_egfr60_risk_total_score=100 * (1 - exp((-5^surv_total) * exp(ckdpc_egfr60_risk_total_lin_predictor))),
           
           ckdpc_egfr60_risk_confirmed_lin_predictor=
             exp_cons_confirmed +
             (age_cons * ((!!age_col/5) - 11)) +  
             (female_cons * female_sex) +
             (black_eth_cons * !!black_eth_col) +
             (egfr_cons1 * (15 - (pmin(!!egfr_col, 90)/5))) +
             (-(egfr_cons2 * (pmax(0, !!egfr_col-90))/5)) +
             (cvd_cons * !!cvd_col) +
             (hba1c_cons * (hba1c_percent-7)) +
             (insulin_cons * !!insulin_col) +
             (-(no_dm_med_cons * no_dm_med)) +
             (hba1c_insulin_cons * (hba1c_percent-7) * !!insulin_col) +
             (hba1c_no_dm_med_cons * (hba1c_percent-7) * no_dm_med) +
             (-(ever_smoker_cons * !!ever_smoker_col)) +
             (hypertension_cons * !!hypertension_col) +
             (bmi_cons * ((!!bmi_col/5)-5.4)) +
             (acr_cons * (paste0('sql_on("LOG(10.0,\'', !!acr_col, '\')")') - 1)),
            
           ckdpc_egfr60_risk_confirmed_score=100 * (1 - exp((-5^surv_confirmed) * exp(ckdpc_egfr60_risk_confirmed_lin_predictor))))
  
  
  # Keep linear predictors and scores and unique ID columns only
  new_dataframe <- new_dataframe %>%
    select(id_col, hba1c_percent, test, ckdpc_egfr60_risk_total_score, ckdpc_egfr60_risk_total_lin_predictor, ckdpc_egfr60_risk_confirmed_score, ckdpc_egfr60_risk_confirmed_lin_predictor)

  # Join back on to original data table 
  dataframe <- dataframe %>%
    inner_join(new_dataframe, by="id_col") %>%
    select(-id_col)
  
  message("New columns 'ckdpc_egfr60_risk_total_score', 'ckdpc_egfr60_risk_total_lin_predictor', 'ckdpc_egfr60_risk_confirmed_score' and 'ckdp_egfr60_risk_confirmed_lin_predictor' added")
  
  return(dataframe)
  

}



#' Calculate CKDPC risk score for 3-year absolute risk of 40\% decline in eGFR or kidney failure in people with diabetes with baseline eGFR>=60ml/min/1.73m2 (ckdpc_40egfr_risk) from Grams ME, Brunskill NJ, Ballew SH. Development and Validation of Prediction Models of Adverse Kidney Outcomes in the Population With and Without Diabetes Mellitus. Diabetes Care. doi:0.2337/dc22-0698 (https://diabetesjournals.org/care/article-abstract/45/9/2055/147251/Development-and-Validation-of-Prediction-Models-of?redirectedFrom=fulltext).

#' @description calculate 3-year absolute risk of 40% decline in eGFR or kidney failure in people with diabetes with baseline eGFR>=60ml/min/1.73m2
#' @param dataframe dataframe containing variables for risk score
#' @param age current age in years
#' @param sex sex: "male" or "female"
#' @param egfr current eGFR in ml/min/1.73m2
#' @param acr urinary albumin:creatinine ratio in mg/g
#' @param sbp systolic blood pressure in mmHg
#' @param bp_meds current use of antihypertensive medications (0: no, 1: yes)
#' @param hf history of heart failure (0: no, 1: yes)
#' @param chd history of coronary heart disease (MI or coronary revascularisation; 0: no, 1: yes)
#' @param af history of atrial fibrillation (0: no, 1: yes)
#' @param current_smoker current smoker (0: no, 1: yes)
#' @param ex_smoker ex_smoker (0: no, 1: yes)
#' @param bmi BMI in kg/m2
#' @param hba1c current HbA1c in mmol/mol
#' @param oha whether currently taking OHA (0: no, 1: yes)
#' @param insulin whether currently taking insulin (0: no, 1: yes)
#' @importFrom magrittr %>%
#' @importFrom dplyr mutate
#' @importFrom dplyr inner_join
#' @importFrom dplyr row_number
#' @importFrom dplyr select
#' @export

calculate_ckdpc_40egfr_risk = function(dataframe, age, sex, egfr, acr, sbp, bp_meds, hf, chd, af, current_smoker, ex_smoker, bmi, hba1c, oha, insulin) {

  
  # Get handles for columns
  age_col <- as.symbol(deparse(substitute(age)))
  sex_col <- as.symbol(deparse(substitute(sex)))
  egfr_col <- as.symbol(deparse(substitute(egfr)))
  acr_col <- as.symbol(deparse(substitute(acr)))
  sbp_col <- as.symbol(deparse(substitute(sbp)))
  bp_meds_col <- as.symbol(deparse(substitute(bp_meds)))
  hf_col <- as.symbol(deparse(substitute(hf)))
  chd_col <- as.symbol(deparse(substitute(chd)))
  af_col <- as.symbol(deparse(substitute(af)))
  current_smoker_col <- as.symbol(deparse(substitute(current_smoker)))
  ex_smoker_col <- as.symbol(deparse(substitute(ex_smoker)))
  bmi_col <- as.symbol(deparse(substitute(bmi)))
  hba1c_col <- as.symbol(deparse(substitute(hba1c)))
  oha_col <- as.symbol(deparse(substitute(oha)))
  insulin_col <- as.symbol(deparse(substitute(insulin)))
  
  
  # Make unique ID for each row so can join back on later
  dataframe <- dataframe %>%
    mutate(id_col=row_number())
  
  
  # Copy dataframe to new dataframe
  new_dataframe <- dataframe %>%
    mutate(join_col=1L)
  
  
  # Fetch constants from package
  ckdpc_40egfr_risk_vars <- data.frame(unlist(lapply(EHRBiomarkr::ckdpc40EgfrRiskConstants, function(y) lapply(y, as.numeric)), recursive="FALSE")) %>%
    mutate(join_col=1L)
  
  
  # Join constants to data table
  ## copy=TRUE as need to copy constants to MySQL from package
  
  new_dataframe <- new_dataframe %>%
    
    inner_join(ckdpc_40egfr_risk_vars, by="join_col", copy=TRUE)
  
  
  # Do calculation
  
  new_dataframe <- new_dataframe %>%
    
    mutate(male_sex=ifelse(!!sex_col=="male", 1L, 0L),
           hba1c_percent=(!!hba1c_col*0.09418)+2.152,
           
           ckdpc_40egfr_risk_lin_predictor=
             exp_cons +
             (-(male_cons * (male_sex - 0.5))) +
             (-(egfr_cons * ((!!egfr_col - 85)/5))) +
             (acr_cons * log(!!acr_col/10)) +
             (sbp_cons * ((!!sbp_col - 130) /20)) +
             (bp_med_cons * !!bp_meds_col) +
             (-(sbp_bp_med_cons * ((!!sbp_col - 130)/20) * !!bp_meds_col)) +
             (hf_cons * (!!hf_col-0.05)) +
             (chd_cons * (!!chd_col-0.15)) +
             (af_cons * !!af_col) +
             (current_smoker_cons * !!current_smoker_col) +
             (ex_smoker_cons * !!ex_smoker_col) +
             (bmi_cons * ((!!bmi_col-30)/5)) +
             (hba1c_cons * (hba1c_percent-7)) +
             (-(oha_cons * !!oha_col)) +
             (insulin_cons * !!insulin_col),
           
           ckdpc_40_egfr_risk_score=100 * (exp(ckdpc_40egfr_risk_lin_predictor)/(1+exp(ckdpc_40egfr_risk_lin_predictor))))
           
           
  # Keep linear predictors and scores and unique ID columns only
  new_dataframe <- new_dataframe %>%
    select(id_col, ckdpc_40egfr_risk_lin_predictor, ckdpc_40egfr_risk_score)
  
  # Join back on to original data table 
  dataframe <- dataframe %>%
    inner_join(new_dataframe, by="id_col") %>%
    select(-id_col)
  
  message("New columns 'ckdpc_40egfr_risk_lin_predictor' and 'ckdpc_40egfr_risk_score' added")
  
  return(dataframe)
  
  
}
% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ckdpc_ckd_risk_scores.R
\name{calculate_ckdpc_egfr60_risk}
\alias{calculate_ckdpc_egfr60_risk}
\title{Calculate CKDPC risk score for 5-year absolute risk of eGFR<60ml/min/1.73m2 in people with diabetes (ckdpc_egfr60; total and confirmed events) from Nelson RG, Grams ME, Ballew SH. Development of Risk Prediction Equations for Incident Chronic Kidney Disease. JAMA. doi:10.1001/jama.2019.17379 (https://jamanetwork.com/journals/jama/fullarticle/2755299).
User can specify whether to keep missing ACR/ACR values of 0 as missing/0 or to substitute missing/0 ACR for 10mg/g ('complete_acr'), as per the above paper (missing ACR indicator parameter not included). Default is for missing ACR to remain missing.}
\usage{
calculate_ckdpc_egfr60_risk(
  dataframe,
  age,
  sex,
  black_eth,
  egfr,
  cvd,
  hba1c,
  insulin,
  oha,
  ever_smoker,
  hypertension,
  bmi,
  acr,
  complete_acr = FALSE,
  remote
)
}
\arguments{
\item{dataframe}{dataframe containing variables for risk score}

\item{age}{current age in years}

\item{sex}{sex: "male" or "female"}

\item{black_eth}{black ethnicity (0: no, 1: yes)}

\item{egfr}{current eGFR in ml/min/1.73m2}

\item{cvd}{history of CVD (myocardial infarction, coronary revascularization, heart failure, or stroke; 0: no, 1: yes)}

\item{hba1c}{current HbA1c in mmol/mol}

\item{insulin}{whether currently taking insulin (0: no, 1: yes)}

\item{oha}{whether currently taking OHA (0: no, 1: yes)}

\item{ever_smoker}{ever smoker (0: no, 1: yes)}

\item{hypertension}{current hypertension (defined as blood pressure of more than 140/90 mm Hg or use of antihypertensive medications; 0: no, 1: yes)}

\item{bmi}{BMI in kg/m2}

\item{acr}{urinary albumin:creatinine ratio in mg/mmol (note that mg/g is also used)}

\item{complete_acr}{whether missing ACR and ACR values of 0 should be substituted with 10mg/g (TRUE). Default is FALSE i.e. missing ACR/0 values remains missing/0 and scores cannot be calculated for these people}

\item{remote}{whether dataframe is local in R (remote=FALSE) or on a SQL server (remote=TRUE) - values will be calculated but incorrect if the wrong value for remote is used due to differences in how logs are calculated in R and SQL}
}
\description{
calculate 5-year absolute risk of eGFR<60ml/min/1.73m2 in people with diabetes (total and confirmed events)
}

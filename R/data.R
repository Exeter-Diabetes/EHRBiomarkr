#' Biomarker acceptable limits
#'
#' Clinically plausible upper and lower limits for biomarker values, in standard UK units. These limits were decided after consultation with clinicians. Entries outside these limits are considered data entry errors and should be excluded. Biomarkers with more than one-commonly used unit must be converted to standard units (haematocrit: proportion between 0 and 1, haemoglobin: g/L, HbA1c: mmol/L). Biomarkers included: ACR, ALT, blood albumin, AST, bilirubin, BMI, blood creatinine, DBP, fasting glucose, haematocrit, haemoglobin, HbA1c (mmol/L), HDL, height, LDL, PCR, SBP, total cholesterol, triglycerides, and weight. BMI, height, and weight limits are for adult measurements only.
#'
#' @docType data
"biomarkerAcceptableLimits"


#' Biomarker acceptable units
#'
#' In CPRD Aurum, test results in the Observation table have an associated numunitid code which gives the units for the test result, although it is frequently missing. As there are more than 70,000 numunitid codes, it was not possible to check all the codes associated with each biomarker and determine which were correct (i.e. were the expected standard UK unit for that biomarker) and which were incorrect. Instead, we determined a set of 'acceptable' numunitid codes for each biomarker, by including the most popular correct numunitid codes associated with each biomarker, which together accounted for >99\% of the entries with values in the plausible range for that biomarker in our CPRD extract. We included missing numunitid codes as an acceptable code for all biomarkers, and assumed the results with missing numunitid were in standard units (for haematocrit, haemoglobin, and HbA1c we used the value to infer the units as per: https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/main/readme.md#biomarker-algorithms). Biomarkers included: ACR, ALT, blood albumin, AST, bilirubin, BMI, blood creatinine, DBP, fasting glucose, haematocrit, haemoglobin, HbA1c (mmol/L), HDL, height, LDL, PCR, SBP, total cholesterol, triglycerides, and weight.
#' 
#' @docType data
"biomarkerAcceptableUnits"


#' QDiabetes-Heart Failure constants
#'
#' Constants required for the QDiabetes-Heart Failure (2015) risk score. Source: https://qdiabetes.org/heart-failure/src.php
#' 
#' @docType data
"qdiabeteshfConstants"


#' QRISK2 constants
#'
#' Constants required for the QRISK2 (2017) risk score. Source: https://www.qrisk.org/2017/QRISK2-2017-lgpl.tgz
#' 
#' @docType data
"qrisk2Constants"


#' Q missing predictors
#'
#' Constants required for to impute missing values for QRISK2 (2017) and QDiabetes-Heart Failure
#' 
#' @docType data
"qMissingPredictors"


#' CKDPC eGFR<60 risk score constants
#'
#' Constants required for to calculate 5-year CKDPC risk score for eGFR<60ml/min/1.73m2 (total and confirmed events) in people with diabetes. Source: Nelson RG, Grams ME, Ballew SH. Development of Risk Prediction Equations for Incident Chronic Kidney Disease. JAMA. doi:10.1001/jama.2019.17379 (https://jamanetwork.com/journals/jama/fullarticle/2755299).
#' 
#' @docType data
"ckdpcEgfr60RiskConstants"


#' CKDPC 40% decline in eGFR or kidney failure risk score constants
#'
#' Constants required for to calculate 3-year CKDPC risk score for composite of 40% decline in eGFR or kidney failure in people with diabetes and baseline eGFR>=60ml/min/1.73m2. Source: Grams ME, Brunskill NJ, Ballew SH. Development and Validation of Prediction Models of Adverse Kidney Outcomes in the Population With and Without Diabetes Mellitus. Diabetes Care. doi:0.2337/dc22-0698 (https://diabetesjournals.org/care/article-abstract/45/9/2055/147251/Development-and-Validation-of-Prediction-Models-of?redirectedFrom=fulltext).
#' 
#' @docType data
"ckdpc40EgfrRiskConstants"
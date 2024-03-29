% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{biomarkerAcceptableUnits}
\alias{biomarkerAcceptableUnits}
\title{Biomarker acceptable units}
\format{
An object of class \code{list} of length 21.
}
\usage{
biomarkerAcceptableUnits
}
\description{
In CPRD Aurum, test results in the Observation table have an associated numunitid code which gives the units for the test result, although it is frequently missing. As there are more than 70,000 numunitid codes, it was not possible to check all the codes associated with each biomarker and determine which were correct (i.e. were the expected standard UK unit for that biomarker) and which were incorrect. Instead, we determined a set of 'acceptable' numunitid codes for each biomarker, by including the most popular correct numunitid codes associated with each biomarker, which together accounted for >99\% of the entries with values in the plausible range for that biomarker in our CPRD extract. We included missing numunitid codes as an acceptable code for all biomarkers, and assumed the results with missing numunitid were in standard units (for haematocrit, haemoglobin, and HbA1c we used the value to infer the units as per: https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/main/readme.md#biomarker-algorithms). Note that for ACR, 'ratio', '1/1' and '%' were deemed acceptable units and the values assumed to be in mg/mmol as the values with these unit codes were consistent with this (also for PCR and 'ratio'). Biomarkers included: ACR (mg/mmol / g/mol), ALT (U/L), blood albumin (g/L), AST (U/L), total bilirubin (umol/L), BMI (kg/m2), blood creatinine (umol/L), DBP (mmHg), fasting glucose (mmol/L), haematocrit (proportion out of 1), haemoglobin (g/L), HbA1c (mmol/mol), HDL (mmol/L), height (m), LDL (mmol/L), PCR (mg/mmol / g/mol), SBP (mmHg), total cholesterol (mmol/L), triglycerides (mmol/L), and weight (kg).
}
\keyword{datasets}

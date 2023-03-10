% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{biomarkerAcceptableLimits}
\alias{biomarkerAcceptableLimits}
\title{Biomarker acceptable limits}
\format{
An object of class \code{list} of length 20.
}
\usage{
biomarkerAcceptableLimits
}
\description{
Clinically plausible upper and lower limits for biomarker values, in standard UK units. These limits were decided after consultation with clinicians. Entries outside these limits are considered data entry errors and should be excluded. Biomarkers with more than one-commonly used unit must be converted to standard units (haematocrit: proportion between 0 and 1, haemoglobin: g/L, HbA1c: mmol/L). Biomarkers included: ACR, ALT, blood albumin, AST, bilirubin, BMI, blood creatinine, DBP, fasting glucose, haematocrit, haemoglobin, HbA1c (mmol/L), HDL, height, LDL, PCR, SBP, total cholesterol, triglycerides, and weight. BMI, height, and weight limits are for adult measurements only.
}
\keyword{datasets}

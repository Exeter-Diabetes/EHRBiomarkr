# EHRBiomarkr

This package has various functions for cleaning and prcoessing biomarkers in EHR, especially in CPRD Aurum.

### Biomarker functions

Two functions for cleaning biomarker values are included in this package, and can be used on local data (loaded into R) or data stored in MySQL (by using the dbplyr package or another package which uses dbplyr e.g. [aurum](http://github.com/Exeter-Diabetes/CPRD-analysis-package)).

`clean_biomarker_values` removes values outside of plausible limits (run `biomarkerAcceptableLimits` to see limits, also our [CPRD-Codelists](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/main/Biomarkers/biomarker_acceptable_limits.txt) repository). Run `?biomarkerAcceptableLimits` for details of how these were ascertained.

`clean_biomarker_units` retains only values with appropriate unit codes (numunitid) or missing unit code in CPRD Aurum (run `biomarkerAcceptableLimits` to see appropriate unit codes, also our [CPRD-Codelists](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/main/Biomarkers/biomarker_acceptable_units.txt) repository). Run `?biomarkerAcceptableUnits` for details of how these were ascertained.

These functions can be applied to the following biomarkers:

-   Albumin-creatinine ratio (`acr`)
-   Alanine aminotransferase (`alt`)
-   (Blood) albumin (`albumin_blood`)
-   Aspartate aminotransferase(`ast`)
-   Bilirubin (`bilirubin`)
-   BMI (adults only; `bmi`)
-   Serum/plasma creatinine (`creatinine_blood`)
-   Diastolic blood pressure (`dbp`)
-   Fasting glucose (`fastingglucose`)
-   Haematocrit (`haematocrit`)
-   Haemoglobin (`haemoglobin`)
-   HbA1c (`hba1c`)
-   HDL (`hdl`)
-   Height (adults only; `height`)
-   LDL (`ldl`)
-   Protein-creatinine ratio (`pcr`)
-   Systolic blood pressure (`sbp`)
-   Total cholesterol (`totalcholesterol`)
-   Triglycerides (`triglyceride`)
-   Weight (adults only; `weight`)

Example:

``` r
clean_sbp <- raw_sbp %>%
  clean_biomarker_values("sbp") %>%
  clean_biomarker_units("sbp")
```

### Cardiovascular risk score functions

Functions for calculating the following cardiovascular risk scores are included in this package, and can be used on local data (loaded into R) or data stored in MySQL:

-   QRISK2-2017

Example:

``` r
results <- dataframe %>%
  calculate_qrisk2(age = age_var,
                    sex = sex_var,
                    ethrisk = ethrisk_var,
                    town = town_var,
                    smoking = smoking_var,
                    fh_cvd = fh_cvd_var,
                    renal = renal_var,
                    af = af_var,
                    rheumatoid_arth=rheumatoid_arth_var,
                    bp_med = bp_med_var,
                    cholhdl = cholhdl_var,
                    sbp = sbp_var,
                    bmi = bmi_var,
                    type1 = type1_var,
                    type2 = type2_var,
                    surv = surv_var)
                    
                    
-   QDiabetes-Heart Failure 2015

Example:

``` r
results <- dataframe %>%
  calculate_qrisk2(age = age_var,
                    sex = sex_var,
                    ethrisk = ethrisk_var,
                    town = town_var,
                    smoking = smoking_var,
                    fh_cvd = fh_cvd_var,
                    renal = renal_var,
                    af = af_var,
                    rheumatoid_arth=rheumatoid_arth_var,
                    bp_med = bp_med_var,
                    cholhdl = cholhdl_var,
                    sbp = sbp_var,
                    bmi = bmi_var,
                    type1 = type1_var,
                    type2 = type2_var,
                    surv = surv_var)

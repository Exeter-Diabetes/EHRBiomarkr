# EHRBiomarkr

This package has various functions for cleaning and prcoessing biomarkers in EHR, especially in CPRD Aurum. All functions can be used on local data (loaded into R) or data stored in MySQL (by using the dbplyr package or another package which uses dbplyr e.g. [aurum](http://github.com/Exeter-Diabetes/CPRD-analysis-package)).

## Biomarker cleaning functions

Two functions for cleaning biomarker values are included in this package:

`clean_biomarker_values` removes values outside of plausible limits (run `biomarkerAcceptableLimits` to see limits, also our [CPRD-Codelists](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/main/Biomarkers/biomarker_acceptable_limits.txt) repository). Run `?biomarkerAcceptableLimits` for details of how these were ascertained and further explanation of variables. NB: biomarkers with more than one-commonly used unit must be converted to standard units (haematocrit: proportion between 0 and 1, haemoglobin: g/L, HbA1c: mmol/L).

`clean_biomarker_units` retains only values with appropriate unit codes (numunitid) or missing unit code in CPRD Aurum (run `biomarkerAcceptableLimits` to see appropriate unit codes, also our [CPRD-Codelists](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/main/Biomarkers/biomarker_acceptable_units.txt) repository). Run `?biomarkerAcceptableUnits` for details of how these were ascertained and further explanation of variables.

These functions can be applied to the following biomarkers:

-   Albumin-creatinine ratio (`acr`)
-   (Blood) albumin (`albumin_blood`)
-   Alanine aminotransferase (`alt`)
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
  clean_biomarker_values(biomrkr_col=testvalue, biomrkr="sbp") %>%
  clean_biomarker_units(numunitid_col=numunitid, biomrkr="sbp")
```
Further info on how we implement these functions as part of a CPRD Aurum processing pipeline can be found here: [CPRD-Codelists](https://github.com/Exeter-Diabetes/CPRD-Codelists#biomarker-algorithms).

&nbsp;

## eGFR from creatinine, age and sex using CKD-EPI Creatinine Equation (2021)

This function implements the [CKD-EPI Creatinine Equation (2021)](https://www.kidney.org/professionals/kdoqi/gfr_calculator/formula) equation to calculate eGFR from creatinine, age and sex. See help (`?ckd_epi_2021_egfr`) for further explanation of variables. 

Example:

``` r
clean_egfr_medcodes <- clean_creatinine_blood_medcodes %>%
  ckd_epi_2021_egfr(creatinine=testvalue, sex=sex, age_at_creatinine=age_at_creat)
```  

&nbsp;

## Cardiovascular risk score functions

Functions for calculating the following QRISK2 (2017) and QDiabetes-Heart Failure (2015) are included in this package. NB: both functions will calculate scores for individuals with values (e.g. age, BMI) outside of the range for which the model is valid without warning; these individuals need to be removed prior to using the functions. See help files (`?calculate_qrisk2` and `?calculate_qdiabeteshf`) for further explanation of variables. 

### QRISK2 (2017)

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
```  

&nbsp;

### QDiabetes-Heart Failure (2015)

Example:

``` r
results <- dataframe %>%
  calculate_qdiabeteshf(age = age_var
                        sex = sex_var,
                        ethrisk = ethrisk_var,
                        town = town_var,
                        smoking = smoking_var,
                        duration = diabetes_duration_var,
                        renal = renal_var,
                        af = af_var,
                        cvd = cvd_var,
                        hba1c = hba1c_var,
                        cholhdl = cholhdl_var,
                        sbp = sbp_var,
                        bmi = bmi_var,
                        type1 = type1_var,
                        surv = surv_var)
```


#' Calculates eGFR from creatinine, sex and age at creatinine reading using 2021 CKD-EPI Creatinine (https://www.mdcalc.com/calc/3939/ckd-epi-equations-glomerular-filtration-rate-gfr#evidence)
#' 
#' @description see above
#' @param dataset - dataset containing creatinine, sex, and age at creatinine reading
#' @param creatinine_col - column with creatinine reading in umol/L
#' @param sex_col - column with sex: "male" or "female"
#' @param age_at_creatinine_col - column with age at creatinine reading in years
#' @importFrom magrittr %>%
#' @importFrom dplyr mutate
#' @importFrom dplyr select
#' @export

ckd_epi_2021_egfr = function(dataset, creatinine_col, sex_col, age_at_creatinine_col) {
  
  creatinine_column <- as.symbol(deparse(substitute(creatinine_col)))
  sex_column <- as.symbol(deparse(substitute(sex_col)))
  age_at_creatinine_column <- as.symbol(deparse(substitute(age_at_creatinine_col)))
  
  new_dataset <- dataset %>%
    mutate(creatinine_mgdl=!!creatinine_column*0.0113) %>%
    mutate(ckd_epi_2021_egfr=ifelse(creatinine_mgdl<=0.7 & sex_column=="female",(142 * ((creatinine_mgdl/0.7)^-0.241) * (0.9938^age_at_creatinine_column) * 1.012),
                                    ifelse(creatinine_mgdl>0.7 & sex_column=="female",(142 * ((creatinine_mgdl/0.7)^-1.2) * (0.9938^age_at_creatinine_column) * 1.012),
                                           ifelse(creatinine_mgdl<=0.9 & sex_column=="male",(142 * ((creatinine_mgdl/0.9)^-0.302) * (0.9938^age_at_creatinine_column)),
                                                  ifelse(creatinine_mgdl>0.9 & sex_column=="male",(142 * ((creatinine_mgdl/0.9)^-1.2) * (0.9938^age_at_creatinine_column)),NA))))) %>%
    select(-creatinine_mgdl)
  
  message("New column 'ckd_epi_2021_egfr' added")
  
  return(new_dataset)
  
}

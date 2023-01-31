#' Clean biomarker units: only keep values with acceptable unit codes (includes missing unit code for all)
#' 
#' @description only keep measurements with 'acceptable' unit codes (numunitid) for specified biomarker
#' @param dataset - dataset containing biomarker observations
#' @param numunitid_col - name of column containing numunitid codes
#' @param biomrkr - name of biomarker to clean (acr/alt/ast/bmi/creatinine/dbp/fastingglucose/hba1c/hdl/height/ldl/pcr/sbp/smoking (for QRISK2)/totalcholesterol/triglyceride/weight)
#' @importFrom magrittr %>%
#' @importFrom stats setNames
#' @export

clean_biomarker_units = function(dataset, numunitid_col, biomrkr) {
  unit_codes <- data.frame(numunitid=unlist(lapply(EHRBiomarkr::biomarkerAcceptableUnits[biomrkr], function(y) lapply(y, as.numeric))))
  
  numunitid_column <- deparse(substitute(numunitid_col))
  
  return(
    dataset %>%
      dplyr::inner_join(
        unit_codes,
        by = setNames("numunitid", numunitid_column),
        na_matches="na",
        copy=TRUE
      ))
}


#' Clean biomarker values: only keep values within acceptable limits
#' 
#' @description only keep measurements within acceptable limits for specified biomarker
#' @param dataset - dataset containing biomarker observations
#' @param biomrkr_col - name of column containing biomarker values
#' @param biomrkr - name of biomarker to clean (acr/alt/ast/bmi/creatinine/dbp/fastingglucose/hba1c/hdl/height/ldl/pcr/sbp/totalcholesterol/triglyceride/weight)
#' @importFrom magrittr %>%
#' @export

clean_biomarker_values = function(dataset, biomrkr_col, biomrkr) {
  
  lower_limit <- unname(unlist(lapply(EHRBiomarkr::biomarkerAcceptableLimits[biomrkr], function(y) lapply(y, as.numeric)))[1])
  upper_limit <- unname(unlist(lapply(EHRBiomarkr::biomarkerAcceptableLimits[biomrkr], function(y) lapply(y, as.numeric)))[2])
  
  if (biomrkr=="haematocrit") {
    message("clean_biomarker_values will remove haematocrit values which are not in proportion out of 1")
  }
  if (biomrkr=="haemoglobin") {
    message("clean_biomarker_values will remove haemoglobin values which are not in g/L")
  }
  if (biomrkr=="hba1c") {
    message("clean_biomarker_values will remove HbA1c values which are not in mmol/mol")
  }
  if (biomrkr=="weight") {
    message("clean_biomarker_values uses weight limits for adults")
  }
  if (biomrkr=="height") {
    message("clean_biomarker_values uses height limits for adults")
  }
  message("Values <",lower_limit, ", >", upper_limit, " and missing values removed")
  
  biomrkr_column <- as.symbol(deparse(substitute(biomrkr_col)))
  
  return(
    dataset %>%
      dplyr::filter(!!biomrkr_column>=lower_limit & !!biomrkr_column<=upper_limit)
  )
}

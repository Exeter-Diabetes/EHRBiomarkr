#' Clean biomarker units: only keep values with acceptable unit codes (includes missing unit code for all)
#' 
#' @description only keep measurements with 'acceptable' unit codes (numunitid) for specified biomarker
#' @param dataset - dataset containing biomarker observations
#' @param biomrkr - name of biomarker to clean (acr/alt/ast/bmi/creatinine/dbp/fastingglucose/hba1c/hdl/height/ldl/pcr/sbp/smoking (for QRISK2)/totalcholesterol/triglyceride/weight)
#' @export

clean_biomarker_units = function(dataset, numunitid_col, biomrkr) {
  unit_codes <- data.frame(numunitid=unlist(lapply(aurum::biomarkerAcceptableUnits[biomrkr], function(y) lapply(y, as.numeric))))
  
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

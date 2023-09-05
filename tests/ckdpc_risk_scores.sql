use cprd_analysis_dev;

create table katie_ckd_score_test
(id varchar(20),
age_var INT,
sex_var char(6),
black_ethnicity_var BOOL NOT NULL default 0,
egfr_var INT,
cvd_var BOOL,
hba1c_var DECIMAL (5,2),
insulin_var BOOL,
oha_var BOOL,
ever_smoker_var BOOL,
hypertension_var BOOL,
bmi_var INT,
acr_var DECIMAL (4,1),
sbp_var INT,
bp_meds_var BOOL,
hf_var BOOL,
chd_var BOOL,
af_var BOOL,
current_smoker_var BOOL,
ex_smoker_var BOOL);

INSERT INTO katie_ckd_score_test (id, age_var, sex_var, black_ethnicity_var, egfr_var, cvd_var, hba1c_var, insulin_var, oha_var, ever_smoker_var, hypertension_var, bmi_var, acr_var, sbp_var, bp_meds_var, hf_var, chd_var, af_var, current_smoker_var, ex_smoker_var)
VALUES ("male1", 50, "male", 0, 70, 1, 91.3, 0, 0, 1, 1, 30, 22.6, 150, 1, 0, 1, 0, 1, 0);

INSERT INTO katie_ckd_score_test (id, age_var, sex_var, black_ethnicity_var, egfr_var, cvd_var, hba1c_var, insulin_var, oha_var, ever_smoker_var, hypertension_var, bmi_var, acr_var, sbp_var, bp_meds_var, hf_var, chd_var, af_var, current_smoker_var, ex_smoker_var)
VALUES ("male2", 50, "male", 0, 70, 1, 91.3, 0, 1, 1, 1, 30, 56.5, 150, 1, 1, 1, 0, 1, 0);

INSERT INTO katie_ckd_score_test (id, age_var, sex_var, black_ethnicity_var, egfr_var, cvd_var, hba1c_var, insulin_var, oha_var, ever_smoker_var, hypertension_var, bmi_var, acr_var, sbp_var, bp_meds_var, hf_var, chd_var, af_var, current_smoker_var, ex_smoker_var)
VALUES ("male3", 60, "male", 0, 70, 1, 91.3, 1, 0, 1, 1, 25, 56.5, 120, 1, 0, 1, 1, 1, 0);

INSERT INTO katie_ckd_score_test (id, age_var, sex_var, black_ethnicity_var, egfr_var, cvd_var, hba1c_var, insulin_var, oha_var, ever_smoker_var, hypertension_var, bmi_var, acr_var, sbp_var, bp_meds_var, hf_var, chd_var, af_var, current_smoker_var, ex_smoker_var)
VALUES ("male4", 70, "male", 0, 70, 1, 91.3, 1, 1, 1, 1, 23, 56.5, 110, 1, 0, 1, 1, 1, 1);

INSERT INTO katie_ckd_score_test (id, age_var, sex_var, black_ethnicity_var, egfr_var, cvd_var, hba1c_var, insulin_var, oha_var, ever_smoker_var, hypertension_var, bmi_var, acr_var, sbp_var, bp_meds_var, hf_var, chd_var, af_var, current_smoker_var, ex_smoker_var)
VALUES ("male5", 80, "male", 0, 70, 1, 91.3, 1, 1, 0, 1, 35, 56.5, 150, 0, 0, 0, 0, 1, 0);

INSERT INTO katie_ckd_score_test (id, age_var, sex_var, black_ethnicity_var, egfr_var, cvd_var, hba1c_var, insulin_var, oha_var, ever_smoker_var, hypertension_var, bmi_var, acr_var, sbp_var, bp_meds_var, hf_var, chd_var, af_var, current_smoker_var, ex_smoker_var)
VALUES ("male6", 50, "male", 0, 70, 1, 91.3, 1, 1, 1, 1, 21, 0.6, 180, 1, 0, 1, 0, 0, 0);

INSERT INTO katie_ckd_score_test (id, age_var, sex_var, black_ethnicity_var, egfr_var, cvd_var, hba1c_var, insulin_var, oha_var, ever_smoker_var, hypertension_var, bmi_var, acr_var, sbp_var, bp_meds_var, hf_var, chd_var, af_var, current_smoker_var, ex_smoker_var)
VALUES ("male7", 50, "male", 1, 70, 1, 91.3, 1, 0, 1, 1, 29, 5.7, 170, 1, 1, 1, 0, 0, 0);

INSERT INTO katie_ckd_score_test (id, age_var, sex_var, black_ethnicity_var, egfr_var, cvd_var, hba1c_var, insulin_var, oha_var, ever_smoker_var, hypertension_var, bmi_var, acr_var, sbp_var, bp_meds_var, hf_var, chd_var, af_var, current_smoker_var, ex_smoker_var)
VALUES ("male8", 50, "male", 0, 80, 1, 91.3, 1, 1, 1, 1, 30, 5.7, 150, 0, 0, 0, 1, 1, 1);

INSERT INTO katie_ckd_score_test (id, age_var, sex_var, black_ethnicity_var, egfr_var, cvd_var, hba1c_var, insulin_var, oha_var, ever_smoker_var, hypertension_var, bmi_var, acr_var, sbp_var, bp_meds_var, hf_var, chd_var, af_var, current_smoker_var, ex_smoker_var)
VALUES ("male9", 50, "male", 0, 70, 0, 91.3, 1, 1, 0, 1, 30, NULL, 150, 1, 0, 1, 1, 1, 0);

INSERT INTO katie_ckd_score_test (id, age_var, sex_var, black_ethnicity_var, egfr_var, cvd_var, hba1c_var, insulin_var, oha_var, ever_smoker_var, hypertension_var, bmi_var, acr_var, sbp_var, bp_meds_var, hf_var, chd_var, af_var, current_smoker_var, ex_smoker_var)
VALUES ("male10", 50, "male", 0, 70, 1, 42.1, 0, 1, 1, 0, 30, 5.7, 150, 1, 1, 1, 0, 0, 0);

INSERT INTO katie_ckd_score_test (id, age_var, sex_var, black_ethnicity_var, egfr_var, cvd_var, hba1c_var, insulin_var, oha_var, ever_smoker_var, hypertension_var, bmi_var, acr_var, sbp_var, bp_meds_var, hf_var, chd_var, af_var, current_smoker_var, ex_smoker_var)
VALUES ("female1", 50, "female", 0, 70, 1, 91.3, 0, 0, 1, 1, 30, 22.6, 150, 1, 0, 1, 0, 1, 0);

INSERT INTO katie_ckd_score_test (id, age_var, sex_var, black_ethnicity_var, egfr_var, cvd_var, hba1c_var, insulin_var, oha_var, ever_smoker_var, hypertension_var, bmi_var, acr_var, sbp_var, bp_meds_var, hf_var, chd_var, af_var, current_smoker_var, ex_smoker_var)
VALUES ("female2", 50, "female", 0, 70, 1, 91.3, 0, 1, 1, 1, 30, 56.5, 150, 1, 1, 1, 0, 1, 0);

INSERT INTO katie_ckd_score_test (id, age_var, sex_var, black_ethnicity_var, egfr_var, cvd_var, hba1c_var, insulin_var, oha_var, ever_smoker_var, hypertension_var, bmi_var, acr_var, sbp_var, bp_meds_var, hf_var, chd_var, af_var, current_smoker_var, ex_smoker_var)
VALUES ("female3", 60, "female", 0, 70, 1, 91.3, 1, 0, 1, 1, 25, 56.5, 120, 1, 0, 1, 1, 1, 0);

INSERT INTO katie_ckd_score_test (id, age_var, sex_var, black_ethnicity_var, egfr_var, cvd_var, hba1c_var, insulin_var, oha_var, ever_smoker_var, hypertension_var, bmi_var, acr_var, sbp_var, bp_meds_var, hf_var, chd_var, af_var, current_smoker_var, ex_smoker_var)
VALUES ("female4", 70, "female", 0, 70, 1, 91.3, 1, 1, 1, 1, 23, 56.5, 110, 1, 0, 1, 1, 1, 1);

INSERT INTO katie_ckd_score_test (id, age_var, sex_var, black_ethnicity_var, egfr_var, cvd_var, hba1c_var, insulin_var, oha_var, ever_smoker_var, hypertension_var, bmi_var, acr_var, sbp_var, bp_meds_var, hf_var, chd_var, af_var, current_smoker_var, ex_smoker_var)
VALUES ("female5", 80, "female", 0, 70, 1, 91.3, 1, 1, 0, 1, 35, 56.5, 150, 0, 0, 0, 0, 1, 0);

INSERT INTO katie_ckd_score_test (id, age_var, sex_var, black_ethnicity_var, egfr_var, cvd_var, hba1c_var, insulin_var, oha_var, ever_smoker_var, hypertension_var, bmi_var, acr_var, sbp_var, bp_meds_var, hf_var, chd_var, af_var, current_smoker_var, ex_smoker_var)
VALUES ("female6", 50, "female", 0, 70, 1, 91.3, 1, 1, 1, 1, 21, 0.6, 180, 1, 0, 1, 0, 0, 0);

INSERT INTO katie_ckd_score_test (id, age_var, sex_var, black_ethnicity_var, egfr_var, cvd_var, hba1c_var, insulin_var, oha_var, ever_smoker_var, hypertension_var, bmi_var, acr_var, sbp_var, bp_meds_var, hf_var, chd_var, af_var, current_smoker_var, ex_smoker_var)
VALUES ("female7", 50, "female", 1, 70, 1, 91.3, 1, 0, 1, 1, 29, 5.7, 170, 1, 1, 1, 0, 0, 0);

INSERT INTO katie_ckd_score_test (id, age_var, sex_var, black_ethnicity_var, egfr_var, cvd_var, hba1c_var, insulin_var, oha_var, ever_smoker_var, hypertension_var, bmi_var, acr_var, sbp_var, bp_meds_var, hf_var, chd_var, af_var, current_smoker_var, ex_smoker_var)
VALUES ("female8", 50, "female", 0, 80, 1, 91.3, 1, 1, 1, 1, 30, 5.7, 150, 0, 0, 0, 1, 1, 1);

INSERT INTO katie_ckd_score_test (id, age_var, sex_var, black_ethnicity_var, egfr_var, cvd_var, hba1c_var, insulin_var, oha_var, ever_smoker_var, hypertension_var, bmi_var, acr_var, sbp_var, bp_meds_var, hf_var, chd_var, af_var, current_smoker_var, ex_smoker_var)
VALUES ("female9", 50, "female", 0, 70, 0, 91.3, 1, 1, 0, 1, 30, NULL, 150, 1, 0, 1, 1, 1, 0);

INSERT INTO katie_ckd_score_test (id, age_var, sex_var, black_ethnicity_var, egfr_var, cvd_var, hba1c_var, insulin_var, oha_var, ever_smoker_var, hypertension_var, bmi_var, acr_var, sbp_var, bp_meds_var, hf_var, chd_var, af_var, current_smoker_var, ex_smoker_var)
VALUES ("female10", 50, "female", 0, 70, 1, 42.1, 0, 1, 1, 0, 30, 5.7, 150, 1, 1, 1, 0, 0, 0);





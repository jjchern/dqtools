
library(tidyverse)
library(vroom)

# Links to raw files from DQ Atlas --------------------------------------------

# tribble(
#   ~Topic, ~Year, ~URL,
#   "Diagnosis Code - IP",  2020, "https://www.medicaid.gov/dq-atlas/downloads/data_by_year/2020/Preliminary_1/TAF_DQ_Diagnosis_Cd_IP_2020_Preliminary_1.csv",
#   "Procedure Codes - IP", 2020, "https://www.medicaid.gov/dq-atlas/downloads/data_by_year/2020/Preliminary_1/TAF_DQ_Proc_Cd_IP_2020_Preliminary_1.csv",
#   "Type of Service - IP", 2020, "https://www.medicaid.gov/dq-atlas/downloads/data_by_year/2020/Preliminary_1/TAF_DQ_Type_of_Service_IP_2020_Preliminary_1.csv",
#   "Admission Date - IP",  2020, "https://www.medicaid.gov/dq-atlas/downloads/data_by_year/2020/Preliminary_1/TAF_DQ_Admission_Date_IP_2020_Preliminary_1.csv"
# ) |>
#   print() -> topic_year_url

raw_ip_2020_diag_cd  = "https://www.medicaid.gov/dq-atlas/downloads/data_by_year/2020/Preliminary_1/TAF_DQ_Diagnosis_Cd_IP_2020_Preliminary_1.csv"
raw_ip_2020_proc_cd  = "https://www.medicaid.gov/dq-atlas/downloads/data_by_year/2020/Preliminary_1/TAF_DQ_Proc_Cd_IP_2020_Preliminary_1.csv"
raw_ip_2020_tos      = "https://www.medicaid.gov/dq-atlas/downloads/data_by_year/2020/Preliminary_1/TAF_DQ_Type_of_Service_IP_2020_Preliminary_1.csv"
raw_ip_2020_admsn_dt = "https://www.medicaid.gov/dq-atlas/downloads/data_by_year/2020/Preliminary_1/TAF_DQ_Admission_Date_IP_2020_Preliminary_1.csv"

# Topic-Variable Crosswalk files ------------------------------------------
# Note, the primary variable for "Diagnosis Code - IP" is DGNS_CD_1

bind_rows(
  list(Topic = "Diagnosis Code - IP",
       Variable = c("ADMTG_DGNS_CD",
                    "DGNS_CD_1", "DGNS_CD_2", "DGNS_CD_3", "DGNS_CD_4",
                    "DGNS_CD_5", "DGNS_CD_6", "DGNS_CD_7", "DGNS_CD_8",
                    "DGNS_CD_9", "DGNS_CD_10", "DGNS_CD_11", "DGNS_CD_12")) |> as_tibble(),

  list(Topic = "Procedure Codes - IP",
       Variable = c("PRCDR_CD_1", "PRCDR_CD_2", "PRCDR_CD_3",
                    "PRCDR_CD_4", "PRCDR_CD_5", "PRCDR_CD_6")) |> as_tibble(),

  list(Topic = "Type of Service - IP",
       Variable = "TOS_CD") |> as_tibble(),

  list(Topic = "Admission Date - IP",
       Variable = "ADMSN_DT")
) |> print() -> topic_variable

# Prepare state-year-variable level assessment ----------------------------

vroom(raw_ip_2020_diag_cd, skip = 4) |>
  select(State, `Data Year`, `DQ Assessment`) |>
  mutate(Topic = "Diagnosis Code - IP") |>
  inner_join(topic_variable) |>
  select(State, `Data Year`, Variable, Topic, `DQ Assessment`) |>
  print() -> ip_2020_diag_cd

vroom(raw_ip_2020_proc_cd, skip = 4) |>
  select(State, `Data Year`, `DQ Assessment`) |>
  mutate(Topic = "Procedure Codes - IP") |>
  inner_join(topic_variable) |>
  select(State, `Data Year`, Variable, Topic, `DQ Assessment`) |>
  print() -> ip_2020_proc_cd

vroom(raw_ip_2020_tos, skip = 4) |>
  select(State, `Data Year`, `DQ Assessment`) |>
  mutate(Topic = "Type of Service - IP") |>
  inner_join(topic_variable) |>
  select(State, `Data Year`, Variable, Topic, `DQ Assessment`) |>
  print() -> ip_2020_tos

read_csv(raw_ip_2020_admsn_dt, skip = 4) |>
  select(State, `Data Year`, `DQ Assessment`) |>
  mutate(Topic = "Admission Date - IP") |>
  inner_join(topic_variable) |>
  select(State, `Data Year`, Variable, Topic, `DQ Assessment`) |>
  print() -> ip_2020_admsn_dt

# Stack all files ---------------------------------------------------------

bind_rows(
  ip_2020_diag_cd,
  ip_2020_proc_cd,
  ip_2020_tos,
  ip_2020_admsn_dt
) |>
  print() -> dq_ip_file

dq_ip_file |> count(Topic)
dq_ip_file |> count(Variable)

usethis::use_data(dq_ip_file, overwrite = TRUE)

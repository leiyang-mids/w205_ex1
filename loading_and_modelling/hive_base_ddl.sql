-- to display column name in the query
set hive.cli.print.header=true;

-- external table for effective_care.csv
drop table e_effective;
create external table e_effective (
  Provider_ID string,  Hospital_Name string,
  Address string,  City string,  State string,  ZIP string,
  County string,  Phone string,
  Condition string,
  Measure_ID string,  Measure_Name string,
  Score string,
  Sample string,
  Footnote string,
  Start_Date string,  End_Date string)
row format delimited
fields terminated by ','
stored as textfile
location '/user/w205/hospital_compare/effective_csv';

-- external table for hospitals.csv
drop table e_hospital;
create external table e_hospital (
  ID string,  Name string,
  Address string,  City string,  State string,  ZIP string,
  County string,  Phone string,
  Type string,
  Ownership string,
  Emergency string
)
row format delimited
fields terminated by ','
stored as textfile
location '/user/w205/hospital_compare/hospital_csv';

-- external table for measure_dates.csv
drop table e_measure;
create external table e_measure (
  Name string, ID string,
  Start_Qt string, Start_Date string,
  End_Qt string, End_Date string
)
row format delimited
fields terminated by ','
stored as textfile
location '/user/w205/hospital_compare/measure_csv';

-- external table for Readmissions.csv
drop table e_readmission;
create external table e_readmission (
  ID string,  Name string,
  Address string,  City string,  State string,  ZIP string,
  County string,  Phone string,
  Measure_Name string, Measure_ID string,
  Compared_National string,  Denominator string,
  Score string, Low_Est string, High_Est string,
  Footnote string,
  Start_Date string, End_Date string
)
row format delimited
fields terminated by ','
stored as textfile
location '/user/w205/hospital_compare/readmission_csv';

-- external table for survey.csv
drop table e_survey;
create external table e_survey (
  Provider_ID string,Hospital_Name string,
  Address string, City string, State string, ZIP string, County string,
  Com_Nur_Ach string,
  Com_Nur_Imp string,
  Com_Nur_Dim string,
  Com_Doc_Ach string,
  Com_Doc_Imp string,
  Com_Doc_Dim string,
  Res_Staff_Ach string,
  Res_Staff_Imp string,
  Res_Staff_Dim string,
  Pain_Mgmt_Ach string,
  Pain_Mgmt_Imp string,
  Pain_Mgmt_Dim string,
  Com_Meds_Ach string,
  Com_Meds_Imp string,
  Com_Meds_Dim string,
  CQ_Env_Ach string,
  CQ_Env_Imp string,
  CQ_Env_Dim string,
  Dis_Info_Ach string,
  Dis_Info_Imp string,
  Dis_Info_Dim string,
  Overall_Ach_Pts string,
  Overall_Imp_Pts string,
  Overall_Dim_Score string,
  HCAHPS_Base_Score string,
  HCAHPS_Consistency_Score string
)
row format delimited
fields terminated by ','
stored as textfile
location '/user/w205/hospital_compare/survey_csv';

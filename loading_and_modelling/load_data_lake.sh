#! /bin/bash

echo "# create local folder to download and store the data"
mkdir /data/lei_ex1
cd /data/lei_ex1

echo "# download and unzip the data"
wget https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip

wait

unzip Nqc*

echo "# get rid of header and rename files"
tail -n +2 "Hospital General Information.csv" > "hospitals1.csv"
tail -n +2 "Timely and Effective Care - Hospital.csv" > "effective_care1.csv"
tail -n +2 "Readmissions and Deaths - Hospital.csv" > "readmissions1.csv"
tail -n +2 "Measure Dates.csv" > "measure_dates1.csv"
tail -n +2 "hvbp_hcahps_05_28_2015.csv" > "surveys_responses1.csv"

echo "# get rid of double quotes in the file to facilitate format castting when define Hive table"
sed 's/\"//g' hospitals1.csv > hospitals.csv
sed 's/\"//g' effective_care1.csv > effective_care.csv
sed 's/\"//g' readmissions1.csv > readmissions.csv
sed 's/\"//g' measure_dates1.csv > measure_dates.csv
sed 's/\"//g' surveys_responses1.csv > surveys_responses.csv

echo "# create /user/w205/hospital_compare folder in HDFS"
hdfs dfs -rm -r /user/w205/hospital_compare
hdfs dfs -mkdir /user/w205/hospital_compare
hdfs dfs -mkdir /user/w205/hospital_compare/hospital_csv
hdfs dfs -mkdir /user/w205/hospital_compare/effective_csv
hdfs dfs -mkdir /user/w205/hospital_compare/readmission_csv
hdfs dfs -mkdir /user/w205/hospital_compare/measure_csv
hdfs dfs -mkdir /user/w205/hospital_compare/survey_csv

echo "# load the raw data files into HDFS under /user/w205/hospital_compare"
# separate csv folder to facilitate creating external table
hdfs dfs -put hospitals.csv /user/w205/hospital_compare/hospital_csv/hospitals.csv
hdfs dfs -put effective_care.csv /user/w205/hospital_compare/effective_csv/effective_care.csv
hdfs dfs -put readmissions.csv /user/w205/hospital_compare/readmission_csv/readmissions.csv
hdfs dfs -put measure_dates.csv /user/w205/hospital_compare/measure_csv/measure_dates.csv
hdfs dfs -put surveys_responses.csv /user/w205/hospital_compare/survey_csv/surveys_responses.csv

echo "# data loading successfully completed!"


echo "# remove local folder"
cd ..
rm /data/lei_ex1 -r
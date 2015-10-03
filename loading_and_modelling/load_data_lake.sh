#! /bin/bash

echo "# create local folder to download and store the data\n"
mkdir /data/lei_ex1
cd /data/lei_ex1

echo "# download and unzip the data\n"
wget https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip

wait

unzip Nqc*

echo "# get rid of header and rename files"
tail -n +2 "Hospital General Information.csv" > "hospitals.csv"
tail -n +2 "Timely and Effective Care - Hospital.csv" > "effective_care.csv"
tail -n +2 "Readmissions and Deaths - Hospital.csv" > "readmissions.csv"
tail -n +2 "Measure Dates.csv" > "measure_dates.csv"
tail -n +2 "hvbp_hcahps_05_28_2015.csv" > "surveys_responses.csv"

echo "# create /user/w205/hospital_compare folder in HDFS"
hdfs dfs -mkdir /user/w205/hospital_compare

echo "# load the raw data files into HDFS under /user/w205/hospital_compare"
hdfs dfs -put hospitals.csv /user/w205/hospital_compare/hospitals.csv
hdfs dfs -put effective_care.csv /user/w205/hospital_compare/effective_care.csv
hdfs dfs -put readmissions.csv /user/w205/hospital_compare/readmissions.csv
hdfs dfs -put measure_dates.csv /user/w205/hospital_compare/measure_dates.csv
hdfs dfs -put surveys_responses.csv /user/w205/hospital_compare/surveys_responses.csv

echo "# data loading successfully completed!"
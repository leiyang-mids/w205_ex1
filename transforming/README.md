Data transforming scripts:

1. Entity tables (hospital, measure) are created by directly reading from their corresponding external table.
2. Relation tables (effective care, survey, readmission) are created by joinning the with the entity tables to ensure the foreign keys are valid
3. It was the intention to define a Python UDF to transform "x out of y" entries in the survey table into numerical value x/y, but I was unsuccessful in calling Python from Hive, instead had to write an ugly SQL for the conversion. Need to debug more on the Python UDF issue.
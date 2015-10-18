Assumptions:

1. Based on ER diagram, we choose hospital and measure table as entities, and hospital ID and measure ID are the primary keys.
2. It is observed that from the 3 relation tables, there are entries whose hospital ID and/or measure ID are not present in the entity table, for those rows, we consider them invalid. 
3. By using inner join, we effectively exclude invalid rows to form the transformed table.

Data transforming scripts:

1. Entity tables (hospital, measure) are created by directly reading from their corresponding external table.
2. Relation tables (effective care, survey, readmission) are created by joining the with the entity tables to ensure the foreign keys are valid
3. It was the intention to define a Python UDF (GetScore.py) to transform "x out of y" entries in the survey table into a numerical value x/y, but I was unsuccessful in calling Python from Hive, instead had to write an ugly SQL for the conversion. Need to debug more on the Python UDF issue.

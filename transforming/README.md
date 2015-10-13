Data transforming scripts:

Entity tables (hospital, measure) are created by directly reading from their corresponding external table.
Relation tables (effective care, survey, readmission) are created by joinning the with the entity tables to ensure the foreign keys are valid

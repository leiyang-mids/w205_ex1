Assumptions:

1. w205 super user exists, and has the execution right on shell script;
2. local directory /data exists;
3. hdfs directory /user/w205 exists;

Notes:

1. e_<tableName> indicates an external table
2. m_<tableName> indicates a managed table
3. all external tables are using string type for each column in the file, to keep all data available for exploration
4. managed table will define different variable type as appropriate

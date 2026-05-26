CREATE DATABASE IF NOT EXISTS sql_course;

SELECT COUNT(*) FROM company_dim;
SELECT COUNT(*) FROM skills_dim;
SELECT COUNT(*) FROM job_postings_fact;
SELECT COUNT(*) FROM skills_job_dim;

SELECT '2023-02-19' :: DATE;
SELECT * from january_jobs;
SELECT * from february_jobs;
SELECT * from march_jobs;

SELECT 
job_title_short,
company_id,
job_location
FROM
january_jobs
UNION
SELECT
job_title_short,
company_id,
job_location
FROM
february_jobs

UNION
SELECT
job_title_short,
company_id,
job_location
FROM
march_jobs;

--Union ALL does not remove duplicates, while Union does. In this case, we want to keep all records, so we use Union ALL
SELECT 
job_title_short,
company_id,
job_location
FROM
january_jobs
UNION ALL
SELECT
job_title_short,
company_id,
job_location
FROM
february_jobs

UNION ALL
SELECT
job_title_short,
company_id,
job_location
FROM
march_jobs;

-- problem 8

SELECT 
quarter1_job_postings.job_title_short,
quarter1_job_postings.job_location,
quarter1_job_postings.job_via,
quarter1_job_postings.job_posted_date::date,
quarter1_job_postings.salary_year_avg
FROM (
SELECT *
FROM january_jobs
union all
SELECT *
FROM february_jobs  
union all
SELECT *
FROM march_jobs
) AS quarter1_job_postings
WHERE
quarter1_job_postings.salary_year_avg > 70000 AND
quarter1_job_postings.job_title_short = 'Data Analyst'
ORDER BY quarter1_job_postings.salary_year_avg DESC;
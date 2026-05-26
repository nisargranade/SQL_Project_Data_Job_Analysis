SELECT 
job_title_short AS title,
job_location AS location,
job_posted_date::DATE AS posted_date
FROM job_postings_fact;


SELECT 
job_title_short AS title,
job_location AS location,
job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS posted_date,
EXTRACT(MONTH FROM job_posted_date) AS month_applied
FROM job_postings_fact;

select
count(job_id) AS job_count,
EXTRACT(MONTH FROM job_posted_date) AS month
FROM
job_postings_fact
WHERE
job_title_short = 'Data Analyst'
GROUP BY month
ORDER BY
job_count DESC;


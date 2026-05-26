CREATE TABLE january_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- Create February jobs table
CREATE TABLE february_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- Create March jobs table
CREATE TABLE march_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT
job_title_short,
job_location,
CASE
    WHEN job_location = 'Anywhere' THEN 'Remote'
    WHEN job_location = 'New York, NY' THEN 'Local'
    ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact;

SELECT
COUNT(job_id) AS number_of_jobs,
CASE
    WHEN job_location = 'Anywhere' THEN 'Remote'
    WHEN job_location = 'New York, NY' THEN 'Local'
    ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category;

SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1    
) AS january_jobs;

SELECT 
company_id,
name AS company_name
FROM 
company_dim
Where 
company_id IN (
SELECT
company_id
FROM
job_postings_fact
WHERE job_no_degree_mention = TRUE
);


WITH company_job_count AS (
SELECT 
company_id,
count(*) AS total_jobs
FROM
job_postings_fact
GROUP BY
company_id
)

SELECT 
company_dim.name AS company_name,
company_job_count.total_jobs
FROM company_dim
left join company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
total_jobs DESC;

-- problem 7
-- Count how many remote jobs require each skill
WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim AS skills_to_job

    -- Match skills to job postings
    INNER JOIN job_postings_fact AS job_postings
        ON job_postings.job_id = skills_to_job.job_id

    -- Only remote jobs
    WHERE job_postings.job_work_from_home = TRUE AND
    job_postings.job_title_short = 'Data Analyst'

    -- Count per skill
    GROUP BY skill_id
)

-- Get skill names with counts
SELECT 
    skills.skill_id,
    skills.skills AS skill_name,
    remote_job_skills.skill_count

FROM remote_job_skills

-- Join to skills table for readable skill names
INNER JOIN skills_dim AS skills
    ON skills.skill_id = remote_job_skills.skill_id

-- Show most in-demand remote skills first
ORDER BY remote_job_skills.skill_count DESC;


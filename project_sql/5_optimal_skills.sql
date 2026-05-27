WITH skills_demand AS (
    
    SELECT 
        skills_dim.skills,
        skills_dim.skill_id,
        count(skills_job_dim.job_id) as demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short ='Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    GROUP BY skills_dim.skill_id
    LIMIT 5
),average_salary AS (
    SELECT 
        skills_dim.skills,
        skills_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS average_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short ='Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    GROUP BY skills_dim.skill_id
    LIMIT 25
    )

SELECT
    skills_demand.skills,
    skills_demand.skill_id,
    average_salary.average_salary,
    skills_demand.demand_count
FROM skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
ORDER BY 
    demand_count DESC,
    average_salary.average_salary DESC;
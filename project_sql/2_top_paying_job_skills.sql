/*
Question: what are the sklls for the top highest-paying DA jobs?
-why? it provides a detailed look at which high paying jobs demand certain skills, helping jib_seekers understand which skilss to develop that align woth top salaries
*/ 
 
WITH top_paying_jobs AS(
    SELECT
    job_postings_fact.job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
   company_dim.name AS company_name

FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id

WHERE 
    job_title_short ='Data Analyst'  AND
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 20

)

SELECT top_paying_jobs.*,
    skills
from top_paying_jobs

INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id


/* this didnt work beacuse i used INNER JOIN instead of LEFT JOIN*/


WITH top_paying_jobs AS (
    SELECT
        job_postings_fact.job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        company_dim.name AS company_name
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND  
        salary_year_avg IS NOT NULL
    ORDER BY 
        salary_year_avg DESC
    LIMIT 20
)
SELECT top_paying_jobs.*,
       skills
FROM top_paying_jobs
LEFT JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id;


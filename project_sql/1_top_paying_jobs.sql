/*
Question: what are the top paying data analyst jobs?
-identify the top highest-paying DA jobs that re available remotely
-foces on job postibgs with sppecified salary
-why? hughloght the top-paying opporrutnity fo DA offering insghts into better emolpyment opportunities
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    job_postings_fact.company_id,
   company_dim.name AS company_name 
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    (job_title_short ='Data Analyst' OR job_title_short ='Data Scientist')  AND job_location = 'Anywhere' AND salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 20

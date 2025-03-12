 /*
Question: what are the most optimalskills to learn?
-why? targets skillls that offer job security (high demand) offering insights for carrer developpment in DA)
*/


with skills_demand AS (
    SELECT 
        skills_dim.skills,
       skills_dim.skill_id,
    COUNT(skills_job_dim.job_id) AS demand_count
    FROM
        job_postings_fact
    LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data analyst' 
    GROUP BY
        skills_dim.skill_id
    limit 10 
), average_salary AS (
    SELECT 
        skills_dim.skills,
        skills_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM
        job_postings_fact

    left JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    left JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data analyst' AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
    limit 10
)
SELECT
    skills_demand.skill_id,
    average_salary.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
ORDER BY
demand_count DESC,
avg_salary DESC
LIMIT 20



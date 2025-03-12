/*
Question: what are the top skills based on salary?
-why? it reveals how different skills impact salary levels for DA and help indentify the most financially rewarding skills to acquire or improve
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact

left JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
left JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data analyst' AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
limit 10

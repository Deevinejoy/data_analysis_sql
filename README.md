## 📊 Data Analyst Job Market Exploration

##



## Introduction



Dive into the data job market! This project focuses on data analyst roles, exploring 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.




## Background

Driven by a quest to navigate the **data analyst job market** more effectively, this project was created to pinpoint **top-paid** and **in-demand skills**, streamlining job searches.

📌 **Data Source:** Extracted from my SQL Course, containing insights on **job titles, salaries, locations, and essential skills**.

### Key Questions Answered

- What are the **top-paying data analyst jobs**?
- What **skills** are required for these top-paying jobs?
- What **skills are most in demand** for data analysts?
- Which **skills are associated with higher salaries**?
- What are the **most optimal skills to learn**?

### Tools Used 🛠️

- **SQL**: The backbone of the analysis
- **PostgreSQL**: The database management system
- **Visual Studio Code**: For writing and executing SQL queries
- **Git & GitHub**: Version control and collaboration

---

## 🔍 The Analysis

Each query was designed to investigate specific aspects of the **data analyst job market**.

### **1️⃣ Top-Paying Data Analyst Jobs**

To identify the highest-paying roles, I filtered job postings based on **average yearly salary** and **location**.

#### **SQL Query:**

```sql
SELECT	
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

#### **Key Insights:**

📌 **Salary Range:** Top 10 salaries range from **\$184,000 to \$650,000**
📌 **Diverse Employers:** Companies like **SmartAsset, Meta, and AT&T** offer high salaries
📌 **Varied Job Titles:** Roles span from **Data Analyst** to **Director of Analytics**

### **2️⃣ Skills for Top-Paying Jobs**

To determine what **skills** are required for the highest-paying jobs, I joined job postings with the skills dataset.

#### **SQL Query:**

```sql
WITH top_paying_jobs AS (
    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```

#### **Key Insights:**

✅ **Most Required Skills:**

- **SQL** (8 mentions)
- **Python** (7 mentions)
- **Tableau** (6 mentions)

### **3️⃣ Most In-Demand Skills for Data Analysts**

This query identifies the most frequently requested skills in job postings.

#### **SQL Query:**

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```

#### **Top 5 Most In-Demand Skills:**

| Skill    | Demand Count |
| -------- | ------------ |
| SQL      | 7,291        |
| Excel    | 4,611        |
| Python   | 4,330        |
| Tableau  | 3,745        |
| Power BI | 2,609        |

### **4️⃣ Skills Based on Salary**

This query examines the **average salaries** associated with different skills.

#### **SQL Query:**

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```

#### **Top 5 Highest Paying Skills:**

| Skill     | Average Salary (\$) |
| --------- | ------------------- |
| PySpark   | 208,172             |
| Bitbucket | 189,155             |
| Couchbase | 160,515             |
| Watson    | 160,515             |
| DataRobot | 155,486             |

### **5️⃣ Most Optimal Skills to Learn**

To determine which skills are both **in high demand** and **high-paying**, I ran this query:

#### **SQL Query:**

```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

#### **Top 5 Most Optimal Skills:**

| Skill      | Demand Count | Average Salary (\$) |
| ---------- | ------------ | ------------------- |
| Go         | 27           | 115,320             |
| Confluence | 11           | 114,210             |
| Hadoop     | 22           | 113,193             |
| Snowflake  | 37           | 112,948             |
| Azure      | 34           | 111,225             |

---

## 📌 Conclusions

- **SQL is the most in-demand skill** for data analysts
- **High-paying skills** include PySpark, Bitbucket, and Couchbase
- **Learning SQL, Python, and Cloud-based tools** (AWS, Snowflake) will boost job opportunities

This project **enhanced my SQL skills** and provided valuable insights into the job market. 🚀

---

📂 **Project SQL Files:** [Check them out here](./project_sql)


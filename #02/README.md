# Data Science Skills
Company - LinkedIn

#### Question

Given a table of candidates and their skills, you're tasked with finding the candidates best suited for an open Data Science job. You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.

Write a query to list the candidates who possess all of the required skills for the job. Sort the output by candidate ID in ascending order.

Assumption: There are no duplicates in the `candidate` table.

`Table: candidates`

**Data Structure**

```
candidate_id:   int
skill:         varchar
```

**Approach**

Let's start by looking at the data from a table. 

```
SELECT *
FROM candidates;
```

| candidate_id | skill      |
| ------------ | ---------- |
| 123          | Python     |
| 123          | Tableau    |
| 123          | PostgreSQL |
| 234          | R          |
| 234          | PowerBI    |

We need to find candidates who know Python, Tableau, and PostgreSQL. We start by using `IN` operator to find candidates with the required skills.

```
SELECT candidate_id,
       skill
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL');
```

| candidate_id | skill      |
| ------------ | ---------- |
| 123          | Python     |
| 123          | Tableau    |
| 123          | PostgreSQL |

Assuming there are no duplicates in the table. The table contains candidates with skills specified in the above list. However, we need to find a candidate with all three skills.
Now, Let's find a count of skills by each candidate; For that, we can use the `COUNT` function on skills by using `GROUP BY` clause on `candidate_id`.

```
SELECT 
    candidate_id
    COUNT(skill) as skill_count
FROM 
    candidates
GROUP BY candidate_id;
```

| candidate_id | skill_count |
| ------------ | ----------- |
| 123          | 3           |
| 345          | 2           |

As we need a candidate with all three skills, we only select candidates with count three using the `HAVING` clause.

```
SELECT 
    candidate_id
FROM 
    candidates
GROUP BY candidate_id
HAVING COUNT(skill) = 3
ORDER BY candidate_id;
```

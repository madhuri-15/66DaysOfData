-- PostgreSQL
-- Write a query to list the candidates who possess all of the required skills for the job. Sort the output by candidate ID in ascending order.
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY 
    candidate_id
HAVING 
    COUNT(skill) = 3
ORDER BY candidate_id;

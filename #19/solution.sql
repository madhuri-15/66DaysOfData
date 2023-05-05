-- PostgreSQL
-- You have been asked to find the job titles of the highest-paid employees.
-- Your output should include the highest-paid title or multiple titles with the same salary.
SELECT worker_title AS best_paid_title 
  FROM worker w
  JOIN title t
    ON w.worker_id = t.worker_ref_id
 WHERE 
      salary IN (SELECT MAX(salary) FROM worker)
ORDER BY 
    salary DESC; 

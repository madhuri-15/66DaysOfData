-- PostgreSQL
-- Find employees who are earning more than their managers. 
-- Output the employee's first name along with the corresponding salary.

SELECT 
     a.first_name AS employee_name,
     a.salary AS employee_salary
FROM employee as a
JOIN employee as b 
  ON a.manager_id = b.id
WHERE 
     a.salary > b.salary; 

-- PostgreSQL
-- Find the current salary of employee with all other information of employees.

SELECT DISTINCT(id),
       first_name,
       last_name,
       department_id, 
       MAX(salary) OVER(PARTITION BY id) AS salary
FROM ms_employee_salary
ORDER BY id;

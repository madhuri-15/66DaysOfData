-- PostgreSQL
-- Find the employee with the highest salary per department.
-- Output the department name, employee's first name along with the corresponding salary.
-- Create temporary table 'max_sal'
WITH max_sal AS
    (SELECT department,
            MAX(salary) as salary
    FROM employee
    GROUP BY 
        department)


-- Join employee table with max_sal table
SELECT e.department,
       e.first_name as employee_name,
       e.salary
FROM employee e
INNER JOIN max_sal m
        ON e.department = m.department
       AND e.salary = m.salary;

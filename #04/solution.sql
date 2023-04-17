-- PostgreSQL
-- Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments. 
-- Output just the absolute difference in salaries.

WITH max_salary AS
    (
    SELECT 
        department,
        MAX(salary) as salary
     FROM db_employee E
     JOIN db_dept D
     ON E.department_id =  D.id
     GROUP BY department
    )

SELECT (
    (SELECT salary FROM max_salary WHERE department='marketing') 
    -
    (SELECT salary FROM max_salary WHERE department='engineering')
) AS salary_differences;
